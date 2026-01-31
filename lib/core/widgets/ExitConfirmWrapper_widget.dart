import 'package:almonafs_flutter/core/widgets/ExitConfirmDialog.dart';
import 'package:flutter/material.dart';

class ExitConfirmWrapper extends StatelessWidget {
  final Widget child;

  const ExitConfirmWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await ExitConfirmDialog.show(context);
        return false;
      },
      child: child,
    );
  }
}
