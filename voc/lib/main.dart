import 'package:flutter/material.dart';
import 'vocgenerator.dart';

void main() => runApp(MyApp());
VocGenerator _vocGenerator = VocGenerator();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'heyloApp',
        home: Scaffold(
          appBar: AppBar(title: Text('Welcome to my first App')),
          body: VocabGenerator(),
        ));
  }
}

class VocabGenerator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyVoc();
}

class _MyVoc extends State<VocabGenerator> {
  final _myVocs = <String>[];
  final _hearted = <String>{};
  final _hated = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to my random Voc Generator')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }
          if (i ~/ 2 >= _myVocs.length) {
            _myVocs.addAll(_generateNames());
          }
          return _buildRow(_myVocs[i ~/ 2]);
        });
  }

  Iterable<String> _generateNames() {
    List<String> myNames = [
      _vocGenerator.randomVoc(),
    ];
    return myNames;
  }

  Widget _buildRow(String myVoc) {
    final _markedFav = _hearted.contains(myVoc);
    return ListTile(
      title: Text(myVoc),
      trailing: Icon(
        _markedFav ? Icons.favorite : Icons.favorite_border,
        color: _markedFav ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          _markedFav ? _hearted.remove(myVoc) : _hearted.add(myVoc);
        });
      },
      onLongPress: () {
        _pushExample(myVoc);
      },
    );
  }

  void _pushExample(String myVoc) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        final _myVoc = myVoc;
        return Scaffold(
            appBar: AppBar(
              title: Text(_myVoc),
            ),
            body: Center(
                child: Image.network(
                    'https://library.vgu.edu.vn/wp-content/uploads/2021/04/VGU-Logo.png')));
      }),
    );
  }
}
