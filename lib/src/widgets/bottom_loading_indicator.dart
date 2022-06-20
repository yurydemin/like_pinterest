import 'package:flutter/material.dart';

class BottomLoadingIndicator extends StatelessWidget {
  const BottomLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2.0),
      ),
    );
  }
}
