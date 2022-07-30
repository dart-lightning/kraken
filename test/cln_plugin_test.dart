import 'package:test/test.dart';

int sum(int a, int b) {
  return a + b;
}

void main() {
  test('sum', () {
    expect(sum(2, 8), 10);
  });
}
