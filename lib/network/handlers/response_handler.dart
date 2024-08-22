import 'package:dio/dio.dart';
import 'package:nationremit/network/constants/error_constants.dart';
import 'package:nationremit/network/expection/api_exception.dart';

dynamic responseHandler(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
    case 204:
      return response.data;
      case 419:
      return response.data;
    case 400:
    case 422:
    return response.data;
    case 401:
      return response.data;
    case 403:
      throw UnauthorizedException(
        response.data?['error']?['message'] ?? response.data?['data'],
      );
    case 404:
      throw NotFoundException(
        response.data?['error']?['message'] ?? response.data?['data'],
      );
    case 409:
      throw AddLeadException(
        response.data?['error_code'] ?? '',
        response.data?['message_id'] ?? '',
      );
    case 500:
      throw ServerException(
        response.data?['error']?['message']?? response.data?['data'],
      );
    default:
      throw FetchDataException(
        '${ErrorConstants.defaultMessage} ${response.statusCode}',
      );
  }
}
