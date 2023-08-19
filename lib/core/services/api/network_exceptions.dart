import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.badRequest();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.connectionError:
              networkExceptions = const NetworkExceptions.unexpectedError();
              break;

            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  networkExceptions =
                      const NetworkExceptions.unauthorisedRequest();
                  break;
                case 401:
                  networkExceptions =
                      const NetworkExceptions.unauthorisedRequest();
                  break;
                case 403:
                  networkExceptions =
                      const NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions =
                      const NetworkExceptions.notFound("Not found");
                  break;
                case 409:
                  networkExceptions = const NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = const NetworkExceptions.requestTimeout();
                  break;
                case 500:
                  networkExceptions =
                      const NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions =
                      const NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        // Helper.printError(e.toString());
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "not_implemented".tr;
    }, requestCancelled: () {
      errorMessage = "request_cancelled".tr;
    }, internalServerError: () {
      errorMessage = "internal_server_error".tr;
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "service_unavailable".tr;
    }, methodNotAllowed: () {
      errorMessage = "method_allowed".tr;
    }, badRequest: () {
      errorMessage = "bad_request".tr;
    }, unauthorisedRequest: () {
      errorMessage = "unauthorized_request".tr;
    }, unexpectedError: () {
      errorMessage = "unexpected_error_occurred".tr;
    }, requestTimeout: () {
      errorMessage = "connection_request_timeout".tr;
    }, noInternetConnection: () {
      errorMessage = "no_internet_connection".tr;
    }, conflict: () {
      errorMessage = "error_due_to_a_conflict".tr;
    }, sendTimeout: () {
      errorMessage = "send_timeout_in_connection_with_api_server".tr;
    }, unableToProcess: () {
      errorMessage = "unable_to_process_the_data".tr;
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "unexpected_error_occurred".tr;
    }, notAcceptable: () {
      errorMessage = "not_acceptable".tr;
    });
    return errorMessage;
  }
}
