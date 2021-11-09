// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PostApiService;

  @override
  Future<Response<dynamic>> get_farmer_limit(String limit, String depth) {
    final $url = 'farmer/?depth=${depth}&&limit=${limit}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> get_notif_limit(String limit, String depth) {
    final $url = 'notif/?depth=${depth}&&limit=${limit}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> req_ehs_get_location_limit(
      String limit, String depth) {
    final $url = 'location/?depth=${depth}&&limit=${limit}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> req_ehs_patch_location(
      int id, Map<String, dynamic> map) {
    final $url = 'location/${id}/';
    final $body = map;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> req_ehs_post_location(Map<String, dynamic> map) {
    final $url = 'location/';
    final $body = map;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
