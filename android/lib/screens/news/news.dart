import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/screens/news/news_list.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/buildText.dart';
import '../../models/newsFeedModel.dart';
import '../../provider/dictionaryProvider.dart';
import '../../services/database.dart';
import '../../widgets/navBar.dart';
import '../dictionary/searchBar.dart';
import '../dictionary/searchGroup.dart';

List _wordData = [];
Map<dynamic, dynamic> temp = {};

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final searchController = TextEditingController();
  @override
  void initState() {
    _wordData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return StreamProvider<List<NewsFeedModel_1>?>.value(
      value: DatabaseService().newsList,
      initialData: null,
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
                buildText.bigTitle("News"),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Stack(
                  children: [
                    isVisible ? const SearchGroup() : Container(),
                    const SearchBar(provider: Providers.dictionary,)
                  ],
                ),
                // !isVisible
                //     ? const Padding(
                //   padding: EdgeInsets.only(bottom: 80),
                // )
                //     : Container(),
                // !isVisible
                //     ? Stack(
                //     children: <Widget>[
                //       Center(
                //         child: Container(
                //           alignment: Alignment.center,
                //           width: 200,
                //           decoration: const BoxDecoration(
                //               borderRadius:
                //               BorderRadius.all(Radius.circular(20)),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: kTextDeep,
                //                   offset: Offset(6, 6),
                //                   blurRadius: 6,
                //                 ),
                //               ]),
                //         ),
                //       ),
                //     ],
                //   )
                //     : Container(),
                !isVisible
                    ? const NewsList()
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

