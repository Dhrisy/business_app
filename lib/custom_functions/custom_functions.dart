class CustomFunctions{
  String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}


    bool search(String searchFor, String searchIn) {
    return searchIn.toLowerCase().contains(searchFor.toLowerCase());
  }
}