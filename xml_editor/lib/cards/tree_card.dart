import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import '../main.dart';

class treeCard extends StatefulWidget {
  const treeCard({super.key});

  @override
  State<treeCard> createState() => _treeCardState();
}

class _treeCardState extends State<treeCard> {
  List<Widget> _xmlTree = [];

  @override
  void initState() {
    super.initState();
    _loadXmlDocument();
  }

  Future<void> _loadXmlDocument() async {
    final xmlDocument = xml.XmlDocument.parse(xmlcode);
    _xmlTree = _generateXmlTree(xmlDocument.rootElement, 0);
    setState(() {});
  }

  List<Widget> _generateXmlTree(xml.XmlElement element, int indentationLevel) {
    final tree = <Widget>[];

    tree.add(ExpandableXmlElement(element));

    return tree;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: _xmlTree.length,
            itemBuilder: (context, index) {
              return _xmlTree[index];
            },
          ),
        ),
      ),
    );
  }
}

class ExpandableXmlElement extends StatefulWidget {
  final xml.XmlElement element;

  const ExpandableXmlElement(this.element, {super.key});

  @override
  _ExpandableXmlElementState createState() => _ExpandableXmlElementState();
}

class _ExpandableXmlElementState extends State<ExpandableXmlElement> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final element = widget.element;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child:
                  Icon(isExpanded ? Icons.arrow_drop_down : Icons.arrow_right),
            ),
            Text(
              element.name.local,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                ),
            ),
            if (element.attributes.isNotEmpty)
              Expanded(
                child: Text(
                    // ' ${element.attributes.map((a) => '${a.name.local}="${a.value}"').join(' ')}'
                    ' ${element.attributes.first}',
                    
                    ),
              ),
          ],
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: element.children
                  .whereType<xml.XmlElement>()
                  .map((childElement) => ExpandableXmlElement(childElement))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
