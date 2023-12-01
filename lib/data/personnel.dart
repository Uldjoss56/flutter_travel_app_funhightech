class VoyagePersonnel {
  late int id;
  String nom;
  String prenom;
  String matricule;
  int idPost;
  int idAgence;
  String email;
  String contact;
  String residence;
  int salaire;
  String cv;
  String dateSave;

  VoyagePersonnel({
    required this.nom,
    required this.prenom,
    required this.matricule,
    required this.idPost,
    required this.idAgence,
    required this.email,
    required this.contact,
    required this.residence,
    required this.salaire,
    required this.cv,
    required this.dateSave,
  });
}
