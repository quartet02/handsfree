import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/buildTextBox.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/dropDownList.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';
import '../../models/newUser.dart';

class GetInTouchForm extends StatefulWidget {
  const GetInTouchForm({Key? key}) : super(key: key);

  @override
  _GetInTouchFormState createState() => _GetInTouchFormState();
}

class _GetInTouchFormState extends State<GetInTouchForm> {
  String? _subject;
  String? _description;
  String? _email;
  String? _imageUrl;
  String? _name;
  String? _category;

  @override
  Widget build(BuildContext context) {
    final nameTextFieldController = TextEditingController();
    final emailTextFieldController = TextEditingController();
    final subjectTextFieldController = TextEditingController();
    final descriptionTextFieldController = TextEditingController();
    final items = ["Syllabus issue", "Bug report", "Miscellaneous"];
    TextInputAction? action;
    TextInputType? inputType;
    int? maxLine = 1;
    EdgeInsets margins = const EdgeInsets.all(0);
    EdgeInsets paddings = const EdgeInsets.symmetric(horizontal: 20.0);
    double radius = 25;

    CustomDropDown dropDown = CustomDropDown(items,
        buildText.textBox("Issue type", 0.5, 12.5, FontWeight.w300, TextAlign.start, kText));
    final user = Provider.of<NewUser?>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildText.heading2Text("Get in touch!"),
        Breaker(i: 15),
        Container(
          margin: margins,
          decoration: BoxDecoration(
              color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage('assets/image/text_field.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [
                BoxShadow(
                  color: kTextShadow,
                  offset: Offset(6, 6),
                  blurRadius: 6,
                ),
              ]),
          child: TextFormField(
            textInputAction: action,
            keyboardType: inputType,
            maxLines: maxLine,
            onChanged: (value) => _name = value,
            controller: nameTextFieldController,
            decoration: InputDecoration(
              contentPadding: paddings,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: "Name",
              labelStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              fillColor: kTextLight,
              filled: false,
            ),
          ),
        ),
        Breaker(i: 15),
        Container(
          margin: margins,
          decoration: BoxDecoration(
              color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage('assets/image/text_field.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [
                BoxShadow(
                  color: kTextShadow,
                  offset: Offset(6, 6),
                  blurRadius: 6,
                ),
              ]),
          child: TextFormField(
            textInputAction: action,
            keyboardType: TextInputType.emailAddress,
            maxLines: maxLine,
            onChanged: (value) => _email = value,
            controller: emailTextFieldController,
            decoration: InputDecoration(
              contentPadding: paddings,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: "Email",
              labelStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              fillColor: kTextLight,
              filled: false,
            ),
          ),
        ),
        Breaker(i: 15),
        dropDown,
        Breaker(i: 15),
        Container(
          margin: margins,
          decoration: BoxDecoration(
              color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage('assets/image/text_field.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [
                BoxShadow(
                  color: kTextShadow,
                  offset: Offset(6, 6),
                  blurRadius: 6,
                ),
              ]),
          child: TextFormField(
            textInputAction: action,
            keyboardType: inputType,
            maxLines: maxLine,
            onChanged: (value) => _subject = value,
            controller: subjectTextFieldController,
            decoration: InputDecoration(
              contentPadding: paddings,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: "Subject",
              labelStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              fillColor: kTextLight,
              filled: false,
            ),
          ),
        ),
        Breaker(i: 15),
        Container(
          margin: margins,
          decoration: BoxDecoration(
              color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage('assets/image/text_field.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [
                BoxShadow(
                  color: kTextShadow,
                  offset: Offset(6, 6),
                  blurRadius: 6,
                ),
              ]),
          child: TextFormField(
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) => _description = value,
            controller: descriptionTextFieldController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: "Describe the issue",
              labelStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: kTextFieldText,
              ),
              fillColor: kTextLight,
              filled: false,
            ),
          ),
        ),
        Breaker(i: 30),
        GestureDetector(
          onTap: () async {
            _category = dropDown.getSelected;
            await DatabaseService(uid: user!.uid).submitFeedbackForm(_category!, _subject!, _description!, _email!, "_imageUrl", _name!);
            Navigator.pushNamed(context, "/settings");
          },
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: kButtonShadow,
                            offset: Offset(6, 6),
                            blurRadius: 6,
                          ),
                        ]),
                    child: Image.asset(
                      'assets/image/purple_button.png',
                      scale: 4,
                    )),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Send",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kTextLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

