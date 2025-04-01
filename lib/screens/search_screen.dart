import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager_app/screens/details_screen.dart';

import '../bloc/password_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            const Spacer(),
            Container(
              color: Colors.grey[200],
              width: 370,
              height: 60,
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 0.1, color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 0.1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 0.1, color: Colors.grey),
                  ),
                  suffixIcon:
                      Icon(Icons.search, size: 30, color: Colors.black54),
                  hintText: 'Search Here',
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
            ),
            const Spacer(),
          ],
        ),
        body: BlocBuilder<PasswordBloc, PasswordState>(
          builder: (context, state) {
            if (state is PasswordLoaded) {
              final filteredPasswords = state.passwords.where((password) {
                return _searchQuery.length < 3 ||
                    password.websiteName
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
              }).toList();

              return ListView.builder(
                itemCount: filteredPasswords.length,
                itemBuilder: (context, index) {
                  final password = filteredPasswords[index];
                  return ListTile(
                    title: Text(
                      password.websiteName,
                      style: const TextStyle(fontSize: 18),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        password.websiteName[0],
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    subtitle: Text(password.userId),
                    trailing: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: password.password));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('${password.password} copied!')),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                id: password.id!,
                                    userId: password.userId,
                                    websiteName: password.websiteName,
                                    websiteLink: password.websiteLink,
                                    password: password.password,
                                  )));
                    },
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
