import 'shell.dart';

void main(List<String> args) async {
  await shell.run('flutter format .');
  await shell.run('git add .');
}
