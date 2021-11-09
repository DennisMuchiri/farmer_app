import 'package:chopper/chopper.dart';
import 'dart:io';
import 'package:http/io_client.dart' as http;
import 'package:farmer_app/injection/injection.dart';
import 'package:injectable/injectable.dart';

part 'post_api_service.chopper.dart';

String baseUrlStr = 'https://testapi.io/api/thomasjgx/farmers/';

@ChopperApi(baseUrl: '')
abstract class PostApiService extends ChopperService {
  @Get(path: 'farmers')
  Future<Response> get_farmers();

  @injectable
  static PostApiService create() {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      return true;
    });

    final client = ChopperClient(
      client: http.IOClient(ioc),
      baseUrl: baseUrlStr,
      services: [
        _$PostApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );

    return _$PostApiService(client);
  }
}
