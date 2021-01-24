/// * Represent a mal-formatted commit:
/// Example:
/// Bad: `git commit -m "bad commit"`
/// Ok: `git commit -m "fix, front-end, closes #40"`
class InvalidCommitFormatException implements Exception {
  @override
  String toString() {
    return '''You must commit in this format: <TYPE>, [<SCOPE>], <SUBJECT>''';
  }
}

/// * Represent a invalid commit type
/// Example:
/// Bad: `git commit -m "invalid commit type, front-end, closes #40"`
/// Ok: `git commit -m "fix, front-end, closes #40"`
class InvalidCommitTypeException implements Exception {
  @override
  String toString() {
    return '''You must commit in this format: <TYPE>, [<SCOPE>], <SUBJECT> where <TYPE> can be: 'TEST' | 'FEAT' | 'FIX' | 'DOCS' | 'CHORE''';
  }
}
