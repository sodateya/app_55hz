import 'package:flutter/material.dart';

class SketchPage extends StatefulWidget {
  @override
  _SketchPageState createState() => _SketchPageState();
}

class _SketchPageState extends State<SketchPage> {
  double xValue = 0;
  double yValue = 0;

  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Etch A Sketch'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                points.clear();
                xValue = 0;
                yValue = 0;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  painter: SketchPainter(points),
                  size: Size.infinite,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 200, // adjust the height of the slider
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Slider(
                        value: yValue,
                        min: 0,
                        max: screenSize.height,
                        onChanged: (value) {
                          setState(() {
                            yValue = value;
                            points.add(Offset(xValue, yValue));
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Slider(
            value: xValue,
            min: 0,
            max: screenSize.width,
            onChanged: (value) {
              setState(() {
                xValue = value;
                points.add(Offset(xValue, yValue));
              });
            },
          ),
        ],
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Offset> points;

  SketchPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(SketchPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
