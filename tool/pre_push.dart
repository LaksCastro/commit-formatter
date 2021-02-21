import 'shell.dart';

void main(List<String> args) async {
  await shell.run('flutter analyze');
  await shell.run('pub run test');
}
