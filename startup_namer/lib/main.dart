import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords>{
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context){
        final titles = _saved.map((pair){
          return new ListTile(
            title: new Text(pair.asPascalCase , style: _biggerFont,),
          );
        },
        );
        final divided = ListTile.divideTiles(context:  context, tiles: titles).toList();
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided,),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup New Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if(i.isOdd) return new Divider();
        final index = i ~/2;
        if(index >= _suggestion.length){
          _suggestion.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestion[index]);
      }
    );
  }

  Widget _buildRow(WordPair covariant){
    final alreadySaved = _saved.contains(covariant);
    return new ListTile(
      title: new Text(
        covariant.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red: null,
      ),
      onTap: (){
        setState((){
          if(alreadySaved){
            _saved.remove(covariant);
          }else{
            _saved.add(covariant);
          }
        });
      },
    );
  }
}