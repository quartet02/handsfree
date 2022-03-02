import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/Loading.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> profileAvatar = ['AvatarProfile0', 'AvatarProfile1', 'AvatarProfile2', 'AvatarProfile3', 'AvatarProfile4'];

  // form values
  int? _currentExperience;
  String? _currentPhoneNumber;
  String? _currentPicture;
  String? _currentTitle;
  String? _currentUsername;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<NewUser?>(context);

    return StreamBuilder<NewUserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          NewUserData? userData = snapshot.data;

          return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Update your user settings.',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0,),
              TextFormField(
                initialValue: userData!.name,
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentUsername = val),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: userData.phoneNumber,
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? 'Please enter phone number' : null,
                onChanged: (val) => setState(() => _currentPhoneNumber = val),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                initialValue: userData.title,
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? 'Please enter a title' : null,
                onChanged: (val) => setState(() => _currentTitle = val),
              ),
              SizedBox(height: 8.0),

              //dropdown
              DropdownButtonFormField(
                decoration: textInputDecoration,
                value: _currentPicture ?? userData.picture!.substring((userData.picture!.lastIndexOf('/')+1), userData.picture!.indexOf('.')),
                items: profileAvatar.map((prof) {
                  return DropdownMenuItem(
                      value: prof,
                      child: Text(prof)
                  );
                }).toList(),
                    onChanged: (val) => setState(() => _currentPicture = val as String?),
              ),
              Slider(
                value: (_currentExperience ?? (userData.experience)!).toDouble(),
                activeColor: Colors.purpleAccent[_currentExperience ?? 0],
                inactiveColor: Colors.purple[_currentExperience ?? 0],
                min:   0,
                max: 900,
                divisions: 9,
                onChanged: (val) => setState(() => _currentExperience = val.round()),
              ),
              //slider
              RaisedButton(
                color: Colors.pink[400],
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    await DatabaseService(uid: user.uid).updateUserData(
                        (_currentExperience ?? userData.experience)!,
                        (_currentPhoneNumber ?? userData.phoneNumber)!,
                        "assets/image/" + (_currentPicture ?? userData.picture!.substring((userData.picture!.lastIndexOf('/')+1), userData.picture!.indexOf('.'))) + ".png",
                        (_currentTitle ?? userData.title)!,
                        (_currentUsername ?? userData.username)!
                    );
                    Navigator.pop(context);
                  }
                }),
            ],
          ),
        );
        }
        else{
          return Loading();
        }
      }
    );
  }
}
