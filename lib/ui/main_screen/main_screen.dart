import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends ConsumerWidget {
  final String userName;
  const MainScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(userName),
      ),
    );
  }
}
