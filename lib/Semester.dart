class Semester {
  int numero;
  List<Module> modules;

  Semester({required this.numero, required this.modules});

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      numero: json['numero'],
      modules: List<Module>.from(json['modules'].map((module) => Module.fromJson(module))),
    );
  }
}

class Module {
  String nom;
  List<Matiere> matieres;

  Module({required this.nom, required this.matieres});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      nom: json['nom'],
      matieres: List<Matiere>.from(json['matieres'].map((matiere) => Matiere.fromJson(matiere))),
    );
  }
}

class Matiere {
  String nom;
  int coefficient;
  int credit;

  Matiere({required this.nom, required this.coefficient, required this.credit});

  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      nom: json['nom'],
      coefficient: json['coefficient'],
      credit: json['credit'],
    );
  }
}
