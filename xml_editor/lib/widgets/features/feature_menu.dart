import 'package:flutter/material.dart';
import '../../providers/features_items.dart';

class Features_internal_menu extends StatefulWidget {
  final featuresList value;
  const Features_internal_menu(this.value, {super.key});

  @override
  State<Features_internal_menu> createState() => _Features_internal_menuState();
}

class _Features_internal_menuState extends State<Features_internal_menu> {
  String _description = "Description";

  void func(value) {
    setState(() {
      _description = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                  itemCount: widget.value.featureitems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          child: featurescheckList(func, widget.value, index),
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
                  hintMaxLines: 4,
                  labelStyle: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class featurescheckList extends StatefulWidget {
  final Function func;
  final featuresList value;

  const featurescheckList(this.func, this.value, this.index, {super.key});
  final index;

  @override
  State<featurescheckList> createState() => _featurescheckListState();
}

class _featurescheckListState extends State<featurescheckList> {
  @override
  Widget build(BuildContext context) {
    var featureprovider = widget.value;
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        featureprovider.featureitems[widget.index].feature,
        style: const TextStyle(fontSize: 15),
      ),
      value: featureprovider.featureitems[widget.index].used,
      onChanged: (value) {
        setState(() {
          widget.func(featureprovider.featureitems[widget.index].title);
          featureprovider
              .addfeatures(featureprovider.featureitems[widget.index].id);
        });
      },
      checkColor: Colors.white,
      activeColor: Colors.blue,
    );
  }
}
