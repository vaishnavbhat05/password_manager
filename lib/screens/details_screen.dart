import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/password_bloc.dart';
import '../model/password_data.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  final String websiteName;
  final String userId;
  final String password;
  final String websiteLink;
  DetailsScreen(
      {super.key,
      required this.id,
      required this.userId,
      required this.password,
      required this.websiteName,
      required this.websiteLink});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool light = true;
  bool _isDetailsVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_backspace,
                  size: 30,
                )),
          ),
          const Text(
            'back',
            style: TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  context
                      .read<PasswordBloc>()
                      .add(DeletePasswordEvent(widget.id));
                  context.read<PasswordBloc>().add(LoadPasswordsEvent());
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 30,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      widget.websiteName[0],
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.websiteName,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.userId,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
                right: 30,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isDetailsVisible = !_isDetailsVisible;
                  });
                },
                child: Row(
                  children: [
                    const Text(
                      'Details & Settings',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 150),
                    _isDetailsVisible
                        ? const Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                          )
                        : const Icon(
                            Icons.keyboard_arrow_up,
                            size: 30,
                          ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 30),
              child: Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
            ),
            Visibility(
              visible: _isDetailsVisible,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Link',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 70),
                        TextButton(
                            onPressed: () {},
                            child: Text(widget.websiteLink,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue)))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'user id',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 60),
                        Text(widget.userId,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 30),
                        Text(widget.password,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Autofill',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 47),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.password));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${widget.password} copied!')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text('copy password',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54))),
                  const SizedBox(width: 20),
                  OutlinedButton(
                      onPressed: () {
                        // _updatePassword(context, PasswordData(
                        //   id: widget.id,
                        //   websiteName: widget.websiteName,
                        //   userId: widget.userId,
                        //   websiteLink: widget.websiteLink,
                        //   password: widget.password,
                        // ));
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text('change password',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _updatePassword(BuildContext context, PasswordData passwordData) {
    TextEditingController newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: TextField(
            controller: newPasswordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Enter new password'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newPasswordController.text.isNotEmpty) {
                  PasswordData updatedPassword = PasswordData(
                    id: passwordData.id,
                    websiteName: passwordData.websiteName,
                    userId: passwordData.userId,
                    websiteLink: passwordData.websiteLink,
                    password: newPasswordController.text,
                  );

                  BlocProvider.of<PasswordBloc>(context).add(UpdatePasswordEvent(updatedPassword));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

}
