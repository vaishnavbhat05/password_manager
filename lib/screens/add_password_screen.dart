import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../bloc/password_bloc.dart';
import '../common/slider_class.dart';
import '../model/password_data.dart';
import 'main_page.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _websiteNameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _websiteLinkController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _websiteNameNode = FocusNode();
  final FocusNode _userIdNode = FocusNode();
  final FocusNode _websiteLinkNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  bool? isSelected1 = false;
  bool? isSelected2 = false;
  bool? isSelected3 = false;
  bool? isSelected4 = false;

  Color _iconColor1 = Colors.grey;
  Color _iconColor2 = Colors.grey;
  Color _iconColor3 = Colors.grey;
  double _sliderValue = 8;

  double _passwordStrength = 0.0;
  Color _strengthColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_backspace,
                  size: 30,
                )),
          ),
          const SizedBox(width: 80),
          const Text(
            'New Record',
            style: TextStyle(fontSize: 24),
          ),
          const Spacer()
        ],
      ),
      body: BlocConsumer<PasswordBloc, PasswordState>(
        listener: (context, state) {
          if (state is PasswordStrengthUpdated) {
            setState(() {
              _passwordStrength = state.strength;
              _strengthColor = state.strengthColor;
            });
          }
          if (state is PasswordGenerated) {
            setState(() {
              _passwordController.text = state.password;
              _passwordStrength = state.strength;
              _strengthColor = state
                  .strengthColor;
            });
          }
          if (state is PasswordSaved) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage(index: 0)),
            );
          }
        },
        builder: (context, state) {
          if (state is PasswordGenerated) {
            _passwordController.text = state.password;
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text('Name', style: TextStyle(fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: SizedBox(
                            width: 160,
                            child: TextFormField(
                              controller: _websiteNameController,
                              focusNode: _websiteNameNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_websiteLinkNode);
                              },
                              decoration: const InputDecoration(
                                  hintText: 'website or app name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true),
                              onChanged: (value) {
                                setState(() {
                                  _iconColor1 = (value.isNotEmpty)
                                      ? Colors.green
                                      : Colors.grey;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter website name";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.check_circle_outline,
                          color: _iconColor1,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child:
                              Text('User id', style: TextStyle(fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 82),
                          child: SizedBox(
                            width: 160,
                            child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              controller: _userIdController,
                              focusNode: _userIdNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_websiteLinkNode);
                              },
                              decoration: const InputDecoration(
                                  hintText: 'username or email id',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true),
                              onChanged: (value) {
                                setState(() {
                                  _iconColor2 = (value.isNotEmpty)
                                      ? Colors.green
                                      : Colors.grey;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter website link";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Icon(
                          Icons.check_circle_outline,
                          color: _iconColor2,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text('Website link',
                              style: TextStyle(fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 36),
                          child: SizedBox(
                            width: 160,
                            child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              controller: _websiteLinkController,
                              focusNode: _websiteLinkNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordNode);
                              },
                              decoration: const InputDecoration(
                                  hintText: 'website link',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true),
                              onChanged: (value) {
                                setState(() {
                                  _iconColor3 = (value.isNotEmpty)
                                      ? Colors.green
                                      : Colors.grey;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter website link";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Icon(
                          Icons.check_circle_outline,
                          color: _iconColor3,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 35, top: 25),
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Password', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        height: 61,
                        width: 350,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: SizedBox(
                                    width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black),
                                        controller: _passwordController,
                                        focusNode: _passwordNode,
                                        onChanged: (password) {
                                          context.read<PasswordBloc>().add(
                                              CheckPasswordStrengthEvent(
                                                  password));
                                        },
                                        decoration: const InputDecoration(
                                            hintText: "Enter Password",
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(2),
                                            isDense: true),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter password";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<PasswordBloc>()
                                        .add(ResetPasswordEvent());
                                    setState(() {
                                      _passwordController.clear();
                                      _passwordStrength = 0.0;
                                      _strengthColor = Colors.grey;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9, vertical: 10),
                                    child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Image.asset(
                                            'assets/icons/reload.png')),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        left: -9,
                        child: LinearPercentIndicator(
                          width: 368,
                          lineHeight: 8,
                          percent: _passwordStrength,
                          progressColor: _strengthColor,
                          backgroundColor: Colors.grey[300]!,
                          barRadius: const Radius.circular(16),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text('Length', style: TextStyle(fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 65),
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              _sliderValue
                                  .toInt()
                                  .toString(), // Show the updated value
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 12,
                              thumbShape: CustomSliderThumbCircle(),
                              activeTrackColor: Colors.blue,
                              inactiveTrackColor: Colors.grey,
                            ),
                            child: Slider(
                              value: _sliderValue,
                              min: 0,
                              max: 30,
                              divisions: 30,
                              activeColor: Colors.blue,
                              inactiveColor: Colors.grey,
                              onChanged: (newValue) {
                                setState(() {
                                  _sliderValue = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child:
                              Text('Numbers', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 36),
                        Transform.scale(
                          scale: 1.4,
                          child: Checkbox(
                            value: isSelected1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(width: 1.0),
                            ),
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                isSelected1 = value;
                              });
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child:
                              Text('Symbols', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 45),
                        Transform.scale(
                          scale: 1.4,
                          child: Checkbox(
                            value: isSelected2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(width: 1.0),
                            ),
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                isSelected2 = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child:
                              Text('Lowercase', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 21),
                        Transform.scale(
                          scale: 1.4,
                          child: Checkbox(
                            value: isSelected3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(width: 1.0),
                            ),
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                isSelected3 = value;
                              });
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child:
                              Text('Uppercase', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 26),
                        Transform.scale(
                          scale: 1.4,
                          child: Checkbox(
                            value: isSelected4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(width: 1.0),
                            ),
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                isSelected4 = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 4),
                        Container(
                          width: 160,
                          height: 45,
                          child: OutlinedButton(
                              onPressed: () {
                                context
                                    .read<PasswordBloc>()
                                    .add(GeneratePasswordEvent(
                                      length: _sliderValue.toInt(),
                                      includeNumbers: isSelected1 ?? false,
                                      includeSymbols: isSelected2 ?? false,
                                      includeLowercase: isSelected3 ?? false,
                                      includeUppercase: isSelected4 ?? false,
                                    ));
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: const Text('Regenerate',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black))),
                        ),
                        const SizedBox(width: 22),
                        Container(
                          width: 160,
                          height: 45,
                          child: OutlinedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<PasswordBloc>()
                                      .add(SavePasswordEvent(
                                        PasswordData(
                                          websiteName:
                                              _websiteNameController.text,
                                          userId: _userIdController.text,
                                          websiteLink:
                                              _websiteLinkController.text,
                                          password: _passwordController.text,
                                        ),
                                      ));
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: const Text('Save password',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black))),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'OR',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 340,
                    height: 50,
                    child: OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<PasswordBloc>().add(SavePasswordEvent(
                                  PasswordData(
                                    websiteName: _websiteNameController.text,
                                    userId: _userIdController.text,
                                    websiteLink: _websiteLinkController.text,
                                    password: _passwordController.text,
                                  ),
                                ));
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Text('Add manually',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black))),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
