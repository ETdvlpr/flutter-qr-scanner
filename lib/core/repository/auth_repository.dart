import 'package:scanner/core/adapters/repository_adapter.dart';
import 'package:scanner/core/services/api/api_client.dart';

/*
  Implementation for Auth api requests
*/
class AuthRepository implements IAuthRepository {
  final ApiClient apiClient;
  AuthRepository({required this.apiClient});
  // Todo: Add auth api requests here.
}
