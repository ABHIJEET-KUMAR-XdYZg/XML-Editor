import 'package:flutter/material.dart';
import 'package:tizen_privilages/widgets/Tizen/application.dart';
import 'package:tizen_privilages/widgets/Tizen/appsetting.dart';
import 'package:tizen_privilages/widgets/Tizen/sources.dart';


class TizenScreen extends StatelessWidget {
  const TizenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: Scaffold(
          body: Column(
            children: [
              Container(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/Tizen.png'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Tizen",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
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
                        "Managing the Tizen",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "This section describes Tizen specific information about this web application.",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 20,),
                      const Text("Application",
                      style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      const SizedBox(height: 5,),
                      Container(
                          height: 300,
                          width: 700,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Application(),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Content",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 75,
                          width: 700,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const SourceForm(),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Setting",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 300,
                          width: 700,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const AppSettingsForm(),
                        ),                     

                    ],
                  ),
                ),
              ),
            )

            ],
          ),
        ));
  }
}
