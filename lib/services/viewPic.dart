import "package:flutter/material.dart";

class ViewPic extends StatelessWidget {
  const ViewPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imgPath = ModalRoute.of(context)!.settings.arguments as String;
    return Container(child: Image.network(imgPath));
  }
}
