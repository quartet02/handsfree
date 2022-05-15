import 'package:flutter/material.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';

import '../../provider/lessonCardProvider.dart';

class ChoiceCard extends StatelessWidget {
  final String header;

  const ChoiceCard({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonCardProvider provider = Provider.of<LessonCardProvider>(context);

    return GestureDetector(
      onTap: (){
        provider.checkAns(header);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( header.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),)
          ],
        ),
        width: 80,
        // change image container height if it's mcq
        height: 80,
        decoration: const BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: kTextShadow,
              offset: Offset(10, 10),
              blurRadius: 20,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(
                'assets/image/learning_big_rect.png'),
          ),
        ),
      ),
    );
  }
}
