// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    double sw=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Container(
      width: sw,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Text(
        'HelloLong text Long text here which is lonLong text here which is lonLong text here which is lonhere which is longer than the container height Long text here which is lonLong text here which is lonLong text here which is lonLong text here which is lon',
        style: TextStyle(
          fontSize: 40,

        ),

      ),
    ),
    );
    
    
  }
}

