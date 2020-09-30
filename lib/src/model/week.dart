class Week {
  String description;

  Week(this.description);

  Week.fromJson(parsedJson) {
    description = parsedJson['description'];
  }
}
