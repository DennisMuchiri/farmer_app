

bool isStringValid(String? str) {
  bool isvalid = true;
  if (str == null || !(str.trim().length > 0)) {
    isvalid = false;
  }
  return isvalid;
}