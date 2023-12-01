class VoyageProgramme {
  late int id;
  String codePrograme;
  String idBus;
  String lieuDepart;
  String lieuArrivee;
  String heureDepart;
  String heureArrivee;
  String distance;
  String prix;
  String notification;
  String statut;
  String nbrPlaceTotal;
  String totalReservation;

  VoyageProgramme({
    required this.codePrograme,
    required this.idBus,
    required this.lieuDepart,
    required this.lieuArrivee,
    required this.heureDepart,
    required this.heureArrivee,
    required this.distance,
    required this.prix,
    required this.notification,
    required this.statut,
    required this.nbrPlaceTotal,
    required this.totalReservation,
  });

  Map<String, dynamic> toMap() {
    return {
      'code_Programme': codePrograme,
      'idBus': idBus,
      'lieuDepart': lieuDepart,
      'lieuArrivee': lieuArrivee,
      'heureDepart': heureDepart,
      'heureArrivee': heureArrivee,
      'distance': distance,
      'prix': prix,
      'notification': notification,
      'statut': statut,
      'total_places_reserves': totalReservation,
    };
  }

  static VoyageProgramme fromMap(Map<String, dynamic> map) {
    return VoyageProgramme(
      codePrograme: map['code_programme'],
      idBus: map['id_bus'],
      lieuDepart: map['lieu_depart'],
      lieuArrivee: map['lieu_arrivee'],
      heureDepart: map['heure_depart'],
      heureArrivee: map['heure_arrivee'],
      distance: map['distance'],
      prix: map['prix'],
      notification: map['notification'],
      statut: map['statut'],
      nbrPlaceTotal: map['nbr_place_total'].toString(),
      totalReservation: map['total_places_reserves'].toString(),
    );
  }
}
