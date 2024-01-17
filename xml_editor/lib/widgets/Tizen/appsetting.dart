import 'package:flutter/material.dart';


class AppSettingsForm extends StatefulWidget {
  const AppSettingsForm({super.key});

  @override
  _AppSettingsFormState createState() => _AppSettingsFormState();
}

class _AppSettingsFormState extends State<AppSettingsForm> {
  String screenOrientationValue = 'Portrait';
  String contextMenuValue = 'Enable';
  String backgroundSupportValue = 'Disable';
  String encryptionValue = 'Enable';
  String installLocationValue = 'Auto';
  String hwKeyEventValue = 'Disable';
  String soundModeValue = 'None';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: screenOrientationValue,
              onChanged: (String? newValue) {
                setState(() {
                  screenOrientationValue = newValue!;
                });
              },
              items: <String>['Portrait', 'Landscape', 'Auto Rotate']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Screen Orientation: $value'),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: contextMenuValue,
              onChanged: (String? newValue) {
                setState(() {
                  contextMenuValue = newValue!;
                });
              },
              items: <String>['Enable', 'Disable']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Context Menu: $value'),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: backgroundSupportValue,
              onChanged: (String? newValue) {
                setState(() {
                  backgroundSupportValue = newValue!;
                });
              },
              items: <String>['Enable', 'Disable']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Background Support: $value'),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: encryptionValue,
              onChanged: (String? newValue) {
                setState(() {
                  encryptionValue = newValue!;
                });
              },
              items: <String>['Enable', 'Disable']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Encryption: $value'),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: installLocationValue,
              onChanged: (String? newValue) {
                setState(() {
                  installLocationValue = newValue!;
                });
              },
              items: <String>['Auto', 'Internal Only', 'Prefer External']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Install Location: $value'),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: hwKeyEventValue,
              onChanged: (String? newValue) {
                setState(() {
                  hwKeyEventValue = newValue!;
                });
              },
              items: <String>['Enable', 'Disable']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('HW Key Event: $value'),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        DropdownButton<String>(
          value: soundModeValue,
          onChanged: (String? newValue) {
            setState(() {
              soundModeValue = newValue!;
            });
          },
          items: <String>['None', 'Shared', 'Exclusive']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('Sound Mode: $value'),
            );
          }).toList(),
        ),
      ],
    );
  }
}
