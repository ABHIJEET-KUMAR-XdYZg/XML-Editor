import 'package:flutter/material.dart';

import '/dialog_box/add_privilages.dart';

class custom extends StatelessWidget {
  final Function func;
  const custom(this.func, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: RadioListTile(
            title: const Text('Custom Privilages'),
            value: privilegesoptions.custom,
            groupValue: privile,
            onChanged: (value) {
              func(value);
            },
          ),
        ),
        Flexible(
          child: AbsorbPointer(
            absorbing: privile == privilegesoptions.custom ? false : true,
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 40,
              child: TextFormField(
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  labelText: "Add Custom privilages",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ),
        )
      ],
    );
  
  }
}
