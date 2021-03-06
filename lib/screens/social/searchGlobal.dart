import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/screens/social/searchGlobalResult.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/backButton.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';

class SearchGlobal extends StatefulWidget {
  const SearchGlobal({Key? key}) : super(key: key);

  @override
  State<SearchGlobal> createState() => _SearchGlobalState();
}

class _SearchGlobalState extends State<SearchGlobal> {
  String _query = "";
  @override
  Widget build(BuildContext context) {
    NewUserData? user = Provider.of<NewUserData?>(context);
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    // prevent screen rotation and force portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildHeading(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.32,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(children: [
              searchBar(),
              Breaker(i: 30, pos: PadPos.bottom),
              Expanded(
                child: StreamProvider<List<String>>(
                  initialData: [],
                  create: (_) =>
                      DatabaseService(uid: user!.uid).excludeUserIdForGlobal,
                  child: SearchResult(query: _query),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildHeading() {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
              maxHeight: 172, minWidth: MediaQuery.of(context).size.width),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/orange_heading4.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Button.backButton(context, 30, 9.5),
        Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            alignment: Alignment.topCenter,
            child: buildText.bigTitle("Search Global"))
      ],
    );
  }

  Widget searchBar() {
    const double radius = 25;
    return Container(
      margin: const EdgeInsets.all(0),
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
        initialValue: _query,
        autofocus: false,
        obscureText: false,
        autocorrect: false,
        onChanged: (txt) {
          setState(() {
            _query = txt;
          });
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: "Search",
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
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Please enter some text";
          }
          return null;
        },
      ),
    );
  }
}
