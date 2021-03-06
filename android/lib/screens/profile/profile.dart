import 'package:flutter/material.dart';
import 'package:handsfree/screens/profile/profileCard.dart';
import 'package:handsfree/widgets/navBar.dart';
import 'package:handsfree/screens/profile/profileDetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dayActivity.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int ranking = 14;
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final activities = [true, true, false, false, true, true, false];

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
                  imageUrl: 'assets/image/character.png',
                  username: 'Mickie',
                  email: 'mickie@gmail.com',
                  experience: 12),
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
                      day: days[index], activity: activities[index])).toList(),
            ),
            breaker(120)
          ],
        ),
      ),
      floatingActionButton: NavBar.Buttons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: NavBar.bar(context, 4),
    );
  }

  Widget breaker(double i) {
    return Padding(
      padding: EdgeInsets.only(bottom: i),
    );
  }
}
