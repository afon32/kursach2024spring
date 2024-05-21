import 'package:flutter/material.dart';

class LoadIndicatorWidget extends StatelessWidget {
  const LoadIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
