import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profileDetails.dart';
import 'experienceCard.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.profile}) : super(key: key);

  final ProfileDetails profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 163,
          height: 163,
          child: ClipPolygon(
            sides: 6,
            borderRadius: 5.0,
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
          height: 10,
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
          height: 5,
        ),
        const ExperienceCard(title: 'Fluent Speaker', lvl: '30', currentExp: 50,),
      ],
    );
  }
}
