import 'package:flutter/material.dart';
import 'package:handsfree/services/medialoader.dart';
import '../../models/newsFeedModel.dart';
import 'package:intl/intl.dart';
import 'package:handsfree/widgets/buildText.dart';

class NewsTile extends StatelessWidget {
  late final NewsFeedModel? news;
  NewsTile({this.news});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: FutureBuilder(
                future: FireStorageService.loadImage(news!.newsFeedImages),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(snapshot.data as String).image,
                          ),
                        ));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: 50,
                      height: 50,
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    debugPrint('Connection Failed');
                    return Container();
                  }
                }),

            // if you want to directly access from local, comment the child: and uncomment this
            // backgroundImage: AssetImage('assets/image/dummy_cat.png'),

            title: buildText.heading3Text(news!.newsFeedTitle),
            subtitle: buildText.heading4Text(DateFormat('yyyy-MM-dd - kk:mm')
                .format(news!.timestamp.toDate())),
            onTap: () {
              //link to individual news display
              // Overlays.showOverlay(context, 0, news!.newsFeedImages, news!.newsFeedTitle, news!.newsFeedDesc);
              Navigator.pushNamed(context, "/showNews", arguments: news);
            },
            dense: true,
          ),
        ));
  }
}
