import 'package:flutter/material.dart';

import '../main.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({super.key});

  @override
  _SourcesScreenState createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  void initState() {
    super.initState();
    bloc.updatecontent(xmlcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StreamBuilder<String>(
                stream: bloc.content,
                initialData: xmlcode,
                builder: (context, snapshot) {
                  return TextField(
                    controller: TextEditingController(text: snapshot.data),
                    maxLines: 25,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      xmlcode = value;
                    },
                  );
                }
              ),
              const SizedBox(height: 20,),
              StreamBuilder<String>(
                  stream: bloc.error,
                  initialData: "",
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        Text(snapshot.data.toString()),

                        const SizedBox(
                          height: 20,
                        ),
                        Text(snapshot.data.toString()==""? "Valid Xml":"Not valid",
                        style: TextStyle(
                          color: snapshot.data.toString() == ""?Colors.green:Colors.red
                        ),)
                      ],
                    );
                  }
                ),              
            ],
          ),
        ),
      ),
    );
  }
}
