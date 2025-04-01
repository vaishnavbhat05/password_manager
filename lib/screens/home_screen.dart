import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager_app/screens/add_password_screen.dart';
import '../bloc/password_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PasswordBloc>().add(LoadPasswordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Icon(
              Icons.person_outline_sharp,
              size: 30,
            ),
          ),
          const Spacer(),
          const Text(
            'Passwords',
            style: TextStyle(fontSize: 26),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPasswordScreen()),
                );
                context.read<PasswordBloc>().add(LoadPasswordsEvent()); // Reload data
              },
              icon: const Icon(
                Icons.add_sharp,
                size: 36,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          if (state is PasswordLoaded) {
            return ListView.builder(
              itemCount: state.passwords.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 90,
                  child: ListTile(
                    title: Text(
                      state.passwords[index].websiteName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        state.passwords[index].websiteName[0],
                        style: const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    subtitle: Text(
                      state.passwords[index].websiteLink,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy, color: Colors.black54),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: state.passwords[index].password));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('${state.passwords[index].password} copied!')),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
