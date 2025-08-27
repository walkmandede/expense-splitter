import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvHelper {
  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }
}
