import 'package:flutter/material.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/services/medialoader.dart';

class UserTile extends StatelessWidget {

  late final Users? user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            child: FutureBuilder(
              future: getImage(context, user!.picture),
              builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                print('Successfully Connected');
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
            backgroundColor: Colors.brown[user!.experience],

            // if you want to directly access from local, comment the child: and uncomment this
            // backgroundImage: AssetImage('assets/image/dummy_cat.png'),

          ),
          title:  Text(user!.name),
          subtitle: Text(user!.title + "\n" + user!.phoneNumber),
        ),
      )
    );
  }
}
