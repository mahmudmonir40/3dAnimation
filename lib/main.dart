import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3d Card Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double x = 0;
  double y = 0;
  double amplitude = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191d2d),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Transform(
            alignment: FractionalOffset.center,

            transform: Matrix4.identity()
              ..rotateX(x)
              ..rotateY(y), // we will use matrix4, to rotate our card in the space

            child: GestureDetector(
              onPanUpdate: (details){
              //now let's apply the rotation on drag

              if(y - details.delta.dx < 0){
                setState(() {
                  y = max(y - details.delta.dx /100, -amplitude);
                });
              }else{

                setState(() {
                  y = min(y - details.delta.dx /100, amplitude);
                });
              }

              //same thing for x

              if(x - details.delta.dy < 0){
                setState(() {
                  x = min(x - details.delta.dy /100, -amplitude);
                });
              }else{

                setState(() {
                  x = max(x - details.delta.dy /100, amplitude);
                });

                print("x = ${x}");
                print("y = ${y}");
              }

              },

              child: Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/bitcoin.png"),
                        fit: BoxFit.cover),

                    // let's set the box shadow
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xaa3020f8),
                        blurRadius: 28,
                        offset: Offset(x * 10, y * 10),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
