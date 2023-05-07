import 'package:flutter_dotenv/flutter_dotenv.dart';

// To set the environment, we use the dependency flutter_dotenv
// Go to https://pub.dev/packages/flutter_dotenv to learn about
// 
// You have to create the file '.env' in the main direct
// In this file you must put your own in the key
// Go to https://api.nasa.gov/ to get your
//
// On the file .env you have to put your key, this way: API_KEY=youKey
// No space and keeping key name 'API_KEY'

class Environment {
  static String get apidKey => dotenv.env['API_KEY'].toString();
}