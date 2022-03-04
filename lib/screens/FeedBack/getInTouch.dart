import 'package:flutter/material.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/buildTextBox.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/dropDownList.dart';
import 'package:handsfree/widgets/constants.dart';

class GetInTouchForm extends StatelessWidget {
  const GetInTouchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameTextFieldController = TextEditingController();
    final emailTextFieldController = TextEditingController();
    final subjectTextFieldController = TextEditingController();
    final descriptionTextFieldController = TextEditingController();
    final items = ["Syllabus issue", "Bug report", "Miscellaneous"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildText.heading2Text("Get in touch!"),
        Breaker(i: 15),
        // buildText.heading4Text("Name"),
        buildTextBox.textBox(nameTextFieldController, "Name"),
        Breaker(i: 15),
        // buildText.heading4Text("Email"),
        buildTextBox.textBox(emailTextFieldController, "Email",
            inputType: TextInputType.emailAddress),
        Breaker(i: 15),
        CustomDropDown(
            items,
            buildText.textBox("Issue type", 0.5, 12.5, FontWeight.w300, TextAlign.start, kText)),
        Breaker(i: 15),
        // buildText.heading4Text("Subject"),
        buildTextBox.textBox(subjectTextFieldController, "Subject"),
        Breaker(i: 15),
        // buildText.heading4Text("Description"),

        buildTextBox.textBox(
            descriptionTextFieldController, "Describe the issue",
            action: TextInputAction.newline,
            maxLine: null,
            inputType: TextInputType.multiline,
            paddings: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
      ],
    );
  }
}
