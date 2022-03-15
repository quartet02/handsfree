import 'package:flutter/material.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/services/medialoader.dart';
import 'package:handsfree/widgets/overlay.dart';
import '../../models/newsFeedModel.dart';
import 'package:intl/intl.dart';

import '../../widgets/smallCard.dart';

class NewsTile extends StatelessWidget {

  late final NewsFeedModel_1? news;
  NewsTile({this.news});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              child: FutureBuilder(
                  future: getImage(context, news!.media),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      return Container(
                        width: MediaQuery.of(context).size.width/ 1.2,
                        height: MediaQuery.of(context).size.width/ 1.2,
                        child: snapshot.data as Widget,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        width: MediaQuery.of(context).size.width/ 1.2,
                        height: MediaQuery.of(context).size.width/ 1.2,
                        child: CircularProgressIndicator(),
                      );
                    }
                    print('Connection Failed');
                    return Container();
                  }),
              radius: 25.0,

              // if you want to directly access from local, comment the child: and uncomment this
              // backgroundImage: AssetImage('assets/image/dummy_cat.png'),

            ),
            title:  Text(news!.title),
            subtitle: Text(news!.content + "\n" + DateFormat('yyyy-MM-dd - kk:mm').format(news!.timestamp.toDate()) + "\n" + news!.author),
            onTap: (){
              //link to individual news display
              Overlays.showOverlay(context, 0, news!.media, news!.title, news!.content);
            },
          ),
        )
    );
  }
}
