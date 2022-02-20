import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handsfree/utils/constants.dart';

class navBar extends StatelessWidget {
  const navBar({Key? key}) : super(key: key);
  static int index = 0;

  static BottomAppBar bar(BuildContext context) {
    const double RADIUS = 25;
    return BottomAppBar(
      color: Colors.transparent,
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
              image: AssetImage("assets/image/nav.png"), fit: BoxFit.cover),
        ),
        height: 60,
        child: Row(
          // hold 2 groups of widget
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: RADIUS,
                    backgroundColor: kTextDeep,
                    child: MaterialButton(
                      onPressed: () {
                        if (index != 0) {
                          Navigator.pushReplacementNamed(context, "/home/home");
                        }
                        index = 0;
                      },
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.home,
                          color: index == 0 ? kButtonShadow : kPurpleNav),
                    ),
                  ),
                  CircleAvatar(
                    radius: RADIUS,
                    backgroundColor: kTextDeep,
                    child: MaterialButton(
                      onPressed: () {
                        if (index != 1) {
                          Navigator.pushReplacementNamed(
                              context, "/dictionary/dictionary");
                        }
                        index = 1;
                      },
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.book,
                          color: index == 1 ? kButtonShadow : kPurpleNav),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Visibility(
                child: Text(""),
                visible: false,
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: RADIUS,
                    backgroundColor: kTextDeep,
                    child: MaterialButton(
                      onPressed: () {
                        if (index != 3) {
                          Navigator.pushReplacementNamed(context, "/home/chat");
                        }
                        index = 3;
                      },
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.chat,
                          color: index == 3 ? kButtonShadow : kPurpleNav),
                    ),
                  ),
                  CircleAvatar(
                    radius: RADIUS,
                    backgroundColor: kTextDeep,
                    child: MaterialButton(
                      onPressed: () {
                        if (index != 4) {
                          Navigator.pushReplacementNamed(
                              context, "/home/profile");
                        }
                        index = 4;
                      },
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.person,
                          color: index == 4 ? kButtonShadow : kPurpleNav),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static FloatingActionButton Buttons(BuildContext context) {
    return FloatingActionButton(
      elevation: 2.0,
      backgroundColor: Colors.transparent,
      onPressed: () {
        if (index != 2) {
          Navigator.pushReplacementNamed(context, "/learn/learn");
        }
        index = 2;
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/navButton.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Icon(
          Icons.lightbulb,
          color: index == 2 ? kButtonShadow : kPurpleNav,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container();
  }
}
