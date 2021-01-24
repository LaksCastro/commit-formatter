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
  });
}
