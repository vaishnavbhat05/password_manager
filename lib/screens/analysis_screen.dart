import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager_app/screens/details_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../bloc/password_bloc.dart';
import 'add_password_screen.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PasswordBloc>().add(LoadPasswordsEvent());
  }
  String _getStrengthLabel(String password) {
    double strength = _calculatePasswordStrength(password);
    if (strength <= 0.3) {
      return 'Risk ';
    } else if (strength <= 0.7) {
      return 'Weak';
    } else {
      return 'Safe ';
    }
  }

  Color _getStrengthColor(String password) {
    double strength = _calculatePasswordStrength(password);
    if (strength <= 0.3) {
      return Colors.red;
    } else if (strength <= 0.7) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    int score = 0;
    if (password.length >= 6) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

    return score / 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
              const Spacer(),
              const Text(
                'Security',
                style: TextStyle(fontSize: 26),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
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
          body: BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
            if (state is PasswordLoaded) {
              int totalCount = state.passwords.length;
              int safeCount = state.passwords.where((p) => _getStrengthLabel(p.password) == "Safe ").length;
              int weakCount = state.passwords.where((p) => _getStrengthLabel(p.password) == "Weak").length;
              int riskCount = state.passwords.where((p) => _getStrengthLabel(p.password) == "Risk ").length;
              double securePercentage = totalCount > 0 ? (safeCount / totalCount) * 100 : 0;
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 62,
                              backgroundWidth: 15,
                              percent: totalCount > 0 ? safeCount / totalCount : 0,
                              lineWidth: 10,
                              backgroundColor: Colors.black,
                              progressColor: Colors.white,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            Text(
                              "${securePercentage.toStringAsFixed(0)}%",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${securePercentage.toStringAsFixed(0)}% secured',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 0.8)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('$safeCount', style: TextStyle(fontSize: 20)),
                                      const Text('Safe', style: TextStyle(fontSize: 20))
                                    ],
                                  )),
                              const SizedBox(width: 10),
                              Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 0.8)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('$weakCount', style: TextStyle(fontSize: 20)),
                                      const Text('Weak', style: TextStyle(fontSize: 20))
                                    ],
                                  )),
                              const SizedBox(width: 10),
                              Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 0.8)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('$riskCount', style: TextStyle(fontSize: 20)),
                                      const Text('Risk', style: TextStyle(fontSize: 20))
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: Row(
                            children: [
                              const Text(
                                'Analysis',
                                style: TextStyle(fontSize: 22),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.filter_list,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListView.builder(
                              itemCount: state.passwords.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final password = state.passwords[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsScreen(
                                                  id: password.id!,
                                                  userId: password.userId,
                                                  websiteName: password.websiteName,
                                                  websiteLink: password.websiteLink,
                                                  password: password.password,
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.blueAccent,
                                              child: Text(
                                                state.passwords[index].websiteName[0],
                                                style: const TextStyle(fontSize: 30, color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 8),
                                                          child: Text(
                                                            password.websiteName,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 20),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 8),
                                                          child: Text(
                                                            password.userId,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons.navigate_next,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 8)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30, bottom: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              _getStrengthLabel(password.password),
                                              style: TextStyle(fontSize: 14, color: _getStrengthColor(password.password)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24),
                                              child: LinearPercentIndicator(
                                                percent: _calculatePasswordStrength(password.password),
                                                lineHeight: 6,
                                                width: 295,
                                                barRadius: const Radius.circular(6),
                                                progressColor: _getStrengthColor(password.password),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ));
  }
}
