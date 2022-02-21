import 'package:flutter/material.dart';
import 'package:handsfree/models/userActivity.dart';
import 'package:handsfree/screens/dictionary/searchBar.dart';
import 'package:handsfree/services/getData.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

class SearchGroup extends StatefulWidget {
  const SearchGroup({Key? key}) : super(key: key);

  @override
  _SearchGroupState createState() => _SearchGroupState();
}

class _SearchGroupState extends State<SearchGroup> {
  @override
  Widget build(BuildContext context) {
    List<String> suggest = getData.getSuggestions(
        Provider.of<UserActivity>(context, listen: false).getQuery());
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kTextLight,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: kTextShadow,
                offset: Offset(6, 6),
                blurRadius: 6,
              ),
            ],
          ),
          height: 230,
          child: ListView.builder(
            itemCount: suggest.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  enabled: false,
                  title: Text(""),
                );
              } else {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  textColor: kTextFieldText,
                  title: Text(suggest[index - 1]),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
