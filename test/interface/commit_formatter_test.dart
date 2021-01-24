import 'package:commit_formatter/commit_formatter.dart';
import 'package:test/test.dart';

class MockFormatter extends CommitFormatter {
  @override
  String getCommitTemplate(Map<String, String> fields) {
    return '(FIELD_1): (FIELD_2) - FIELD_N';
  }

  @override
  Map<String, String> getFields(String rawCommit) {
    return <String, String>{
      'FIELD_1': 'value_1',
      'FIELD_2': 'value_2',
      'FIELD_N': 'value_n',
    };
  }
}

void main() {
  final mockFormatter = MockFormatter();

  group('class CommitFormatter { ... }', () {
    test('Basic feature', () {
      expect(
        mockFormatter.formatThis('Mock commit'),
        '(value_1): (value_2) - value_n',
      );
    });
  });
}
