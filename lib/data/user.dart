class VoyageClient {
  late int id;
  String nom;
  String prenom;
  String sexe;
  String email;
  String contact;
  String whatsapp;
  String photo;

  VoyageClient({
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.email,
    required this.contact,
    required this.whatsapp,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      "nom": nom,
      "prenom": prenom,
      "sexe": sexe,
      "email": email,
      "contact": contact,
      "tel_whatsapp": whatsapp,
      "photo": photo,
    };
  }

  static VoyageClient fromMap(Map<String, dynamic> map) {
    return VoyageClient(
      nom: map["nom"],
      prenom: map["prenom"],
      sexe: map["sexe"],
      email: map["email"],
      contact: map["contact"],
      whatsapp: map["tel_whatsapp"],
      photo: map["photo"],
    );
  }
}
