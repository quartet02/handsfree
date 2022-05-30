import 'package:flutter/material.dart';
import 'package:handsfree/provider/newsFeedProvider.dart';
import 'package:handsfree/screens/news/news_list.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/buildText.dart';
import '../../models/newsFeedModel.dart';
import '../../services/database.dart';
import '../../widgets/backButton.dart';
import '../dictionary/searchBar.dart';

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
    return StreamProvider<List<NewsFeedModel>?>.value(
      value: DatabaseService()
          .newsFeedByQuery(Provider.of<NewsFeedProvider>(context).queryText),
      initialData: null,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/image/magenta_heading.png'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Button.backButton(context, 30, 9.5),
              Container(
                padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Column(
                  children: [
                    buildText.bigTitle("News"),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    const SearchBar(
                      provider: Providers.newsFeed,
                    ),
                    ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.purple
                          ],
                          stops: [
                            0.0,
                            0.1,
                            0.9,
                            1.0
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const NewsList()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
