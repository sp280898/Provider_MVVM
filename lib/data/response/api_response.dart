import 'network_status.dart';

class ApiResponse<T> {
  NetworkStatus? status;
  T? data;
  String? message;
  ApiResponse({
    this.status,
    this.data,
    this.message,
  });

  ApiResponse.loading() : status = NetworkStatus.LOADING;
  ApiResponse.completed(this.data) : status = NetworkStatus.COMPLETED;
  ApiResponse.error(this.message) : status = NetworkStatus.ERROR;

  @override
  String toString() => 'status: $status,\n data: $data,\n message: $message';
}
