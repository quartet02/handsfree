import 'package:flutter/material.dart';
import 'package:handsfree/provider/dictionaryProvider.dart';
import 'package:handsfree/screens/dictionary/translator.dart';
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
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: kTextShadow,
                  offset: Offset(6, 6),
                  blurRadius: 6,
                ),
              ],
            ),
            height: dict.suggestion.length == 0
                ? 0
                : dict.suggestion.length == 1
                    ? MediaQuery.of(context).size.width / 3
                    : dict.suggestion.length == 2
                        ? MediaQuery.of(context).size.width / 2.3
                        : dict.suggestion.length == 3
                            ? MediaQuery.of(context).size.width / 1.66666666
                            : MediaQuery.of(context).size.width /
                                (1.3333333333),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: dict.suggestion.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  textColor: kTextFieldText,
                  title: Text(dict.suggestion[index].word),
                  onTap: () {
                    dict.addSearchTerm(dict.suggestion[index].word);
                    final provider = context.read<DictionaryProvider>();
                    List? wordData = provider.wordData;
                    Map search = wordData!.firstWhere(
                        (word) => word["word"] == dict.suggestion[index].word);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Translator(
                            search['word'],
                            search['definition'],
                            search['phoneticSymbol'],
                            search['imgUrl']),
                        maintainState: false));
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
