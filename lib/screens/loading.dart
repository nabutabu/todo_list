import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const SpinKitCircle(
        color: Colors.purple,
        size: 50.0,
      ),
    );
  }
}
