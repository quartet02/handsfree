import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayActivity extends StatelessWidget {
  const DayActivity({Key? key, required this.day, required this.activity})
      : super(key: key);

  final bool activity;
  final String day;

  @override
  Widget build(BuildContext context) {
    String imgUrl = 'assets/image/';
    imgUrl += activity ? 'activeDay.png' : 'inactiveDay.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Image(
            image: AssetImage(imgUrl),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffacacac),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(5, 5),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          day,
          style: GoogleFonts.montserrat(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,
            color: const Color(0xff1D283F),
          ),
        )
      ],
    );
  }
}