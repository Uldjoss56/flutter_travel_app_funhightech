class VoyageBus {
  late int id;
  String nomBus;
  String matricule;
  String nbrPlace;
  String? etat;
  int? idChauffeur;

  VoyageBus({
    required this.nomBus,
    required this.matricule,
    required this.nbrPlace,
    this.etat,
    this.idChauffeur,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomBus': nomBus,
      'matricule': matricule,
      'nbrPlace': nbrPlace,
      'etat': etat,
      'idChauffeur': idChauffeur,
    };
  }

  static VoyageBus fromMap(Map<String, dynamic> map) {
    return VoyageBus(
      nbrPlace: map['nbr_place'],
      matricule: map['matricule'],
      nomBus: map['nom_bus'],
    );
  }

}
