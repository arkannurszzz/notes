import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class EnvServices extends GetxService {
  Future<EnvServices> init() async {
    await dotenv.load(fileName: ".env");
    return this;
  }

  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
}
