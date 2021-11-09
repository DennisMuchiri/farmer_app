import 'package:chopper/chopper.dart';
import 'dart:io';
import 'package:http/io_client.dart' as http;

part 'post_api_service.chopper.dart';

String baseUrlStr = 'https://incident-api-staging.adriangroup.app/';

@ChopperApi(baseUrl: '')
abstract class PostApiService extends ChopperService {
  @Get(path: 'farmer/?depth={depth}&&limit={limit}')
  Future<Response> get_farmer_limit(

    @Path('limit') String limit,
    @Path('depth') String depth,
  );

  @Get(path: 'notif/?depth={depth}&&limit={limit}')
  Future<Response> get_notif_limit(

    @Path('limit') String limit,
    @Path('depth') String depth,
  );

  //location
  @Get(path: 'location/?depth={depth}&&limit={limit}')
  Future<Response> req_ehs_get_location_limit(

      @Path('limit') String limit,
      @Path('depth') String depth,
      );

  @Patch(path: 'location/{id}/')
  Future<Response> req_ehs_patch_location(

      @Path('id') int id,
      @Body() Map<String, dynamic> map);

  @Post(path: 'location/')
  Future<Response> req_ehs_post_location(

      @Body() Map<String, dynamic> map);
  //end of location

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
