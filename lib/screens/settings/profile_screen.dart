import 'package:flutter/material.dart';
import 'package:password_manager_app/screens/add_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedSubject = "Steve's Team";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.person,
              size: 30,
            ),
          ),
          const Spacer(),
          const Text(
            'Profile',
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
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(radius: 50),
            const SizedBox(height: 20),
            const Text(
              'Steve Smith',
              style: TextStyle(fontSize: 28),
            ),
            const Text(
              '8273845095',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Edit profile',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Switch account',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: selectedSubject.length + 150,
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() {
                          selectedSubject = value;
                        });
                      },
                      itemBuilder: (context) => [
                        for (var subject in [
                          "Steve's Team",
                          "Rodriguez Team",
                          "baron Team",
                        ])
                          PopupMenuItem<String>(
                            value: subject,
                            child: Text(subject),
                          ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey[300],
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedSubject,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              width: selectedSubject.length - 10,
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Security',
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Trusted devices',
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Backup',
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
          ],
        ),
      ),
    );
  }
}
