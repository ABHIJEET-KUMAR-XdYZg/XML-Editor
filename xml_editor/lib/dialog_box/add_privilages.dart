// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '/providers/privilege_items.dart';
import '../widgets/privileges/App_defined.dart';
import '../widgets/privileges/File.dart';
import '../widgets/privileges/custom.dart';
import '../widgets/privileges/internal.dart';


enum privilegesoptions {
  internal,
  custom,
  File,
  App_defined,
}

enum add_def_privilages {
  provider,
  consumer,
}

add_def_privilages _dropdownvalue = add_def_privilages.provider;

privilegesoptions privile = privilegesoptions.internal;

class addPrivilage extends StatefulWidget {
  final privilagesList value;
  const addPrivilage({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<addPrivilage> createState() => _addPrivilageState();
}

class _addPrivilageState extends State<addPrivilage> {
  bool isChecked = false;

  void func(value) {
    setState(() {
      privile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add privileges")),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                internal(func, widget.value),
                const Divider(),
                custom(func),
                const Divider(),
                File(func),
                const Divider(),
                appDefinedPrivilege(func),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok")),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop("Cancel");
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
