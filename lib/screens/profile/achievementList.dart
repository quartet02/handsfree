import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/models/achievementModel.dart';
import 'package:handsfree/services/medialoader.dart';
import 'package:provider/provider.dart';

class AchievementList extends StatelessWidget {
  const AchievementList(
      {Key? key, required this.achievements, required this.isSelf})
      : super(key: key);

  final List<Achievement> achievements;
  final bool isSelf;
  @override
  Widget build(BuildContext context) {
    // achievements.forEach((elem) => print(elem.achievementImage));
    if (achievements.isEmpty) {
      return Text(
        isSelf
            ? "Work hard to get achievements"
            : "Still signing to get my achievements",
        style: GoogleFonts.montserrat(
          fontSize: 12.8,
          fontWeight: FontWeight.w400,
          color: const Color(0xff1D283F),
        ),
      );
    } else {
      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(achievements.length, (index) {
          return FutureBuilder<String>(
              future: FireStorageService.loadImage(
                  achievements[index].achievementImage),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: const Duration(milliseconds: 2500),
                        message: achievements[index].achievementDesc,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  Image.network(snapshot.data as String).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        achievements[index].achievementName,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 12.8,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff1D283F),
                        ),
                      )
                    ],
                  );
                } else {
                  return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator());
                }
              });
        }),
      );
    }
  }
}
