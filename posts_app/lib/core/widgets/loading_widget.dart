import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child:
            SizedBox(height: 40, width: 40, child: CircularProgressIndicator()),
      ),
    );
  }
}
