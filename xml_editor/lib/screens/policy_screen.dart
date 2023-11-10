import 'package:flutter/material.dart';
class policyScreen extends StatefulWidget {
  const policyScreen({super.key});

  @override
  State<policyScreen> createState() => _policyScreenState();
}

class _policyScreenState extends State<policyScreen> {
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
                      backgroundImage: AssetImage('assets/images/policy.png'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Policy",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const Expanded(
              child: PolicyPage(),
            )
          ],
        ),
      ),
    );
  }
}

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  _PolicyPageState createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  final TextEditingController _contentSecurityPolicyController =
      TextEditingController();
  final TextEditingController _contentSecurityPolicyReportOnlyController =
      TextEditingController();
  final TextEditingController _allowNavigationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                        "Managing the Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "This section describes the URL navigation and content security policy for web application.",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 70,
                    ),
                    const SizedBox(
                      width: 150,
                      child: Text('content-security-policy'),
                    ),
                    const SizedBox(
                      width: 50,
                      height: 70,
                    ),
                    Expanded(
                      child: TextField(
                          controller: _contentSecurityPolicyController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(1.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ))),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 70,
                    ),
                    const SizedBox(
                      width: 150,
                      child: Text('content-security-policy-report-only'),
                    ),
                    const SizedBox(
                      width: 50,
                      height: 70,
                    ),
                    Expanded(
                      child: TextField(
                          controller: _contentSecurityPolicyReportOnlyController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(1.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ))),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 70,
                    ),
                    const SizedBox(
                      width: 150,
                      child: Text('allow-navigation'),
                    ),
                    const SizedBox(
                      width: 50,
                      height: 70,
                    ),
                    Expanded(
                      child: TextField(
                          controller: _allowNavigationController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(1.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 29.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Access',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Network URL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Allow subdomain',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                      const TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('http://yourserverdomain/'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('true'),
                        ),
                      ]),
                      const TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                      ]),
                      const TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                      ]),
                    ],
                    border: TableBorder.all(color: Colors.grey, width: 1.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
