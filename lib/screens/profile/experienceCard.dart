import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({Key? key, required this.title, required this.lvl, required this.currentExp}) : super(key: key);

  final String title;
  final String lvl;
  static const double maximumExp = 100;
  final double currentExp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314,
      height: 149,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/image/experienceBackground.png'),fit: BoxFit.fill),
        boxShadow: [
          BoxShadow(
            color: Color(0xffa9a9a9),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(10, 10),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              width: 276,
              height: 58,
              decoration: const BoxDecoration(
                image: const DecorationImage(image: const AssetImage('assets/image/profileTitleBackground.png'),fit: BoxFit.fill),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff747474),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(5, 5),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 31.25,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff9e84fd),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LinearPercentIndicator(
                  barRadius: const Radius.circular(18),
                  width: 276.0,
                  lineHeight: 6.0,
                  percent: currentExp / maximumExp,
                  backgroundColor: const Color(0xfff0f5ff),
                  progressColor: const Color(0xfff1a15a),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Lvl $lvl",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xfff0f5ff),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}