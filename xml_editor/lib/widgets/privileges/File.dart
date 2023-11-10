import 'package:flutter/material.dart';
import '/dialog_box/add_privilages.dart';

class File extends StatelessWidget {
  final Function func;
  const File(this.func, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: RadioListTile(
            title: const Text('File'),
            value: privilegesoptions.File,
            groupValue: privile,
            onChanged: (value) {
              func(value);
            },
          ),
        ),
        Flexible(
          child: AbsorbPointer(
            absorbing: privile == privilegesoptions.File ? false : true,
            child: Row(
              children: [
                Flexible(
                    child: Container(
                  margin: const EdgeInsets.all(15),
                  height: 40,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 10),
                    decoration: const InputDecoration(
                      labelText: "Add a file",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                )),
                ElevatedButton(onPressed: () {}, child: const Text("Browse"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
