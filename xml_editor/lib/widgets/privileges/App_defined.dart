import 'package:flutter/material.dart';
import '/dialog_box/add_privilages.dart';

class appDefinedPrivilege extends StatefulWidget {
  final Function func;
  const appDefinedPrivilege(this.func, {super.key});

  @override
  State<appDefinedPrivilege> createState() => _appDefinedPrivilegeState();
}

class _appDefinedPrivilegeState extends State<appDefinedPrivilege> {
  @override
  Widget build(BuildContext context) {
    bool license = false;
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: RadioListTile(
            title: const Text('App-defined privile'),
            value: privilegesoptions.App_defined,
            groupValue: privile,
            onChanged: (value) {
              widget.func(value);
            },
          ),
        ),
        Flexible(
          flex: 3,
          child: AbsorbPointer(
            absorbing: privile == privilegesoptions.App_defined ? false : true,
            child: Container(
                margin: const EdgeInsets.all(10),
                height: 100,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    constraints: BoxConstraints(maxHeight: 10)),
                                items: const [
                                  DropdownMenuItem(
                                    value: add_def_privilages.provider,
                                    child: Text("Provider"),
                                  ),
                                  DropdownMenuItem(
                                    value: add_def_privilages.consumer,
                                    child: Text("Consumer"),
                                  )
                                ],
                                value: add_def_privilages.provider,
                                onChanged: (value) {
                                 
                                }),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    title: const Text(
                                      "License",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: license,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        license = newValue!;
                                        print(license);
                                      });
                                    },
                                    checkColor: Colors.black,
                                    activeColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            enabled: license,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              labelText: "",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: TextFormField(
                        style: const TextStyle(fontSize: 10),
                        decoration: const InputDecoration(
                          labelText: "Add Custom privilages",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
