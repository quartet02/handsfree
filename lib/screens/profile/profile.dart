import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/models/achievementModel.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/screens/profile/achievementList.dart';
import 'package:handsfree/screens/profile/endorsement.dart';
import 'package:handsfree/screens/profile/profileCard.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
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
    bool firstTime = true;
    int ranking = 14;
    final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final user = Provider.of<NewUserData?>(context);
    if (user == null) return Container();
    User userAuth = FirebaseAuth.instance.currentUser!;

    Users profile = Users(
        name: user.name!,
        experience: user.experience!,
        phoneNumber: user.phoneNumber!,
        picture: user.picture!,
        title: user.title!,
        username: user.username!,
        uid: user.uid!);

    Future updateActivity() async {
      var activities =
      await DatabaseService(uid: profile.uid).getActivityLog("List");
      var time = await DatabaseService(uid: profile.uid).getActivityLog("Time");
      await DatabaseService(uid: profile.uid)
          .updateActivityLog(activities!, time!);
      // set local user profileDetails
    }

    Users? specificProfile =
        ModalRoute.of(context)!.settings.arguments as Users;

    if (specificProfile.uid != "self") profile = specificProfile;

    bool isSelf = user.uid == profile.uid;
    String lastValue = "0";

    return StreamBuilder<NewUserActivityLog>(
        stream: DatabaseService(uid: profile.uid).activity,
        builder: (context, snapshot2) {
          return StreamBuilder<List<Users>?>(
            stream: DatabaseService(uid: profile.uid).users,
            builder: (context, snapshot3) {

              if (snapshot2.hasData && snapshot3.hasData){
                NewUserActivityLog? activities = snapshot2.data;
                List<Users>? userList = snapshot3.data;

                if(firstTime) {
                  DatabaseService(uid: profile.uid).updateActivityLog(
                      activities?.activity, activities?.lastLoginIn);
                  firstTime = false;
                }

                int i = 0;
                for (Users each in userList!) {
                  i++;
                  if (profile.uid == each.uid) {
                    ranking = i;
                    break;
                  }
                }

                return Scaffold(
                  backgroundColor: const Color(0xFFF0F5FF),
                  body: ListView(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 20,
                        left: 30,
                        bottom: 5,
                        right: 30),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      isSelf
                          ? Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.settings),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/settings');
                                },
                              ),
                            )
                          : Breaker(i: 50),
                      ProfileCard(
                        uid: profile.uid,
                        profile: ProfileDetails(
                            imageUrl:
                                'assets/image/character.png' /*userData.picture!*/,
                            username: profile.username,
                            email: "",
                            experience: snapshot3.data!
                                .firstWhere(
                                    (element) => element.uid == profile.uid)
                                .experience),
                      ),
                      Breaker(i: 20),
                      isSelf
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Active Days',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff1D283F),
                                ),
                              ),
                            )
                          : Container(),
                      isSelf ? Breaker(i: 10) : Container(),
                      isSelf
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  days.length,
                                  (index) => DayActivity(
                                      day: days[index],
                                      activity: activities!
                                          .activity![index])).toList(),
                            )
                          : Container(),
                      Breaker(i: 25),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 13),
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
                                      (isSelf ? "You are c" : "C") +
                                          "urrently ranked top $ranking globally.",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12.8,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff1D283F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EndorseButton(
                                      profile: profile, isSelf: isSelf),
                                  FutureBuilder<String>(
                                      future: DatabaseService(uid: profile.uid)
                                          .getEndorsementCount(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.connectionState ==
                                                ConnectionState.done) {
                                          lastValue = snapshot.data!;
                                          return Text(
                                            lastValue,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12.8,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          );
                                        } else if (snapshot.hasData &&
                                            snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                          return Text(
                                            lastValue,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12.8,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            "",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12.8,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          );
                                        }
                                      })
                                ],
                              ),
                            ]),
                      ),
                      Breaker(i: 25),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Achievements",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<List<Achievement>>(
                                stream: DatabaseService(uid: profile.uid)
                                    .getAchievements(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState ==
                                          ConnectionState.active) {
                                    return AchievementList(
                                        isSelf: isSelf,
                                        achievements: snapshot.data!);
                                  } else {
                                    return Text(
                                      "",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12.8,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff1D283F),
                                      ),
                                    );
                                  }
                                }),
                            Breaker(i: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: isSelf ? NavBar.Buttons(context) : null,
                  floatingActionButtonLocation:
                      isSelf ? FloatingActionButtonLocation.centerDocked : null,
                  extendBody: true,
                  bottomNavigationBar: isSelf ? NavBar.bar(context, 4) : null,
                );
              } else {
                debugPrint(snapshot2.error.toString());
                return Loading();
              }
            },
          );
        });
  }
}
