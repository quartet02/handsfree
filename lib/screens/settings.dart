import 'package:flutter/material.dart';
import 'package:handsfree/utils/buildButton.dart';
import 'package:handsfree/utils/buildText.dart';
import 'package:handsfree/utils/buildTextBox.dart';
import 'package:handsfree/utils/constants.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSoundEffectOn = false;
  bool isDarkModeOn = false;
  bool isMotivationalMessageOn = false;

  bool isPracticeReminderOn = false;
  bool isSmartSchedulingOn = false;

  bool isWeeklyProgressOn = false;
  bool isNewFriendsOn = false;
  bool isFriendActivityOn = false;
  bool isLeaderboardsOn = false;
  bool isNewsOn = false;

  bool isTrackingForAdvertisingOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/purple_heading2.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              buildText.bigTitle("Settings"),
              breaker(80),
              ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.purple
                    ],
                    stops: [
                      0.0,
                      0.1,
                      0.9,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 0, bottom: 5, right: 0),
                  height: 500,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      children: [
                        ///Your profile
                        breaker(10),
                        buildText.heading2Text("Your Profile"),
                        breaker(20),
                        subTitle("Name"),
                        textBox(nameController, "name"),
                        subTitle("Username"),
                        textBox(usernameController, "username"),
                        subTitle("Email"),
                        textBox(emailController, "email"),
                        subTitle("Password"),
                        textBox(passwordController, "password"),
                        breaker(20),
                        buildButton(
                            text: "Sign Out",
                            word: "home",
                            buttonColor: "purple"),

                        ///General Setttings
                        breaker(50),
                        buildText.heading2Text("General"),
                        breaker(20),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/image/rect_row_3.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: kTextShadow,
                                  offset: Offset(6, 6),
                                  blurRadius: 6,
                                ),
                              ]),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("Sound Effects"),
                                    toggleSwitch(isSoundEffectOn),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("Dark Mode"),
                                    toggleSwitch(isDarkModeOn),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText
                                        .heading3Text("Motivational message"),
                                    toggleSwitch(isMotivationalMessageOn),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        breaker(20),
                        buildButton(
                            text: "Helpdesk",
                            word: "home",
                            buttonColor: "purple"),
                        breaker(10),
                        buildButton(
                            text: "Feedback",
                            word: "home",
                            buttonColor: "purple"),
                        breaker(50),

                        ///Notification
                        buildText.heading2Text("Notification"),
                        breaker(20),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/image/rect_row_2.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: kTextShadow,
                                  offset: Offset(6, 6),
                                  blurRadius: 6,
                                ),
                              ]),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("Practice Reminder"),
                                    toggleSwitch(isPracticeReminderOn),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("Smart Scheduling"),
                                    toggleSwitch(isSmartSchedulingOn),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        breaker(20),
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/image/rect_row_5.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: kTextShadow,
                                  offset: Offset(6, 6),
                                  blurRadius: 6,
                                ),
                              ]),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("Weekly Progress"),
                                    toggleSwitch(isWeeklyProgressOn),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("New Friend"),
                                    toggleSwitch(isNewFriendsOn),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("Friend Activity"),
                                    toggleSwitch(isFriendActivityOn),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("Leaderboards"),
                                    toggleSwitch(isLeaderboardsOn),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text("News"),
                                    toggleSwitch(isNewsOn),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        breaker(50),

                        ///Privacy
                        buildText.heading2Text("Privacy"),
                        breaker(20),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/image/text_field.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: kTextShadow,
                                  offset: Offset(6, 6),
                                  blurRadius: 6,
                                ),
                              ]),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading3Text(
                                        "Tracking for Advertisement"),
                                    toggleSwitch(isTrackingForAdvertisingOn),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        breaker(20),
                        buildButton(
                            text: "Terms", word: "home", buttonColor: "purple"),
                        breaker(10),
                        buildButton(
                            text: "Acknowledgement",
                            word: "home",
                            buttonColor: "purple"),
                        breaker(40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subTitle(String name) {
    return Container(
      padding: EdgeInsets.only(left: 18, bottom: 5),
      child: buildText.heading3Text(name),
    );
  }

  Widget textBox(TextEditingController controller, String name) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: buildTextBox.textBox(controller, name),
    );
  }

  Widget breaker(double i) {
    return Padding(
      padding: EdgeInsets.only(bottom: i),
    );
  }

  Widget toggleSwitch(bool j) {
    return Switch(
      value: j,
      onChanged: (value) {
        setState(() {
          j = value;
        });
      },
      activeTrackColor: kOrangeLight,
      activeColor: kOrangeDeep,
    );
  }
}
