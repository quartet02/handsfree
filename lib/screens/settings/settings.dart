import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/buildTextBox.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';

import '../../models/newUser.dart';
import '../../widgets/loadingWholeScreen.dart';

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

  Widget subTitle(String name) {
    return Container(
      padding: const EdgeInsets.only(left: 18, bottom: 5),
      child: buildText.heading3Text(name),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser?>(context);
    User userAuth = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<NewUserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData) {

          NewUserData? userData = snapshot.data;

          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/image/purple_heading2.png'),
                    fit: BoxFit.cover),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
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
                        height: MediaQuery.of(context).size.height / 1.37,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            children: [
                              ///Your profile
                              breaker(20),
                              buildText.heading2Text("Your Profile"),
                              breaker(20),
                              subTitle("Name"),
                              textBox(nameController, "name", 'name', user.uid!, userData!.name!),
                              subTitle("Username"),
                              textBox(usernameController, "username", 'username', user.uid!, userData.username!),
                              subTitle("Email"),
                              textBox(emailController, "email", 'none', user.uid!, userAuth.email!, enabled: false),
                              subTitle("Password"),
                              textBox(passwordController, "password", 'password', user.uid!, ''),
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
                                  word: "/helpCenter",
                                  buttonColor: "purple"),
                              breaker(10),
                              buildButton(
                                  text: "Feedback",
                                  word: "/feedback",
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
                                  text: "Terms",
                                  word: "/terms",
                                  buttonColor: "purple"),
                              breaker(10),
                              buildButton(
                                  text: "Acknowledgement",
                                  word: "/acknowledgement",
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
        else{
          print(snapshot);
          return Loading();
        }
      }
    );
  }

  Widget textBox(TextEditingController controller, String name, String selector, String uid, String initialValue, {bool enabled = true}) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: buildTextBox.textBox(controller, name, selector: selector, uid: uid, initialValue: initialValue, enabled: enabled),
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
