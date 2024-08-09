class CounterUtil {
  CounterUtil() {}

  Future<String> incrementId(String stringId, int noOfId) async {
    // Extract the numeric part
    String numericPart = stringId.replaceAll(RegExp(r'[^\d]'), '');

    // Convert to an integer and increment
    int incrementedNumber = int.parse(numericPart) + noOfId;

    // Convert back to a string with leading zeros
    String incrementedString =
        incrementedNumber.toString().padLeft(numericPart.length, '0');

    // Concatenate the prefix with the incremented numeric string
    String newStringId =
        stringId.substring(0, stringId.length - numericPart.length) +
            incrementedString;

    return newStringId;
  }
}
