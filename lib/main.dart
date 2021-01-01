import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as v_math;

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isMagnified = false;
  AnimationController _controller;
  Animation<double> _animatedAngle;
  Animation<double> _animatedSize;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animatedAngle = Tween(begin: v_math.radians(0), end: v_math.radians(45))
        .animate(_controller);
    _animatedSize = Tween(begin: 150.0, end: 250.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onClick() {
    setState(() {
      isMagnified = !isMagnified;
    });

    if (isMagnified) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    onClick();
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    child: Image.asset('assets/images/pic1.png'),
                    builder: (context, child) {
                      return Container(
                        width: _animatedSize.value,
                        height: _animatedSize.value,
                        child: Transform.rotate(
                            angle: _animatedAngle.value, child: child),
                      );
                    },
                  )),
              AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: isMagnified ? 0 : 1,
                  child: Text("Click to rotate"))
            ],
          ),
        ),
      ),
    );
  }
}
