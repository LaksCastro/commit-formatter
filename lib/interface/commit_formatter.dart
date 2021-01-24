import 'package:meta/meta.dart';

/// * Interface that represents a commmit formatter in this context:
/// 1. Developer type a commit message and press enter
/// 2. `prepare_commit_msg` hook is called
/// 3. Commit formatter take the raw commit typed by the developer
/// 4. And return an formatted String
///
/// _Note: this is an `abstract class`, so,
/// the subclasses need to explicity the formatter behavior_
abstract class CommitFormatter {
  /// * Main method, used to fill a subclass template with formatter fields:
  /// ```
  /// void prepareCommitMsg() {
  ///   final formatter = CommitFormatter(); // Use a subclass instead this
  ///
  ///   final formattedCommit = formatter
  ///                             .formatThis('fix, front-end: close #40');
  ///
  ///   setCommitMessage(formattedCommit); // 🐛 Fix(Front-End): Close #40
  /// }
  /// ```
  String formatThis(String rawCommit) {
    final fields = styleFields(getFields(rawCommit));

    var commitTemplate = getCommitTemplate(fields);

    fields.removeWhere((_, value) => value == null);

    fields.forEach((k, v) => commitTemplate = commitTemplate.replaceAll(k, v));

    return commitTemplate;
  }

  /// * Override this method to define all vars/fields of your formatter
  /// Example from raw commit `fix, backend, closes #40`
  /// Use this method to extract the:
  /// 1. <TYPE> (`fix`),
  /// 2. <SCOPE> (`backend`)
  /// 3. <SUBJECT> (`closes #40`)
  ///
  /// Put it on a map:
  /// ```
  /// {
  ///   '<TYPE>': 'fix',
  ///   '<SCOPE>': 'backend',
  ///   '<SUBJECT>': 'closes #40'
  /// }
  /// ```
  ///
  /// and return it
  @protected
  Map<String, String> getFields(String rawCommit);

  /// * Use this method to change any field, like a uppercase or camel case
  @protected
  Map<String, String> styleFields(Map<String, String> fields) => fields;

  /// * Use this method to return an commit template based on what fields
  /// * the rawCommit offers
  ///
  /// `fields` are the map that your classes returned from `getFields()` method
  @protected
  String getCommitTemplate(Map<String, String> fields);
}
