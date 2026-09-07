import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<void> pumpWidgetWithMaterial(
    Widget widget,
  ) async {
    await pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: widget,
          ),
        ),
      ),
    );
  }
}
