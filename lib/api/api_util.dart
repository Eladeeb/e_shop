import 'package:connectivity/connectivity.dart';
import 'package:e_shopp/exceptions/exceptions.dart';

class ApiUtl {
  static const String MAIN_API_URL = 'http://10.0.2.2:8000/api/';
  static const String AUTH_REGISTER = 'http://10.0.2.2:8000/api/auth/register';
  static const String AUTH_LOGIN = 'http://10.0.2.2:8000/api/auth/login';
  static const String COUNTRIES = MAIN_API_URL + 'countries';

  static String CITIES(int id) {
    return COUNTRIES + '/' + id.toString() + '/cities';
  }

  static const String CATEGORIES = MAIN_API_URL + 'categories';
  static const String TAGS = MAIN_API_URL + 'tags';
  static String CATEGORYBYID(int id) {
    return CATEGORIES + '/' + id.toString() + '/products';
  }

  static String STATES(int id) {
    return COUNTRIES + '/' + id.toString() + '/states';
  }
}
  Future<void> checkInterner()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      throw NoInternetConnection();
    }
  }
