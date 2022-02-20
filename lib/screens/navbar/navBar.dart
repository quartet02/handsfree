import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class navBar extends StatelessWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static BottomAppBar bar() {
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 90,
                  onPressed: () {},
                  child: Icon(Icons.home, color: Colors.black),
                ),
                MaterialButton(
                  minWidth: 80,
                  onPressed: () {},
                  child: Icon(Icons.book, color: Colors.black),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 80,
                  onPressed: () {},
                  child: Icon(Icons.chat, color: Colors.black),
                ),
                MaterialButton(
                  minWidth: 90,
                  onPressed: () {},
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static FloatingActionButton Buttons() {
    return FloatingActionButton(
      elevation: 2.0,
      onPressed: () {},
      child: Stack(alignment: Alignment.center, children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image/navButton.png"))),
        ),
        MaterialButton(
          onPressed: () {},
          child: Icon(
            Icons.headphones,
            color: Colors.black,
          ),
        )
      ]),
    );
  }
}
