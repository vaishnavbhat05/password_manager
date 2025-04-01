import 'package:flutter/material.dart';
import 'package:password_manager_app/screens/settings/profile_screen.dart';

import '../main_page.dart';
import '../add_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool light = true;
  bool light1 = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.person_outline_sharp,
                size: 30,
              ),
            ),
            const Spacer(),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 26),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPasswordScreen()));
                },
                icon: const Icon(
                  Icons.add_sharp,
                  size: 32,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: InkWell(
                onTap: () {
                  context
                      .findAncestorStateOfType<MainPageState>()
                      ?.navigateToProfile();
                },
                child: const Row(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      'Permissions',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    light = !light;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Sync',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: light,
                        onChanged: (bool value) {
                          setState(() {
                            light = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    light1 = !light1;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Autofill',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: light1,
                        onChanged: (bool value) {
                          setState(() {
                            light1 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      'About',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Help',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Version',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    '1.1.1',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
