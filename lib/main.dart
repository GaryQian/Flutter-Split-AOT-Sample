import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'split_module.dart' deferred as module;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'PandaViewatron5000'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<void> result;
  Widget dynamicWidget = CircularProgressIndicator();

  void _incrementCounter() {
    setState(() {
      _counter++;
      result = testload();
    });
  }

  // Loads the split AOT library, and sets the widget to [PandaScreen]
  Future<void> testload() async {
    return module.loadLibrary().then((_) {
      setState(() {
        int i = module.add(_counter, 20);
        _counter = i;
        dynamicWidget = module.PandaScreen();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Image.asset('customassets/bamboo.jpeg', fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'PandaPoints:',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '(the more pandas, the higher!)',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Container(height: 10),
                Text(
                  '$_counter',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                Container(height: 10),
                _counter == 0 ?
                    Text(
                      'Split feature goes here, Press button to load', 
                      style: TextStyle(fontSize: 25, color: Colors.white), 
                      textAlign: TextAlign.center,
                    )
                  : dynamicWidget,
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
