import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseNetwork {
  factory BaseNetwork() {
    return _singleton;
  }
  BaseNetwork._internal() {
    _init();
  }

  static final BaseNetwork _singleton = BaseNetwork._internal();

  Future<String> _getAuthorizationToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token") ?? '';
  }

  Dio _dio;

  Dio _tokenDio;

  dynamic _init() {
    // Token Dio with no Header
    _tokenDio = Dio();
    _tokenDio.options = BaseOptions(
      baseUrl: "https://networkintern.herokuapp.com",
      validateStatus: (status) => status < 500,
    );

    _dio = Dio();
    _dio.options = BaseOptions(
      baseUrl: "https://networkintern.herokuapp.com",
      validateStatus: (status) => status < 500,
    );

    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options) async {
        String token = await _getAuthorizationToken();
        options.headers["Authorization"] = "Bearer $token";
        return options;
      }, onResponse: (response) async {
        if (response?.statusCode == 401) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();

          final options = response.request;

          Response refreshResponse = await _tokenDio.post(
            '/api/refresh',
            data: FormData.fromMap({
              "token": _getAuthorizationToken(),
            }),
          );
          if (refreshResponse.statusCode == 200) {
            SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
            sharedPreferences.setString("token", refreshResponse.data["token"]);
          } else {
            _dio.interceptors.requestLock.unlock();
            _dio.interceptors.responseLock.unlock();
            // Logout
            SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
            await sharedPreferences.clear();
            // Navigate to Login Page

            return response;
          }
          options.headers["Authorization"] =
          "Bearer ${_getAuthorizationToken()}";

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();

          if (options.data is FormData) {
            final formData = FormData();
            formData.fields.addAll(options.data.fields);
            options.data = formData;
          }

          return _dio.request(options.path, options: options);
        }
      }),
    );
  }

  Dio get ref => _dio;
  Dio get tokenRef => _tokenDio;
}

final dioClient = BaseNetwork();
