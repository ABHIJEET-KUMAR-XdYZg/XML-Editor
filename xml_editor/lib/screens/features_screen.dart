import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tizen_privilages/main.dart';
import 'package:xml/xml.dart';

import '../dialog_box/add_features.dart';
import '../modals/features.dart';
import '../providers/features_items.dart';

List finalfeatureslist = [];

class featuresScreen extends StatefulWidget {
  final featuresList value;
  const featuresScreen(this.value, {super.key});

  @override
  State<featuresScreen> createState() => _featuresScreenState();
}

bool loading = false;

class _featuresScreenState extends State<featuresScreen> {
  @override
  void initState() {
    super.initState();
    readFile().then((value) {
      String result = value!.join('');

      XmlDocument xmlDocument = XmlDocument.parse(result);
      XmlElement rootelement = xmlDocument.rootElement;

      Iterable<XmlElement> entryelements = rootelement.findAllElements('entry');
      int index = 0;

      for (var entry in entryelements) {
        widget.value.initializedfeatList(features(
            id: "f${index++}",
            title: entry.getAttribute('desc')!,
            feature: entry.getAttribute('key')!,
            used: false));
      }

      if (loading == false) {
        final document = XmlDocument.parse(xmlcode);

        document.rootElement
            .findAllElements("feature")
            .toList()
            .forEach((data) {
          for (var element in widget.value.featureitems) {
            if (element.feature == data.getAttribute("name")) {
              widget.value.addfeatures(element.id);
            }
          }
        });
      }

      loading = true;
    });
  }

  Future<List<String>?> readFile() async {
    try {
      String contents = await rootBundle
          .loadString('assets/properties/features/feature-wrt.properties');
      List<String> lines = contents.split('\n');
      return lines;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/features.png'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Features",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Required Features",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "You can declare software or hardware features. This declaration can be used for application filtering on Tizen market place.",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                      DialogExample(
                        value: widget.value,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DialogExample extends StatefulWidget {
  final featuresList value;
  const DialogExample({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  var _deleteditem = features(id: "", title: "", feature: "", used: false);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  String? newData = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                              child: SizedBox(
                            width: 700,
                            height: 750,
                            child: addFeatures(widget.value),
                          )));
                  if (newData == 'Cancel') {
                    widget.value.selectedfeatures.clear();
                  }
                  if (newData == 'Ok') {
                    finalfeatureslist = widget.value.selectedfeatures;
                  }
                }),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.value.removeitem(_deleteditem.id);
                });
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all()),
          child: ListView.builder(
            itemCount: widget.value.selectedfeatures.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      _deleteditem = widget.value.selectedfeatures[index];
                    },
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      margin: EdgeInsets.only(left: 5, top: 2, right: 5),
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(widget.value.selectedfeatures[index].feature,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),),
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
