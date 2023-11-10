import 'package:flutter/material.dart';
import 'package:tizen_privilages/modals/privilages.dart';
import '../../screens/privileges_screen.dart';
import '../../providers/privilege_items.dart';
import '../../dialog_box/add_privilages.dart';

class internal extends StatelessWidget {
  final Function func;
  final privilagesList value;

  const internal(this.func, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: RadioListTile(
            title: const Text("Internal"),
            value: privilegesoptions.internal,
            groupValue: privile,
            onChanged: (value) {
              func(value);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: AbsorbPointer(
            absorbing: privile == privilegesoptions.internal ? false : true,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: internal_menu(value),
            ),
          ),
        )
      ],
    );
  }
}

class internal_menu extends StatefulWidget {
  final privilagesList value;
  const internal_menu(this.value, {super.key});

  @override
  State<internal_menu> createState() => _internal_menuState();
}

class _internal_menuState extends State<internal_menu> {
  String _description = "Description";
 

  

  void func(value) {
    setState(() {
      _description = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: TextFormField(
            style: const TextStyle(fontSize: 15),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Search",
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: SizedBox(
            width: 500,
            height: 175,
            child: ListView.builder(
              itemCount: widget.value.items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      child: !loadingpriv
                          ? const Center(
                              child: LinearProgressIndicator(),
                            )
                          : checkList(index, func, widget.value),
                    ),
                    const Divider()
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Description"),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 30,
          child: TextFormField(
            enabled: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: _description,
              labelStyle: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}

class checkList extends StatefulWidget {
  final Function func;
  final privilagesList value;
  const checkList(this.index, this.func, this.value, {super.key});
  final index;

  @override
  State<checkList> createState() => _checkListState();
}

class _checkListState extends State<checkList> {
  @override
  Widget build(BuildContext context) {
    List<privilages> privprovider = widget.value.items;
    
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        privprovider[widget.index].priv,
        style: const TextStyle(fontSize: 15),
      ),
      value: privprovider[widget.index].used,
      onChanged: (value) {
        setState(() {
          widget.func(privprovider[widget.index].title);
          widget.value.addPrivilages(privprovider[widget.index].id);
        });
      },
      checkColor: Colors.white,
      activeColor: Colors.blue,
    );
  }
}
