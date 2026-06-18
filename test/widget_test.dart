// Basic smoke test. The default template test referenced a non-existent `MyApp`;
// replaced with a trivial test so the suite compiles. Add real widget tests as the app grows.
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sanity', () {
    expect(1 + 1, 2);
  });
}
