Map<String, dynamic> responseMessage(
    {required bool success, dynamic data, String? error}) {
  if (success) {
    return {'success': success, 'data': data};
  }
  return {'success': success, 'error': error};
}
