class Team {
  String name;
  String nickname;

  String get logo => nickname.toLowerCase();

  Team(this.nickname, [this.name]);

  Team.fromJson(Map parsedJson) {
    Team(parsedJson['nombre']);
  }
}
