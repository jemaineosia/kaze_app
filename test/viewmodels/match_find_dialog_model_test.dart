import 'package:flutter_test/flutter_test.dart';
import 'package:kaze_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('MatchFindDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
