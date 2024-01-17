import 'package:flutter/material.dart';


class preferencesScreen extends StatefulWidget {
  const preferencesScreen({super.key});

  @override
  State<preferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<preferencesScreen> {
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
                      backgroundImage:
                          AssetImage('assets/images/preferences.png'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Preferences",
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
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Managing the Preferences",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "'preference' elements are name value combination which can be set or retrieved through web Application API.",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
              
                      Container(
                        height: 300,
                        width: 700,
                        
                        decoration: BoxDecoration(border: Border.all()),
                        ),
                   
                      
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
