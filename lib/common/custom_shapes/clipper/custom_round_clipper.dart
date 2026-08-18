import 'package:flutter/material.dart';
class SCustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path =Path();

    //top to bottom line
    path.lineTo(0, size.height-40);

    //first curve
    Offset fPointCurve1= Offset(40, size.height);
    Offset sPointCurve1= Offset(size.width/2, size.height);

    path.quadraticBezierTo(fPointCurve1.dx, fPointCurve1.dy, sPointCurve1.dx, sPointCurve1.dy);

    //second curve
    Offset fPointCurve2= Offset(size.width-40, size.height);
    Offset sPointCurve2= Offset(size.width, size.height-40);

    path.quadraticBezierTo(fPointCurve2.dx, fPointCurve2.dy, sPointCurve2.dx, sPointCurve2.dy);

    //bottom to top line
    path.lineTo(size.width, 0);


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}