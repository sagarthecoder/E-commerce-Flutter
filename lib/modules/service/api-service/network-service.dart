import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../api-cache-service/api-cache-service.dart';
import 'generic-response.dart';

enum RequestMethod { get, post, put, delete }

class NetworkService {
  NetworkService._(this._dio);

  static final NetworkService shared = NetworkService._(Dio());

  factory NetworkService() {
    return shared;
  }

  final Dio _dio;

  // Generic API Request Method
  Future<GenericResponse<T>?> genericApiRequest<T>(
      String url,
      RequestMethod requestMethod,
      T Function(dynamic) parseItem, // Function to parse each list item
      {Map<String, dynamic>? headers,
      dynamic body,
      ResponseType responseType = ResponseType.json}) async {
    final hasNetwork = await InternetConnection().hasInternetAccess;
    print('Network = $hasNetwork');

    try {
      Options options = Options(
        method: requestMethod.toString().split('.').last.toUpperCase(),
        headers: headers,
        responseType: responseType,
      );
      Response? response;

      if (hasNetwork) {
        // Online Mode: Make network call
        switch (requestMethod) {
          case RequestMethod.get:
            response = await _dio.get(url, options: options);
            break;
          case RequestMethod.post:
            response = await _dio.post(url, data: body, options: options);
            break;
          case RequestMethod.put:
            response = await _dio.put(url, data: body, options: options);
            break;
          case RequestMethod.delete:
            response = await _dio.delete(url, options: options);
            break;
        }

        int? statusCode = response?.statusCode;
        if (statusCode != null && statusCode >= 200 && statusCode < 300) {
          // Check if response data is a simple list
          if (response?.data is List) {
            return GenericResponse.fromList(
                response?.data as List<dynamic>, parseItem);
          } else {
            // Otherwise, parse as JSON response
            final result = {
              'data': response?.data,
              'message': response?.statusMessage,
              'status': statusCode.toString(),
            };
            return GenericResponse.fromJson(result, (json) => parseItem(json));
          }
        } else {
          throw Exception('Failed to load data: ${response?.statusCode}');
        }
      } else {
        // Offline Mode: Retrieve data from cache
        if (requestMethod != RequestMethod.get) {
          return null;
        }
        final cachedResponse = await APICacheService.shared.fetchResponse(url);
        if (cachedResponse != null) {
          final decodedData = utf8.decode(base64Decode(cachedResponse));
          final cachedJson = jsonDecode(decodedData);

          if (cachedJson is List) {
            return GenericResponse.fromList(cachedJson, parseItem);
          } else {
            return GenericResponse.fromJson(
                cachedJson, (json) => parseItem(json));
          }
        } else {
          print('Cache response is null.');
          return null;
        }
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
