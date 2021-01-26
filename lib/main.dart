import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'component1.dart' deferred as component1;
import 'component2.dart' deferred as component2;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Deferred Components Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Panda Viewatron 5000'),
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
    if (_counter < 100) {
      return component1.loadLibrary()
        .then((_) {
          setState(() {
            int i = component1.add(_counter, 20);
            _counter = i;
            dynamicWidget = component1.PandaScreen();
          });
        }, onError: (e) {
            print(e.toString());
          }
        );
    } else {
      return component2.loadLibrary()
        .then((_) {
          setState(() {
            int i = component2.multiply(_counter, 2);
            _counter = i;
            dynamicWidget = component2.MultiPandaScreen();
          });
        }, onError: (e) {
            print(e.toString());
          }
        );
    }
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
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('customassets/bamboo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Panda Points:',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '(the more panda points, the better!)',
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
