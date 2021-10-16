class ThemeQuiz {
  final String nom;
  final String url;

  ThemeQuiz({
    required this.nom,
    required this.url,
  });

  Map<String, dynamic> toJson() => _thematiqueToJson(this);

  String getUrl() {
    return url != "" ? url : "https://cdn3.trictrac.net/documents/formats/enlargement/documents/originals/6b/4c/b24a9d99bc500a729e1947ddcd3c2a82f1a44ff11a31b072dd5071618055.jpeg";
  }

  ThemeQuiz.fromJson(Map<String, dynamic> json)
      : this(
          nom: json["nom"] as String,
          url: json["url"] as String,
        );

  @override
  String toString() => "Thematique: $nom -> ($url)";

  Map<String, dynamic> _thematiqueToJson(ThemeQuiz instance) =>
      <String, dynamic>{
        'nom': instance.nom,
        'url': instance.url,
      };
}
