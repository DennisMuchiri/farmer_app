


Future<bool> common_wait_50ms() async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 50));
  return true;
}

bool isresponseSuccessfull(int statusCode) {
  bool isSuccessfull = false;
  if (statusCode >= 200 && statusCode < 300) {
    isSuccessfull = true;
  }
  return isSuccessfull;
}

