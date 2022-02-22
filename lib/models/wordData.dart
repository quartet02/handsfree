class WordData{
  final String word;
  final String imgUrl;
  final String definition;
  final String phoneticSymbol;

  WordData({required this.word, required this.imgUrl, required this.definition, required this.phoneticSymbol});
}

List<WordData> words = wordData
    .map(
      (item) => WordData(word: item['word'] as String, imgUrl: item['imgUrl'] as String, definition: item['definition'] as String, phoneticSymbol: item['phoneticSymbol'] as String),
)
    .toList();

var wordData = [
  {
    "word": 'Hello',
    'imgUrl': 'none',
    'definition': 'Just hello',
    'phoneticSymbol': "/həˈləʊ,hɛˈləʊ/",
  },
  {
    "word": 'Hello',
    'imgUrl': 'none',
    'definition': 'Just hello',
    'phoneticSymbol': "/həˈləʊ,hɛˈləʊ/",
  },
  {
    "word": 'Hello',
    'imgUrl': 'none',
    'definition': 'Just hello',
    'phoneticSymbol': "/həˈləʊ,hɛˈləʊ/",
  },
  {
    "word": 'Hello',
    'imgUrl': 'none',
    'definition': 'Just hello',
    'phoneticSymbol': "/həˈləʊ,hɛˈləʊ/",
  },
  {
    "word": 'Hello',
    'imgUrl': 'none',
    'definition': 'Just hello',
    'phoneticSymbol': "/həˈləʊ,hɛˈləʊ/",
  },
];
