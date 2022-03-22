class Utils {
  static String cleanString(String stringToClean) {
    return stringToClean.trim();
  }
}

//TODO: this can't *possibly* the best way to do this...
extension FriendlyDisplayFormat on DateTime {
  String toFriendlyDisplayString() {
    return '$month/$day/$year $hour:${minute.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
  }
}

extension ToTitleCase on String {
  String toTitleCase() {
    return toLowerCase().replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
        (Match match) {
      if (titleCaseExceptions.contains(match[0])) {
        return match[0]!;
      }
      return '${match[0]![0].toUpperCase()}${match[0]!.substring(1).toLowerCase()}';
    }).replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}

const List<String> titleCaseExceptions = [
  'a',
  'abaft',
  'about',
  'above',
  'afore',
  'after',
  'along',
  'amid',
  'among',
  'an',
  'apud',
  'as',
  'aside',
  'at',
  'atop',
  'below',
  'but',
  'by',
  'circa',
  'down',
  'for',
  'from',
  'given',
  'in',
  'into',
  'lest',
  'like',
  'mid',
  'midst',
  'minus',
  'near',
  'next',
  'of',
  'off',
  'on',
  'onto',
  'out',
  'over',
  'pace',
  'past',
  'per',
  'plus',
  'pro',
  'qua',
  'round',
  'sans',
  'save',
  'since',
  'than',
  'thru',
  'till',
  'times',
  'to',
  'under',
  'until',
  'unto',
  'up',
  'upon',
  'via',
  'vice',
  'with',
  'worth',
  'the","and',
  'nor',
  'or',
  'yet',
  'so'
];
