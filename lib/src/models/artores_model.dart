class Cast {
  List<Actor> actores = [];

  Cast();

  Cast.formJsonMap(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = new Actor.formJsonMap(element);
      actores.add(actor);
    });
  }
}

class Actor {
  bool adult = true;
  int gender = 0;
  int id = 0;
  String knownForDepartment = "";
  String name = "";
  String originalName = "";
  double popularity = 0.0;
  String profilePath = "";
  int castId = 0;
  String character = "";
  String creditId = "";
  int order = 0;
  String department = "";
  String job = "";

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  Actor.formJsonMap(Map<String, dynamic> json) {
    adult = json["adult"];
    gender = json["gender"];
    id = json["id"];
    knownForDepartment = json["known_for_department"];
    name = json["name"];
    originalName = json["original_name"];
    popularity = json["popularity"];
    profilePath = json["profile_path"];
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    order = json["order"];
    department = json["department"];
    job = json["job"];
  }

  getFoto() {
    if (profilePath == null) {
      return "https://img.icons8.com/ultraviolet/452/user-male-3.png";
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
