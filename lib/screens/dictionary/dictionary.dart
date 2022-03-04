import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/provider/dictionaryProvider.dart';
import 'package:handsfree/screens/dictionary/searchBar.dart';
import 'package:handsfree/screens/dictionary/searchGroup.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/navBar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/navBar.dart';

List _wordData = [];
Map<dynamic, dynamic> temp = {};

class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final searchController = TextEditingController();
  @override
  void initState() {
    _wordData = [];
    _wordData = DatabaseService().getWordData();
    // getIndividualData('Hello');
    // print(temp);
    // print(temp['word']);
    // print(temp['definition']);
    // print(temp['imgUrl']);
    // print(temp['phoneticSymbol']);

    super.initState();
  }


  /*Map<String, String>*/ getIndividualData(String x){
    //because wordData is not a stream, but a Future, so it wont be loaded initially, but load when home page finish display
    //so you can only use this function on the next page or I will create a stream
    //debug here
    // print('Oi');
    // print(wordData);
    // for(Map<String, String> each in wordData){
    //   print(each);
    //   if(each['word'] == x) {
    //     return each;
    //   }
    // }
    // return {'definition': 'Error', 'word': 'Error', 'phoneticSymbol': 'Error', 'imgUrl': 'Error'};
    List syllabus = ['Syllabus 1', 'Syllabus 2'];
    for(String each in syllabus) {
      FirebaseFirestore.instance.collection('lessons').doc(each).collection('Syllabus').where('word', isEqualTo: x).get().then((snapshot) {
        snapshot.docs.forEach((doc) {
          if (doc.exists) {
            temp = doc.data();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;


// <<<<<<< Updated upstream
//     return ChangeNotifierProvider<DictionaryProvider>(
//       create: (context) => DictionaryProvider(),
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 alignment: Alignment.topCenter,
//                 image: AssetImage('assets/image/magenta_heading.png'),
//                 fit: BoxFit.cover),
//           ),
//           child: Container(
//             padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
//             margin:
//                 EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
//             child: Column(
//               children: [
//                 buildText.bigTitle("Dictionary"),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 20),
//                 ),
//                 Stack(
//                   children: [
//                     isVisible ? const SearchGroup() : Container(),
//                     const SearchBar(provider: "dictionary")
//                   ],
//                 ),
//                 !isVisible
//                     ? const Padding(
//                         padding: EdgeInsets.only(bottom: 80),
//                       )
//                     : Container(),
//                 !isVisible
//                     ? GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/translator');
//                         },
//                         child: Stack(
//                           children: <Widget>[
//                             Center(
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: 200,
//                                 decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(20)),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: kTextDeep,
//                                         offset: Offset(6, 6),
//                                         blurRadius: 6,
//                                       ),
//                                     ]),
//                                 child: Image.asset(
//                                   'assets/image/translator.png',
//                                   scale: 4,
// =======
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).popAndPushNamed('/learn', result: true);
        return true;
      },
      child: ChangeNotifierProvider<DictionaryProvider>(
        create: (context) => DictionaryProvider(wordData: _wordData),
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/image/magenta_heading.png'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
              child: Column(
                children: [
                  buildText.bigTitle("Dictionary"),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Stack(
                    children: [
                      isVisible ? const SearchGroup() : Container(),
                      const SearchBar(provider: 'dictionary',) /*SearchBar(provider: "dictionary")*/
                    ],
                  ),
                  !isVisible
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 80),
                        )
                      : Container(),
                  !isVisible
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/translator');
                          },
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kTextDeep,
                                          offset: Offset(6, 6),
                                          blurRadius: 6,
                                        ),
                                      ]),
                                  child: Image.asset(
                                    'assets/image/translator.png',
                                    scale: 4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  !isVisible
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        )
                      : Container(),
                  !isVisible
                      ? Text(
                          'Text-to-Sign',
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: kText,
                          ),
                        )
                      : Container(),
                  !isVisible
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        )
                      : Container(),
                  !isVisible
                      ? Text(
                          'Translator',
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: kText,
                          ),
                        )
                      : Container(),
                  !isVisible
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        )
                      : Container(),
                  !isVisible
                      ? Text(
                          'Now in BETA!',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: kText,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          floatingActionButton:
            isVisible ? const SizedBox() : NavBar.Buttons(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          bottomNavigationBar: NavBar.bar(context, 1),
        ),
      ),
    );
  }
}
