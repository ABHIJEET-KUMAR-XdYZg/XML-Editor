import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart';


import '../blocs/blocs.dart';
import '../cards/tree_card.dart';
import '../modals/features.dart';
import '../modals/privilages.dart';
import '../providers/features_items.dart';
import '../providers/privilege_items.dart';
import 'cards/card_center.dart';

enum filetype {
  config,
  manifest,
}

enum NavMenuItem {
  overview,
  features,
  privileges,
  Localization,
  Policy,
  Preferences,
  tizen,
  source,
}

final bloc = Bloc();
String xmlcode = "";

void main(List<String> args) {
  _handleCommandLineArguments(["lib/config.xml"]);

  runApp(const MyApp(["lib/config.xml"]));
}

Future<void> _handleCommandLineArguments(List<String> args) async {
  try {
    var fileContent = File(args[0]);
    xmlcode = fileContent.readAsStringSync();
    XmlDocument.parse(xmlcode);
  } catch (e) {
    print("Error in cmdline");
  }
}

NavMenuItem navMenuState = NavMenuItem.overview;

void validation(
    List<features> selectedfeatures, List<privilages> selectedPrivileges) {
  try {
    if (navMenuState == NavMenuItem.source &&
        selectedPrivileges.isEmpty &&
        selectedfeatures.isEmpty) {
      XmlDocument document = XmlDocument.parse(xmlcode);
      xmlcode = document.toXmlString(pretty: true);
      bloc.updatecontent(xmlcode);
    } else {
      XmlDocument document = XmlDocument.parse(xmlcode);
      //Trageting the features
      var targetFElement = document.rootElement.findElements('content').last;
      var indexF = document.rootElement.children.indexOf(targetFElement);

      //inserting the features
      for (var element in selectedfeatures) {
        XmlElement newFeatureElement = XmlElement(XmlName('feature'), [
          XmlAttribute(XmlName('name'), element.feature),
        ]);

        if (!document.rootElement
            .findElements('feature')
            .any((data) => data.getAttribute("name") == element.feature)) {
          document.rootElement.children.insert(indexF + 1, newFeatureElement);
        }
      }

      //Targeting the privileges

      var targetPElement = document.rootElement.findElements('name').last;
      var indexP = document.rootElement.children.indexOf(targetPElement);

      for (var element in selectedPrivileges) {
        XmlElement newPrivilegeElement = XmlElement(
          XmlName('tizen:privilege'),
          [XmlAttribute(XmlName('name'), element.priv)],
        );

        //inserting the privileges
        if (!document.rootElement
            .findElements('tizen:privilege')
            .any((data) => data.getAttribute("name") == element.priv)) {
          document.rootElement.children.insert(indexP + 1, newPrivilegeElement);
        }
      }

      //removing extra features in xmlfile
      List xmlitems = document.rootElement
          .findAllElements("feature")
          .map((e) => e.getAttribute("name"))
          .toList();
      List listitems = selectedfeatures.map((e) => e.feature).toList();
      for (var element in xmlitems) {
        if (!listitems.contains(element)) {
          // document.findAllElements('feature').where((element) => element.getAttribute(name)))
          document
              .findAllElements('feature')
              .where((data) => data.getAttribute("name") == element)
              .forEach((element) {
            element.remove();
          });
        }
      }

      //removing extra privileges in xmlfile
      List xmlitem2 = document.rootElement
          .findAllElements("tizen:privilege")
          .map((e) => e.getAttribute("name"))
          .toList();
      List listitems2 = selectedPrivileges.map((e) => e.priv).toList();

      for (var element in xmlitem2) {
        if (!listitems2.contains(element)) {
          document
              .findAllElements('tizen:privilege')
              .where((data) => data.getAttribute("name") == element)
              .forEach((element) {
            element.remove();
          });
        }
      }

      xmlcode = document.toXmlString(pretty: true);
      bloc.updatecontent(xmlcode);
    }
  } catch (e) {
    bloc.updateerror("$e");
  }
}

class MyApp extends StatefulWidget {
  final List<String> args;
  const MyApp(this.args, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _writefile(List<String> args) async {
    try {
      XmlDocument document = XmlDocument.parse(xmlcode);
      File(args[0]).writeAsStringSync(document.toXmlString(pretty: true));
      bloc.updateerror("");
    } catch (e) {
      bloc.updateerror(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => featuresList(),
          ),
          ChangeNotifierProvider(
            create: (context) => privilagesList(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Web config Xml Editor',
            home: Consumer<privilagesList>(
              builder: (context, privvalue, child) => Consumer<featuresList>(
                builder: (context, featurevalue, child) => Scaffold(
                  body: Shortcuts(
                    shortcuts: <LogicalKeySet, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.control,
                          LogicalKeyboardKey.keyS): const ActivateIntent(),
                    },
                    child: Focus(
                      onKey: (node, event) {
                        if (event.isControlPressed &&
                            event.logicalKey.keyId ==
                                LogicalKeyboardKey.keyS.keyId) {
                          validation(featurevalue.selectedfeatures,
                              privvalue.selectedPrivileges);
                          _writefile(widget.args);
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: Row(
                        children: [
                          card_center(widget.args),
                          Expanded(
                            flex: 1,
                            child: ConstrainedBox(
                              constraints:
                                  const BoxConstraints(minHeight: 500.0),
                              child: const Card(
                                margin: EdgeInsets.all(10.0),
                                elevation: 5.0,
                                child: treeCard(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
    //     ),
    //   ),
    // );
  }
}
