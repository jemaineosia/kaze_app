import 'package:flutter_test/flutter_test.dart';
import 'package:kaze_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('BetServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}