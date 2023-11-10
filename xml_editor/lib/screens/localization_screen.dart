// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LocalizationScreen extends StatefulWidget {
  const LocalizationScreen({super.key});

  @override
  State<LocalizationScreen> createState() => _LocalizationScreenState();
}

class _LocalizationScreenState extends State<LocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/features.png'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Localization",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Managing the Localisation",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Localisation for selected node elements of config.xml",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                      DialogExample("Name"),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      DialogExample("Description"),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      DialogExample("License"),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  String title;
  DialogExample(this.title, {super.key}) ;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(title),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => const Dialog(
                    child: SizedBox(
                  width: 700,
                  height: 750,
                  child: Scaffold(),
                )),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const IconButton(onPressed: null, icon: Icon(Icons.delete)),
          ],
        ),
      ],
    );
  }
}
