import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  static int index = 0;

  static BottomAppBar bar(BuildContext context, int currentPage) {
    const double RADIUS = 23;
    index = currentPage;
    return BottomAppBar(
      color: Colors.transparent,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/nav_bar_bottom.png"),
              fit: BoxFit.cover),
        ),
        height: 74,

        // flex: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            circle(context, 0, "assets/svg/home.svg", "/home"),
            circle(context, 1, "assets/svg/dictionary.svg", "/dictionary"),
            const CircleAvatar(
              radius: RADIUS,
              backgroundColor: Colors.transparent,
            ),
            circle(context, 3, "assets/svg/social.svg", "/social"),
            circle(context, 4, "assets/svg/user.svg", "/profile"),
          ],
        ),
      ),
    );
  }

  static CircleAvatar circle(
      BuildContext context, int i, String icon, String location) {
    return CircleAvatar(
      radius: 23,
      backgroundColor: index == i ? kPurpleNav : kTextDeep,
      child: MaterialButton(
        onPressed: () {
          if (index != i) {
            Navigator.pushReplacementNamed(context, location);
          }
          index = i;
        },
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        padding: const EdgeInsets.all(0),
        child: SvgPicture.asset(icon,
            color: index == i
                ? const Color.fromARGB(255, 238, 242, 254)
                : kPurpleNav),
      ),
    );
  }

  static FloatingActionButton Buttons(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (index != 2) {
          // this block is to reset all users lessons
          // List<String> ids = await DatabaseService(
          //         uid: Provider.of<NewUserData?>(context, listen: false)!.uid)
          //     .usersId;
          // ids.forEach((element) async {
          //   await DatabaseService(uid: element).buildUserLesson();
          // });
          Navigator.pushReplacementNamed(context, "/learn");
        }
        index = 2;
      },
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 172, 172, 172),
              offset: Offset(10, 10),
              blurRadius: 15,
            ),
          ],
          image: DecorationImage(
            image: index == 2
                ? const AssetImage("assets/image/purple_nav_button.png")
                : const AssetImage("assets/image/nav_bar_circle.png"),
          ),
        ),
        child: SvgPicture.asset("assets/svg/hand.svg",
            alignment: Alignment.center,
            width: 30,
            height: 30,
            fit: BoxFit.scaleDown,
            color: index == 2
                ? const Color.fromARGB(255, 238, 242, 254)
                : kPurpleNav),
      ),
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container();
  }
}
