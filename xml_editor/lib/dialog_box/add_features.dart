import 'package:flutter/material.dart';

import '../screens/features_screen.dart';
import '../widgets/features/feature_menu.dart';
import '../providers/features_items.dart';

class addFeatures extends StatefulWidget {
  final featuresList value;
  const addFeatures(this.value, {super.key});

  @override
  State<addFeatures> createState() => _addFeaturesState();
}

class _addFeaturesState extends State<addFeatures> {
  bool isChecked = false;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Features")),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Column(
              children: [
                !loading
                    ? const Center(child: LinearProgressIndicator())
                    : Features_internal_menu(widget.value),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop('Ok');
                        },
                        child: const Text("Ok")),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop('Cancel');
                        },
                        child: const Text("Cancel")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
