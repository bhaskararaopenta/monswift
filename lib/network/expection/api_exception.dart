
import 'package:nationremit/network/constants/error_constants.dart';

class ApiException implements Exception {
  final String? message;
  final String? prefix;

  const ApiException({this.message, this.prefix});

  @override
  String toString() {
    return '$prefix$message';
  }

  String get errorMessage {
    if (message != null) {
      if (message!.contains(':')) {
        return message!.split(':').last.trim();
      }
      return message!;
    }
    return ErrorConstants.somethingWentWrong;
  }
}

class FetchDataException extends ApiException {
  const FetchDataException(String? message)
      : super(message: message, prefix: '');
}

class BadRequestException extends ApiException {
  const BadRequestException(String? message)
      : super(message: message, prefix: ErrorConstants.badRequest);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String? message)
      : super(message: message, prefix: ErrorConstants.unauthorized);
}

class ServerException extends ApiException {
  ServerException(String? message)
      : super(message: message, prefix: ErrorConstants.serverNotFound);
}

class AddLeadException extends ApiException {
  AddLeadException(int errorCode, String messageId)
      : super(message: messageId, prefix: errorCode.toString());
}

class NotFoundException extends ApiException {
  const NotFoundException(String? message)
      : super(message: message, prefix: ErrorConstants.notFound);
}
