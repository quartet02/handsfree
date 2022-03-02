import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/screens/home/user_form.dart';
import 'package:handsfree/screens/home/users_list.dart';
import 'package:provider/provider.dart';
import '../../widgets/navBar.dart';
import '../../models/userProfile.dart';
import '../../services/auth.dart';
import '../../services/database.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: UserForm(),
        );
      });
    }

    //check keyboard visibility
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final AuthService _auth = AuthService();
    return StreamProvider<List<Users>?>.value(
      value: DatabaseService().users,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Users'),
          backgroundColor: Colors.purpleAccent[50],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/purpleTop.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: UserList()
        ),
        floatingActionButton: isVisible ? SizedBox() : NavBar.Buttons(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        bottomNavigationBar: NavBar.bar(context, 4),
      ),
    );
  }
}
