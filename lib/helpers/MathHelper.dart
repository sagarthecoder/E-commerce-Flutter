import 'dart:math';

final class MathHelper {
  static double getRandomDoubleInRange(double min, double max) {
    final random = Random();
    return min + (random.nextDouble() * (max - min));
  }

  static double mapValue({
    required double oldMin,
    required double oldMax,
    required double oldValue,
    required double newMin,
    required double newMax,
  }) {
    double oldRange = oldMax - oldMin;
    double normalizedOldValue = (oldValue - oldMin) / oldRange;
    double newRange = newMax - newMin;
    return newMin + (normalizedOldValue * newRange);
  }
}
