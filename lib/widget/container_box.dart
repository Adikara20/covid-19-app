import 'package:flutter/material.dart';

class ContainerBox extends StatelessWidget {
  final Widget widget;
  final double sizeWidth;
  final double sizeHeight;
  const ContainerBox(
      {Key? key,
      required this.widget,
      required this.sizeWidth,
      required this.sizeHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeWidth,
      height: sizeHeight,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        //color: Colors.blue,
        elevation: 10,
        child: widget,
      ),
    );
  }
}
