import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tizen_privilages/modals/features.dart';
import 'package:xml/xml.dart';

import '../dialog_box/add_privilages.dart';
import '../main.dart';
import '../modals/privilages.dart';
import '../providers/privilege_items.dart';

List finalpriviegelist = [];

class PrivilegesScreen extends StatelessWidget {
  final privilagesList value;
  const PrivilegesScreen(this.value, {super.key});

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
                      backgroundImage:
                          AssetImage('assets/images/privileges.png'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Privileges",
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
                        "Required Privilages",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "'tizen:privilege' element indicates what sensitive API or API groups this web application declares that it may attempt to access. ",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                      DialogExample(value),
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

bool loadingpriv = false;

class DialogExample extends StatefulWidget {
  final privilagesList value;

  const DialogExample(this.value, {super.key});

  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  @override
  void initState() {
    super.initState();
    readFile().then((value) {
      setState(() {
        String result = value!.join('');

        XmlDocument xmlDocument = XmlDocument.parse(result);
        XmlElement rootelement = xmlDocument.rootElement;

        Iterable<XmlElement> entryelements =
            rootelement.findAllElements('entry');
        int index = 0;

        for (var entry in entryelements) {
          widget.value.intialize(privilages(
              id: "p${index++}",
              title: entry.getAttribute('desc')!,
              priv: entry.getAttribute('key')!,
              used: false));
        }
        if (loadingpriv == false) {
          final document = XmlDocument.parse(xmlcode);

          document.rootElement
              .findAllElements("tizen:privilege")
              .toList()
              .forEach((data) {
            for (var element in widget.value.items) {
              if (element.priv == data.getAttribute("name")) {
                widget.value.addPrivilages(element.id);
              }
            }
          });
        }
        loadingpriv = true;
      });
    });
  }

  Future<List<String>?> readFile() async {
    try {
      String contents = await rootBundle
          .loadString('assets/properties/privileges/privilege-wrt.properties');
      List<String> lines = contents.split('\n');
      return lines;
    } catch (e) {
      print(e);
      return null;
    }
  }

  var _deleteditem = privilages(id: "", title: "", priv: "", used: false);

  void removeitem() {
    setState(() {
      widget.value.selectedPrivileges.remove(_deleteditem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                String? newData = await showDialog(
                  context: context,
                  builder: (context) => Dialog(
                      child: SizedBox(
                    width: 700,
                    height: 750,
                    child: addPrivilage(value: widget.value),
                  )),
                );
                if (newData == 'Cancel') {
                  widget.value.selectedPrivileges.clear();
                }
                if (newData == 'Ok') {
                  finalpriviegelist = widget.value.selectedPrivileges;
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
              icon: Icon(Icons.delete)),
        ],
      ),
      Container(
        padding: EdgeInsets.all(5),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all()),
        child: ListView.builder(
          itemCount: widget.value.selectedPrivileges.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    _deleteditem = widget.value.selectedPrivileges[index];
                  },
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    margin: EdgeInsets.only(left: 5, top: 2, right: 5),
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      widget.value.selectedPrivileges[index].priv,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const Divider()
              ],
            );
          },
        ),
      ),
    ]);
  }
}
