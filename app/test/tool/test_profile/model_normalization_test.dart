// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:test/test.dart';

import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_dev/tool/test_profile/normalizer.dart';

void main() {
  group('normalization tests', () {
    test('a package with a publisher', () {
      expect(
        normalize(TestProfile.fromYaml(
          '''
defaultUser: user@domain.com
packages:
  - name: foo
    publisher: example.com
    versions: ['1.0.0', '2.0.0']
''',
        )).toJson(),
        {
          'packages': [
            {
              'name': 'foo',
              'publisher': 'example.com',
              'versions': ['1.0.0', '2.0.0']
            }
          ],
          'publishers': [
            {
              'name': 'example.com',
              'members': [
                {
                  'email': 'user@domain.com',
                  'role': 'admin',
                }
              ]
            }
          ],
          'users': [
            {
              'email': 'user@domain.com',
              'likes': [],
            }
          ],
          'defaultUser': 'user@domain.com',
        },
      );
    });

    test('a package without publisher', () {
      expect(
        normalize(TestProfile.fromYaml(
          '''
defaultUser: user@domain.com
packages:
  - name: foo
    versions: ['1.0.0', '2.0.0']
''',
        )).toJson(),
        {
          'packages': [
            {
              'name': 'foo',
              'uploaders': ['user@domain.com'],
              'versions': ['1.0.0', '2.0.0']
            }
          ],
          'publishers': [],
          'users': [
            {
              'email': 'user@domain.com',
              'likes': [],
            }
          ],
          'defaultUser': 'user@domain.com'
        },
      );
    });

    test('resolved versions', () {
      expect(
        normalize(
          TestProfile.fromYaml('''
defaultUser: user@domain.com
packages:
  - name: foo
'''),
          resolvedVersions: [
            ResolvedVersion(
              package: 'foo',
              version: '1.1.0',
              created: DateTime.now(),
            ),
          ],
        ).toJson(),
        {
          'packages': [
            {
              'name': 'foo',
              'uploaders': ['user@domain.com'],
              'versions': ['1.1.0']
            }
          ],
          'publishers': [],
          'users': [
            {
              'email': 'user@domain.com',
              'likes': [],
            }
          ],
          'defaultUser': 'user@domain.com',
        },
      );
    });
  });
}
