import 'dart:convert';
import 'dart:io';

String getString(String path) {
  String string = "";
  File file = File(path);
  if (file.existsSync()) {
    string = file.readAsStringSync();
  }
  return string;
}

List<String> getAllStrings() {
  List<String> strings = [];
  List<FileSystemEntity> entities =
      Directory("/Users/rajkumar/Desktop/Raj/Flutter\\ Projects/bctpay/")
          .listSync(recursive: true);
  for (FileSystemEntity entity in entities) {
    if (entity.path.endsWith(".dart")) {
      String string = getString(entity.path);
      strings.addAll(string.split('"'));
    }
  }
  return strings;
}

void getAllStringsOfProject() {
  // Get all the strings in your project.
  final strings = getAllStrings1();

  // Create a .arb file.
  final arbFile = File(
      '/Users/rajkumar/Desktop/Raj/Flutter Projects/bctpay/lib/l10n/app_en.arb');

  // Write the strings to the .arb file.
  arbFile.writeAsStringSync(json.encode(strings.toList()));
}

// Get all the strings in your project.
Iterable<String?> getAllStrings1() {
  // Get all the files in your project.
  final files =
      Directory('/Users/rajkumar/Desktop/Raj/Flutter Projects/bctpay/lib')
          .listSync();

  // Filter the files to only include Dart files.
  final dartFiles = files.where((file) => file.path.endsWith('.dart'));

  // Iterate over the Dart files and get all the strings.
  final strings = dartFiles.map((file) {
    final contents = file.resolveSymbolicLinksSync();
    // readAsStringSync
    return _extractStringsFromDart(contents);
  });

  // Return the list of strings.
  return strings.expand((string) => string);
}

// Extract the strings from a Dart file.
List<String?> _extractStringsFromDart(String contents) {
  // Create a regex to match string literals.
  final regex = RegExp(r"'(.*?)' | '(.*?)'");

  // Get all the matches for the regex.
  final matches = regex.allMatches(contents);

  // Return the list of strings.
  return matches.map((match) => match.group(0)).toList();
}

