// Require at least 8 characters, one uppercase, one digit, and one special char
const passwordPattern = r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$';
const emailPattern = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]";
// const phoneRegx = "([0-9]{6})";
final RegExp phoneRegx = RegExp(r'^\d{7,14}$');
final RegExp gnPhoneRegx = RegExp(r'^6\d{8}$');

// const String amountRegex = "[0-9.,]";
const String amountRegex = "[0-9]+[,.]{0,1}[0-9]*";
// const String amountRegex = "[0-9]+([,.][0-9]{1,2})?";
// RegExp specialCharRegex = RegExp(r'^[a-zA-Z0-9\s]+$'); //special char
// RegExp specialCharWithSpaceRegex = RegExp(r'[^\w]'); //special char
var specialCharRegex = RegExp(r'^[a-zA-Z0-9À-ž\s]+$');
var specialCharWithoutSpaceRegex = RegExp(r'^[a-zA-Z0-9À-ž]+$');
// RegExp specialCharRegex =
//     RegExp(r'[^\w\s]'); //allow only alphanumeric and space
// RegExp specialCharRegex = RegExp(
//     r'^[\p{L}\s]+$'); //allow only alphanumeric and space and accent characters
RegExp specialCharAndSpaceRegex =
    RegExp(r'[^\d]'); //special char, space, alphabets

RegExp removeAllExceptLast4Regex = RegExp("\\w(?=\\w{4})");

bool validatePhone(String value) {
  return phoneRegx.hasMatch(value);
}

bool validatePassword(String value) {
  RegExp regxPassword = RegExp(passwordPattern);
  return regxPassword.hasMatch(value);
}

bool validateEmail(String value) {
  RegExp regxPassword = RegExp(emailPattern);
  return regxPassword.hasMatch(value);
}
