import 'package:flutter/material.dart';
import 'package:handsfree/models/userActivity.dart';
import 'package:handsfree/services/dictionaryData.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/utils/constants.dart';

class SearchGroup extends StatelessWidget {
  final DictionaryData dictionaryData;

  const SearchGroup({Key? key, required this.dictionaryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> suggest = dictionaryData.getSuggestions(
        Provider.of<UserActivity>(context, listen: true).getQuery());
    final suggestionLength = suggest.length > 5 ? 5 : suggest.length;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 20, 0,0),
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
          height: suggestionLength == 1 ? suggestionLength * 80 + 20 : suggestionLength * 60,
          child:ListView.builder(
            itemCount: suggestionLength,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.only(left: 20),
                textColor: kTextFieldText,
                title: Text(suggest[index]),
                onTap: (){
                  dictionaryData.addSearchTerm(suggest[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
