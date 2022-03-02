class NewUser {
  final String? uid;

  NewUser({this.uid});
}

class NewUserActivityLog{
  final List? activity;
  final String? corrector;

  NewUserActivityLog({this.corrector, this.activity});
}

class NewUserData{

  late final String? uid;
  late final String? name;
  late final int? experience;
  late final String? phoneNumber;
  late final String? picture;
  late final String? title;
  late final String? username;

  NewUserData({this.name, this.uid, this.experience, this.phoneNumber, this.picture, this.title, this.username});

}