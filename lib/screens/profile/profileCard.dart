import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';
import '../../widgets/loadingWholeScreen.dart';
import 'profileDetails.dart';
import 'experienceCard.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({Key? key, required this.profile, required this.uid})
      : super(key: key);

  final ProfileDetails profile;
  final String uid;
  String? title;
  String? lvl;
  int? level;
  int? exp;
  List titles = [
    'Newbie Signer',
    'Novice Signer',
    'Rookie Signer',
    'Beginner Signer',
    'Talented Signer',
    'Intermediate Signer',
    'Skillful Signer',
    'Seasoned Signer',
    'Proficient Signer',
    'Experienced Signer',
    'Advanced Signer',
    'Senior Signer',
    'Expert Signer'
  ];

  void calculate() {
    int experience = profile.experience;
    level = experience ~/ 100;
    lvl = level.toString();
    exp = (experience - level! * 100);
    title = titles[level! ~/ 10 <= 12 ? level! ~/ 10 : 12];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUserData?>(context);
    calculate();
    if (user == null) return Loading();
    DatabaseService(uid: uid)
        .updateSingleData(CollectionSelector.title, title!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 163,
          height: 163,
          child: ClipPolygon(
            sides: 6,
            borderRadius: 5.0,
            boxShadows: [
              PolygonBoxShadow(color: Colors.white, elevation: 1.0),
              PolygonBoxShadow(color: const Color(0xff9e84fd), elevation: 3.0),
            ],
            child: Image.asset(
              profile.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          profile.username,
          style: GoogleFonts.montserrat(
            fontSize: 31.25,
            fontWeight: FontWeight.w800,
            color: const Color(0xff1D283F),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          profile.email,
          style: GoogleFonts.montserrat(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,
            color: const Color(0xff1D283F),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ExperienceCard(
          title: title!,
          lvl: lvl!,
          currentExp: exp!,
        ),
      ],
    );
  }
}
