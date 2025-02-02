// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:pub_dev/analyzer/pana_runner.dart';
import 'package:test/test.dart';

void main() {
  test('static analysis options is available', () {
    expect(pedanticAnalysisOptionsYaml.trim(), isNotEmpty);
    expect(pedanticAnalysisOptionsYaml, contains('unawaited_futures'));
  });
}
