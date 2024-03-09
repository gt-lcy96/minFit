String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input.substring(0, 1).toUpperCase() + input.substring(1);
}