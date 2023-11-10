import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  String selectedRequiredVersion = '5.5';
  String selectedLaunchMode = 'none';
  String selectedAmbientSupport = 'disable';

  TextEditingController idController = TextEditingController();

  void _generate() {
    // Add your logic for the 'Generate' button here
    // You can access the entered text using idController.text
    print('Generate button clicked');
    print('ID: ${idController.text}');
    print('Required Version: $selectedRequiredVersion');
    print('Launch Mode: $selectedLaunchMode');
    print('Ambient Support: $selectedAmbientSupport');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add some spacing
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: idController,
                        decoration: const InputDecoration(labelText: 'ID'),
                        enabled: false, // Disable the text field
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    const ElevatedButton(
                      onPressed: null, // Disable the button
                      child: Text('Generate'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedRequiredVersion,
                  onChanged: null, // Disable the dropdown
                  items:
                      <String>['5.5', 'Other Versions'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Required Version'),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedLaunchMode,
                  onChanged: null, // Disable the dropdown
                  items: <String>['none', 'other Launch Modes']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Launch Mode'),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedAmbientSupport,
                  onChanged: null, // Disable the dropdown
                  items: <String>['disable', 'other Ambient Support']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Ambient Support'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
