import 'package:flutter/material.dart';
import 'package:tizen_privilages/main.dart';
import 'package:xml/xml.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
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
                      backgroundImage: AssetImage('assets/images/overview.png'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Overview",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const Expanded(
              child: WebAppForm(),
            )
          ],
        ),
      ),
    );
  }
}

class WebAppForm extends StatefulWidget {
  const WebAppForm({super.key});

  @override
  _WebAppFormState createState() => _WebAppFormState();
}

class _WebAppFormState extends State<WebAppForm> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _licenseUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _selectedViewMode = 'Maximize';

  bool _isImageUploaded = false;

  @override
  void initState() {
    super.initState();
    XmlDocument document = XmlDocument.parse(xmlcode);

    _identifierController.text = document.rootElement.attributes
        .firstWhere((p0) => p0.name.toString() == "id", orElse: ()=> XmlAttribute("id" as XmlName,""),)
        .value;

    var nameElements = document.rootElement.findElements("name");
    if (nameElements.isNotEmpty) {
      _nameController.text = nameElements.first.innerXml;
    } else {
      _nameController.text =
          ""; // Insert an empty string if "name" element is not found
    }


    var versionAttribute = document.rootElement.attributes.firstWhere(
      (p0) => p0.name.toString() == "version",
      orElse: () => XmlAttribute("version" as XmlName,""), // Insert an empty string if "version" attribute is not found
    );

    _versionController.text = document.rootElement.attributes
        .firstWhere(
          (p0) => p0.name.toString() == "version",
          orElse: () => XmlAttribute("version" as XmlName,""), // Insert an empty string if "version" attribute is not found
        )
        .value;



    var contentElements = document.rootElement.findElements("content");
    if (contentElements.isNotEmpty) {
      var attributes = contentElements.first.attributes;
      if (attributes.isNotEmpty) {
        _contentController.text = attributes.first.value;
      } else {
        _contentController.text =
            ""; // Insert an empty string if the first attribute of "content" is not found
      }
    } else {
      _contentController.text =
          ""; // Insert an empty string if "content" element is not found
    }

  }

  @override
  void dispose() {
    _identifierController.dispose();
    _nameController.dispose();
    _versionController.dispose();
    _contentController.dispose();
    _sourceController.dispose();
    _authorController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _licenseController.dispose();
    _licenseUrlController.dispose();
    _descriptionController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _uploadImage() {
    setState(() {
      _isImageUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final document = XmlDocument.parse(xmlcode);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "General Information",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "This section decribes general information about this web application ",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _identifierController,
              onChanged: (value) {
                document.rootElement.attributes
                    .firstWhere((p0) => p0.name.toString() == "id")
                    .value = value;
                xmlcode = document.toXmlString(pretty: true);
                bloc.updatecontent(xmlcode);
              },
              decoration: const InputDecoration(
                labelText: "identifier",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "name",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      document.rootElement
                          .findAllElements("name")
                          .first
                          .innerText = value;
                      xmlcode = document.toXmlString(pretty: true);
                      bloc.updatecontent(xmlcode);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _versionController,
                    decoration: const InputDecoration(
                      labelText: 'Version',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      document.rootElement.attributes
                          .firstWhere((p0) => p0.name.toString() == "version")
                          .value = value;
                      xmlcode = document.toXmlString(pretty: true);
                      bloc.updatecontent(xmlcode);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      document.rootElement
                          .findElements("content")
                          .firstWhere(
                              (element) => element.name.toString() == "content")
                          .attributes[0]
                          .value = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Browse Files'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              'Icon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: 'Source',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Browse '),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: _isImageUploaded
                  ? Image.network(
                      'https://example.com/your_uploaded_image.png',
                      fit: BoxFit.cover,
                    )
                  : const Center(child: Text('No Image Uploaded')),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Icon Image'),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            const Text(
              'Managing the Information',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),
            const Text(
              'This section describes specific features of the application',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Author',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Author',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(
                labelText: 'Website',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            const Text(
              'License',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _licenseController,
              decoration: const InputDecoration(
                labelText: 'License',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _licenseUrlController,
              decoration: const InputDecoration(
                labelText: 'License URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            const Text(
              'Managing the Application UI',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),
            const Text(
              'This section describes ui information of the application',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: _widthController,
                    decoration: const InputDecoration(
                      labelText: 'Width',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                      labelText: 'Height',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedViewMode,
              onChanged: (newValue) {
                setState(() {
                  _selectedViewMode = newValue!;
                });
              },
              items: ['Maximize', 'Minimize', 'Standard'].map((viewMode) {
                return DropdownMenuItem<String>(
                  value: viewMode,
                  child: Text(viewMode),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'View Mode',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
