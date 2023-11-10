import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart';
import 'package:file_picker/file_picker.dart';

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

  runApp(MyApp(["lib/config.xml"]));
}

Future<void> _handleCommandLineArguments(List<String> args) async {
  try {
    var fileContent = File(args[0]);
    xmlcode = fileContent.readAsStringSync();
    XmlDocument.parse(xmlcode);
  } catch (e) {
    print("hii");
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

      var targetFElement = document.rootElement.findElements('content').last;
      var indexF = document.rootElement.children.indexOf(targetFElement);

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

      var targetPElement = document.rootElement.findElements('name').last;
      var indexP = document.rootElement.children.indexOf(targetPElement);
      for (var element in selectedPrivileges) {
        XmlElement newPrivilegeElement = XmlElement(
          XmlName('tizen:privilege'),
          [XmlAttribute(XmlName('name'), element.priv)],
        );

        if (!document.rootElement
            .findElements('tizen:privilege')
            .any((data) => data.getAttribute("name") == element.priv)) {
          var targetPElement = document.rootElement.findElements('name').last;
          var indexP = document.rootElement.children.indexOf(targetPElement);
          document.rootElement.children.insert(indexP + 1, newPrivilegeElement);
        }
      }
      // var lenOffeature =
      //     document.rootElement.children
      //         .indexOf(document.rootElement.findAllElements('feature').last)-(indexF + 1);

      for (var element in selectedfeatures) {
        XmlElement newFeatureElement = XmlElement(XmlName('feature'), [
          XmlAttribute(XmlName('name'), element.feature),
        ]);
        print("#");
        print(document.rootElement
            .findElements("feature")
            .any((data) => data.getAttribute("name") != element.feature));
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

  void _filepicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['xml'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _handleCommandLineArguments([file.path]);
      });
    } else {
      print("Fail!");
    }
  }

  List<BarButton> _menuBarButtons(
      List<features> selectedfeatures, List<privilages> selectedPrivileges) {
    return [
      BarButton(
        text: const Text(
          'File',
          style: TextStyle(color: Colors.white),
        ),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
              onTap: () {
                validation(selectedfeatures, selectedPrivileges);
                _writefile(widget.args);
              },
              text: const Text('Save'),
              shortcutText: 'Ctrl+S',
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyS, control: true),
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Save as'),
              shortcutText: 'Ctrl+Shift+S',
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {
                setState(() {
                  _filepicker();
                });
              },
              text: const Text('Open File'),
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Open Folder'),
            ),
            const MenuDivider(),
            MenuButton(
              text: const Text('Preferences'),
              icon: const Icon(Icons.settings),
              submenu: SubMenu(
                menuItems: [
                  MenuButton(
                    onTap: () {},
                    icon: const Icon(Icons.keyboard),
                    text: const Text('Shortcuts'),
                  ),
                  const MenuDivider(),
                  MenuButton(
                    onTap: () {},
                    icon: const Icon(Icons.extension),
                    text: const Text('Extensions'),
                  ),
                  const MenuDivider(),
                  MenuButton(
                    icon: const Icon(Icons.looks),
                    text: const Text('Change theme'),
                    submenu: SubMenu(
                      menuItems: [
                        MenuButton(
                          onTap: () {},
                          icon: const Icon(Icons.light_mode),
                          text: const Text('Light theme'),
                        ),
                        const MenuDivider(),
                        MenuButton(
                          onTap: () {},
                          icon: const Icon(Icons.dark_mode),
                          text: const Text('Dark theme'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              shortcutText: 'Ctrl+Q',
              text: const Text('Exit'),
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      BarButton(
        text: const Text(
          'Edit',
          style: TextStyle(color: Colors.white),
        ),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
              onTap: () {},
              text: const Text('Undo'),
              shortcutText: 'Ctrl+Z',
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Redo'),
              shortcutText: 'Ctrl+Y',
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              text: const Text('Cut'),
              shortcutText: 'Ctrl+X',
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Copy'),
              shortcutText: 'Ctrl+C',
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Paste'),
              shortcutText: 'Ctrl+V',
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              text: const Text('Find'),
              shortcutText: 'Ctrl+F',
            ),
          ],
        ),
      ),
      BarButton(
        text: const Text(
          'Help',
          style: TextStyle(color: Colors.white),
        ),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
              onTap: () {},
              text: const Text('Check for updates'),
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              text: const Text('View License'),
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              icon: const Icon(Icons.info),
              text: const Text('About'),
            ),
          ],
        ),
      ),
    ];
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
            builder: (context, featurevalue, child) => MenuBarWidget(
              barButtons: _menuBarButtons(
                  featurevalue.selectedfeatures, privvalue.selectedPrivileges),
              barStyle: const MenuStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
                backgroundColor: MaterialStatePropertyAll(Color(0xFF2b2b2b)),
                maximumSize:
                    MaterialStatePropertyAll(Size(double.infinity, 28.0)),
              ),
              barButtonStyle: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 6.0)),
                minimumSize: MaterialStatePropertyAll(Size(0.0, 32.0)),
              ),
              menuButtonStyle: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size.fromHeight(36.0)),
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0)),
              ),
              enabled: true,
              child: Scaffold(
                body: Row(
                  children: [
                    card_center(widget.args),
                    Expanded(
                      flex: 1,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 500.0),
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
      ),
    );
  }
}
