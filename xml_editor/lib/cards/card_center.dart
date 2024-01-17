
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/features_items.dart';
import '../providers/privilege_items.dart';
import '../screens/features_screen.dart';
import '../screens/sources_screen.dart';
import '../screens/Tizen_screen.dart';
import '../screens/localization_screen.dart';
import '../screens/overview_screen.dart';
import '../screens/policy_screen.dart';
import '../screens/preferences_screen.dart';
import '../screens/privileges_screen.dart';

class card_center extends StatefulWidget {
  final List<String> args;
  const card_center(this.args, {super.key});

  @override
  State<card_center> createState() => _card_centerState();
}

class _card_centerState extends State<card_center> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 500.0),
        child: Card(
          margin: const EdgeInsets.all(10.0),
          elevation: 5.0,
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextButton(
                              child: Text(
                                "Overview",
                                style: TextStyle(
                                    color: navMenuState == NavMenuItem.overview
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  navMenuState = NavMenuItem.overview;
                                });
                              },
                            )),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                              child: Text(
                                "Features",
                                style: TextStyle(
                                    color: navMenuState == NavMenuItem.features
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  navMenuState = NavMenuItem.features;
                                });
                              }),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                            child: Text(
                              "Privileges",
                              style: TextStyle(
                                  color: navMenuState == NavMenuItem.privileges
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                            onPressed: () {
                              setState(() {
                                navMenuState = NavMenuItem.privileges;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                              child: Text(
                                "Localization",
                                style: TextStyle(
                                    color: navMenuState ==
                                            NavMenuItem.Localization
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  navMenuState = NavMenuItem.Localization;
                                });
                              }),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                              child: Text(
                                "Policy",
                                style: TextStyle(
                                    color: navMenuState == NavMenuItem.Policy
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  navMenuState = NavMenuItem.Policy;
                                });
                              }),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                              child: Text(
                                "Preferences",
                                style: TextStyle(
                                    color:
                                        navMenuState == NavMenuItem.Preferences
                                            ? Colors.blue
                                            : Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  navMenuState = NavMenuItem.Preferences;
                                });
                              }),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                              child: Text(
                                "Tizen",
                                style: TextStyle(
                                    color: navMenuState == NavMenuItem.tizen
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  navMenuState = NavMenuItem.tizen;
                                });
                              }),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                              child: Text(
                                "Source",
                                style: TextStyle(
                                    color: navMenuState == NavMenuItem.source
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  navMenuState = NavMenuItem.source;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              if (navMenuState == NavMenuItem.overview)
                const Expanded(child: OverviewScreen()),
              if (navMenuState == NavMenuItem.features)
                Consumer<featuresList>(
                    builder: (context, fvalue, child) =>
                        Expanded(child: featuresScreen(fvalue))),
              if (navMenuState == NavMenuItem.privileges)
                Consumer<privilagesList>(
                    builder: (context, pvalue, child) =>
                        Expanded(child: PrivilegesScreen(pvalue))),
              if (navMenuState == NavMenuItem.Localization)
                const Expanded(child: LocalizationScreen()),
              if (navMenuState == NavMenuItem.Policy)
                const Expanded(child: policyScreen()),
              if (navMenuState == NavMenuItem.Preferences)
                const Expanded(child: preferencesScreen()),
              if (navMenuState == NavMenuItem.tizen)
                const Expanded(child: TizenScreen()),
              if (navMenuState == NavMenuItem.source)
                const Expanded(child: SourcesScreen()),
            ],
          ),
        ),
      ),
    );
  }
}