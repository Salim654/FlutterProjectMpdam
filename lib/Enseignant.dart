class Enseignant {
  String nom;
  String email;

  Enseignant({required this.nom, required this.email});

  factory Enseignant.fromJson(Map<String, dynamic> json) {
    return Enseignant(
      nom: json['nom'],
      email: json['email'],
    );
  }
}

class Enseignants {
  List<Enseignant> enseignants;

  Enseignants({required this.enseignants});

  factory Enseignants.fromJson(Map<String, dynamic> json) {
    return Enseignants(
      enseignants: List<Enseignant>.from(
        json['enseignants'].map((enseignant) => Enseignant.fromJson(enseignant)),
      ),
    );
  }
}
