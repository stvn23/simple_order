import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  test('computeTip calculates correct tip and total', () {
    final result = computeTip(100.0, 15);
    expect(result.tip, 15.0);
    expect(result.total, 115.0);
  });
}