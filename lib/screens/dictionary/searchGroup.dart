import 'package:flutter/material.dart';
import 'package:handsfree/provider/dictionaryProvider.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/widgets/constants.dart';

class SearchGroup extends StatelessWidget {
  const SearchGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DictionaryProvider>(builder: (context, dict, child) {
      return Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
            height: dict.suggestion.length == 1
                ? 95
                : dict.suggestion.length <= 4
                    ? 102 + (dict.suggestion.length - 1) * 50
                    : 110 + 3 * 50,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: dict.suggestion.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  textColor: kTextFieldText,
                  title: Text(dict.suggestion[index].word),
                  onTap: () {
                    dict.addSearchTerm(dict.suggestion[index].word);
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
