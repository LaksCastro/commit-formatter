import 'package:commit_formatter/commit_formatter.dart';
import 'package:test/test.dart';

void main() {
  final commitlintFormatter = CommitlintFormatter();

  group('class CommitlintFormatter { ... }', () {
    test('Basic feature', () {
      expect(
        commitlintFormatter.formatThis('Fix,Backend,Closes Issue #40'),
        '${CommitlintFormatter.emojis["FIX"]} Fix(Backend): Closes issue #40',
      );
    });
    test('Throws Invalid Type when a invalid type is provided', () {
      void _throwInvalidType() {
        commitlintFormatter.formatThis('Tests,Backend,Closes Issue #40');
      }

      expect(
        _throwInvalidType,
        throwsA(isA<InvalidCommitTypeException>()),
      );
    });
  });
}
