import '../interface/commit_formatter.dart';
import 'commitlint_exceptions.dart';

/// * Commitlint represents this commit pattern:
/// Pattern:`git commit -m "<TYPE>, [<SCOPE>], <SUBJECT>"`
/// Where:
///   1. `<TYPE> => TEST|FEAT|FIX|DOCS|CHORE`
///   2. `<SCOPE> => Any String (Optional)`
///     Tipically used to refer to project scope like Backend|FrontEnd|Mobile
///   3. `<SUBJECT> => Explain what this commit do in few words`
///
/// Usage with scope: `git commit -m "Fix, Backend, Closes #40"`
/// Usage no-scope: `git commit -m "Fix, Closes #40"`
class CommitlintFormatter extends CommitFormatter {
  static const _withScope = '<EMOJI> <TYPE>(<SCOPE>): <SUBJECT>';
  static const _withoutScope = '<EMOJI> <TYPE>: <SUBJECT>';

  static const _types = {'TEST', 'FEAT', 'FIX', 'DOCS', 'CHORE'};

  String _mapEmojiFromType(String type) {
    type = type.toUpperCase();

    const mappedEmojis = <String, String>{
      'TEST': '⚠️',
      'FEAT': '⭐',
      'FIX': '🐛',
      'DOCS': '📖',
      'CHORE': '🌱',
    };

    final emoji = mappedEmojis[type];

    return emoji;
  }

  List<String> _getPartsFromRawCommit(String rawCommit) {
    return rawCommit
        .replaceAll(RegExp(r'  *'), ' ')
        .split(RegExp(r'(,|:)'))
        .map((part) => part.trim())
        .toList();
  }

  void _validateRawCommit(String rawCommit) {
    final parts = _getPartsFromRawCommit(rawCommit);

    if (parts.length < 2) {
      throw InvalidCommitFormatException();
    }
  }

  void _validateType(String type) {
    final isValidType = _types.any(
      (validType) => RegExp(validType, caseSensitive: false).hasMatch(type),
    );

    if (!isValidType) {
      throw InvalidCommitTypeException();
    }
  }

  String _firstUpperCase(String target) {
    return target[0].toUpperCase() + target.substring(1).toLowerCase();
  }

  @override
  Map<String, String> styleFields(Map<String, String> fields) {
    fields['<TYPE>'] = _firstUpperCase(fields['<TYPE>']);
    fields['<SCOPE>'] =
        fields['<SCOPE>'] != null ? _firstUpperCase(fields['<SCOPE>']) : null;
    fields['<SUBJECT>'] = _firstUpperCase(fields['<SUBJECT>']);

    return fields;
  }

  @override
  Map<String, String> getFields(String rawCommit) {
    _validateRawCommit(rawCommit);

    final fields = <String, String>{};

    final parts = _getPartsFromRawCommit(rawCommit);

    final hasScope = parts.length > 2;

    fields['<TYPE>'] = parts[0];
    fields['<SCOPE>'] = hasScope ? parts[1] : null;
    fields['<SUBJECT>'] = hasScope ? parts[2] : parts[1];
    fields['<EMOJI>'] = _mapEmojiFromType(fields['<TYPE>']);

    _validateType(fields['<TYPE>']);

    return fields;
  }

  @override
  String getCommitTemplate(Map<String, String> fields) {
    final hasScope = fields['<SCOPE>'] != null;

    return hasScope ? _withScope : _withoutScope;
  }
}
