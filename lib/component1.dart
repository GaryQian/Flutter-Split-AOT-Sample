library component1;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


int add(int i, int j) {
  return i + j;
}

class PandaScreen extends StatelessWidget {

  PandaScreen() {}

   @override
   Widget build(BuildContext context) {
      return Container(
        child: Image.asset('customassets/panda.jpg'),
        padding: EdgeInsets.all(25),
        color: Colors.green,
      );
   }
}