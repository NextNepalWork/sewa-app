import 'package:flutter/foundation.dart';

class APIBase {
  static String get baseUrl {
    if (kReleaseMode) {
      return 'https://sewaexpress.com/api/v1/';
    } else {
      return "https://sewaexpress.com/api/v1/";
    }
  }
}
