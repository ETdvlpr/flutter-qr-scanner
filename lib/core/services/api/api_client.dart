/*
  configure api client for restFull requests
*/
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scanner/core/enums/common_enums.dart';
import 'package:scanner/core/services/api/dio_client.dart';
import 'package:scanner/core/services/api/network_exceptions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiClient {
  late DioClient dioClient;
  final Dio dio;

  ApiClient({required this.dio}) {
    // dio.options = baseOptions;
    dioClient = DioClient(dio);
  }
  // Todo: setup and configure restful api client here. e.g dio.

  Future<Map<String, dynamic>> request({
    RequestType requestType = RequestType.get,
    bool requiresAuth = true,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (requiresAuth) await dioClient.addAuthorizationInterceptor();

      // log('path: $kBaseUrl$path');
      log('sent payload: $data');
      dynamic response;
      switch (requestType) {
        case RequestType.get:
          response =
              await dioClient.get(path, queryParameters: queryParameters);
          break;
        case RequestType.post:
          response = await dioClient.post(path, data: data);
          break;
        case RequestType.patch:
          response = await dioClient.patch(path, data: data);
          break;
        case RequestType.delete:
          response = await dioClient.delete(path);
          break;
        case RequestType.put:
          response = await dioClient.put(path, data: data);
          break;
        default:
          throw "Request type not found.";
      }

      log('raw response: $response');
      return (response is String) ? jsonDecode(response) : response;
    } on DioException catch (e) {
      final errorMessage = NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e));
      log('Api Error: $errorMessage');
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  // sends form data for single or multiple files
  Future<Map<String, dynamic>> sendFormData({
    required String fileFieldName,
    required Map<String, dynamic> formPayload,
    required String endPoint,
    String? port,
    File? file,
    List<File>? files,
  }) async {
    try {
      // For multiple files case
      if (files?.isNotEmpty ?? false) {
        List<MultipartFile> multipartFiles = [];
        for (File file in files!) {
          String? mimeType = lookupMimeType(file.path);
          List<String> splitMimeTypes = mimeType?.split('/') ?? [];

          final MultipartFile multipartFile = MultipartFile.fromFileSync(
              file.path,
              contentType: MediaType(splitMimeTypes[0], splitMimeTypes[1]));

          multipartFiles.add(multipartFile);
        }

        formPayload[fileFieldName] = multipartFiles;
      } else if (file?.path.isNotEmpty ?? false) {
        // case for single file form data
        String? mimeType = lookupMimeType(file!.path);
        List<String> splitMimeTypes = mimeType?.split('/') ?? [];

        final MultipartFile multipartFile = MultipartFile.fromFileSync(
            file.path,
            contentType: MediaType(splitMimeTypes[0], splitMimeTypes[1]));
        formPayload[fileFieldName] = multipartFile;
      }
      // final accessToken = GetStorage().read('accessToken');
      // formPayload['access_token'] = accessToken;
      log('form payload here: $formPayload');
      var formData = FormData.fromMap(formPayload);

      final response = await dioClient.post(endPoint, data: formData);
      // Iterable l = json.decode(jsonEncode(response));
      // return List<Files>.from(l.map((model) => Files.fromJson(model)).toList());

      return (response is String) ? jsonDecode(response) : response;
    } on DioException catch (e) {
      final errorMessage = NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e));
      print(errorMessage);
      // toast('error', e.response?.data['message']);
      return Future.error(errorMessage);
    }
  }
}
