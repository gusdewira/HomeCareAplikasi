import 'dart:math';

class Helper {
  static int generateRandomNumber(int length) {
    Random random = Random();
    if (length < 1) {
      throw ArgumentError('Length should be at least 1');
    }
    int min = pow(10, length - 1) as int;
    int max = pow(10, length) - 1 as int;
    return min + random.nextInt(max - min + 1);
  }
}