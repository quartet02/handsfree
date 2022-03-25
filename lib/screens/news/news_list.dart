import 'package:flutter/cupertino.dart';
import 'package:handsfree/models/newsFeedModel.dart';
import 'package:provider/provider.dart';

import 'news_tile.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    late final news = Provider.of<List<NewsFeedModel>?>(context) ?? [];

    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        itemCount: news.length,
        itemBuilder: (context, index) {
          return NewsTile(news: news[index]);
        });
  }
}
