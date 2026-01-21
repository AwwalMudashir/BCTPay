import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Re-export http types so existing call sites keep working.
export 'package:http/http.dart'
    hide post, get, put, delete, patch, MultipartRequest;

String _safeBody(Object? body) {
  final text = body?.toString() ?? '';
  const maxLen = 2000;
  return text.length > maxLen ? '${text.substring(0, maxLen)}...<truncated>' : text;
}

Future<http.Response> post(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  print('[REQ] POST $url body=${_safeBody(body)}');
  final resp =
      await http.post(url, headers: headers, body: body, encoding: encoding);
  print('[RESP] POST $url status=${resp.statusCode} body=${_safeBody(resp.body)}');
  return resp;
}

Future<http.Response> get(
  Uri url, {
  Map<String, String>? headers,
}) async {
  print('[REQ] GET $url');
  final resp = await http.get(url, headers: headers);
  print('[RESP] GET $url status=${resp.statusCode} body=${_safeBody(resp.body)}');
  return resp;
}

Future<http.Response> put(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  print('[REQ] PUT $url body=${_safeBody(body)}');
  final resp =
      await http.put(url, headers: headers, body: body, encoding: encoding);
  print('[RESP] PUT $url status=${resp.statusCode} body=${_safeBody(resp.body)}');
  return resp;
}

Future<http.Response> delete(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  print('[REQ] DELETE $url body=${_safeBody(body)}');
  final resp =
      await http.delete(url, headers: headers, body: body, encoding: encoding);
  print(
      '[RESP] DELETE $url status=${resp.statusCode} body=${_safeBody(resp.body)}');
  return resp;
}

Future<http.Response> patch(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  print('[REQ] PATCH $url body=${_safeBody(body)}');
  final resp =
      await http.patch(url, headers: headers, body: body, encoding: encoding);
  print(
      '[RESP] PATCH $url status=${resp.statusCode} body=${_safeBody(resp.body)}');
  return resp;
}

class MultipartRequest extends http.MultipartRequest {
  MultipartRequest(super.method, super.url);

  @override
  Future<http.StreamedResponse> send() async {
    print(
        '[REQ] $method $url fields=$fields files=${files.map((f) => f.field).toList()}');
    final streamed = await super.send();
    final resp = await http.Response.fromStream(streamed);
    print('[RESP] $method $url status=${resp.statusCode} body=${_safeBody(resp.body)}');

    final rebuiltStream = Stream<List<int>>.fromIterable([resp.bodyBytes]);
    return http.StreamedResponse(
      rebuiltStream,
      resp.statusCode,
      contentLength: resp.contentLength,
      request: streamed.request,
      headers: resp.headers,
      reasonPhrase: resp.reasonPhrase,
      isRedirect: streamed.isRedirect,
      persistentConnection: streamed.persistentConnection,
    );
  }
}

