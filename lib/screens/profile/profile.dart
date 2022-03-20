import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/screens/profile/profileCard.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/loadingWholeScreen.dart';
import 'package:handsfree/widgets/navBar.dart';
import 'package:handsfree/screens/profile/profileDetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/userProfile.dart';
import 'dayActivity.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int ranking = 14;
    final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final user = Provider.of<NewUserData?>(context);
    if (user == null) return Container();
    User userAuth = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<NewUserActivityLog>(
        stream: DatabaseService(uid: user.uid).activity,
        builder: (context, snapshot2) {
          return StreamBuilder<List<Users>?>(
            stream: DatabaseService(uid: user.uid).users,
            builder: (context, snapshot3) {
              if (snapshot2.hasData && snapshot3.hasData) {
                NewUserActivityLog? activities = snapshot2.data;
                List<Users>? userList = snapshot3.data;

                int i = 0;
                for (Users each in userList!) {
                  i++;
                  if (user.uid == each.uid) {
                    ranking = i;
                    break;
                  }
                }

                return Scaffold(
                  backgroundColor: const Color(0xFFF0F5FF),
                  body: Container(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                      physics: BouncingScrollPhysics(),
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              Navigator.pushNamed(context, '/settings');
                            },
                          ),
                        ),
                        ProfileCard(
                          profile: ProfileDetails(
                              imageUrl:
                                  'assets/image/character.png' /*userData.picture!*/,
                              username: user.username!,
                              email: userAuth.email!,
                              experience: user.experience!),
                        ),
                        breaker(20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Leaderboards",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "You are currently $ranking in the whole world.",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.8,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff1D283F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        breaker(20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Active Days',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff1D283F),
                            ),
                          ),
                        ),
                        breaker(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                                  days.length,
                                  (index) => DayActivity(
                                      day: days[index],
                                      activity: activities!.activity![index]))
                              .toList(),
                        ),
                        breaker(120)
                      ],
                    ),
                  ),
                  floatingActionButton: NavBar.Buttons(context),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  extendBody: true,
                  bottomNavigationBar: NavBar.bar(context, 4),
                );
              } else {
                print(snapshot2.error);
                return Loading();
              }
            },
          );
        });
  }

  Widget breaker(double i) {
    return Padding(
      padding: EdgeInsets.only(bottom: i),
    );
  }
}
