library component2;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


int multiply(int i, int j) {
  return i * j;
}

class MultiPandaScreen extends StatelessWidget {

  MultiPandaScreen() {}

   @override
   Widget build(BuildContext context) {
      return Container(
        child: Image.asset('customassets/multiple_pandas.jpg'),
        padding: EdgeInsets.all(25),
        color: Colors.green,
      );
   }
}