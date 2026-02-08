import 'package:html/parser.dart' as html_parser;

class HtmlHelper {
  /// Converts HTML string to plain text by stripping tags.
  static String stripHtml(String htmlString) {
    if (htmlString.isEmpty) return "";
    final document = html_parser.parse(htmlString);
    final String parsedString = document.body?.text ?? "";
    return parsedString;
  }
}
