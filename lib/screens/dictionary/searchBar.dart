import 'package:flutter/material.dart';
import 'package:handsfree/provider/dictionaryProvider.dart';
import 'package:handsfree/provider/helpdeskProvider.dart';
import 'package:handsfree/screens/settings/helpdesk.dart';
import 'package:handsfree/screens/dictionary/translator.dart';
import 'package:provider/provider.dart';
import '../../widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatefulWidget {
  final String prompt;
  final String provider;
  const SearchBar({
    Key? key,
    this.prompt = "Search",
    required this.provider,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchFieldController = TextEditingController();
  final double radius = 25;
  final FocusNode _onFocus = FocusNode();
  bool searchOnFocus = false;

  // create a listener object and bind to a listener method
  @override
  void initState() {
    super.initState();
    _onFocus.addListener(searchOnFocusChange);
  }

  // release the listener object
  @override
  void dispose() {
    super.dispose();
    _onFocus.removeListener(searchOnFocusChange);
    _onFocus.dispose();
  }

  // listener method
  void searchOnFocusChange() {
    setState(() {
      searchOnFocus = _onFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        focusNode: _onFocus,
        controller: searchFieldController,
        obscureText: false,
        autocorrect: false,
        onChanged: (txt) {
          final userQuery;
          if (widget.provider == "dictionary") {
            userQuery = context.read<DictionaryProvider>();
          } else if (widget.provider == "helpdesk") {
            userQuery = context.read<HelpDeskProvider>();
          } else {
            userQuery = context.read<DictionaryProvider>();
          }
          userQuery.query = txt;
        },
        onFieldSubmitted: (txt){
          final provider = context.read<DictionaryProvider>();
          List? wordData = provider.wordData;
          for(Map each in wordData!){
            if(each['word'] == txt){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Translator(each['word'], each['definition'], each['phoneticSymbol'], each['imgUrl']),
                  maintainState: false)
              );
              break;
            }
            else{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Translator('Unknown', 'Unknown', 'Unknown', 'Unknown'),
                  maintainState: false)
              );
            }
          }
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
          hintText: widget.prompt,
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
