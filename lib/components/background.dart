import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.bottomImage = "",
  }) : super(key: key);

  final String bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}