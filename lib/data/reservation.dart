class VoyageReservation {
  String? codeReservation;
  String? codeProgramme;
  String? idClient;
  String? heureDepart;
  String? heureArrivee;
  String? lieuDepart;
  String? lieuArrivee;
  String? dateVoyage;
  String? idBus;
  String? nbrPlace;
  String? statutBagage;
  String? prix;
  String? confirmationVoyage;
  String? numeroPaiement;
  String? moyenPaiement;
  String? dateSave;

  VoyageReservation({
    this.codeReservation,
    this.codeProgramme,
    this.idClient,
    this.heureDepart,
    this.heureArrivee,
    this.lieuDepart,
    this.lieuArrivee,
    this.dateVoyage,
    this.idBus,
    this.nbrPlace,
    this.statutBagage,
    this.prix,
    this.confirmationVoyage,
    this.numeroPaiement,
    this.moyenPaiement,
    this.dateSave,
  });

  factory VoyageReservation.fromMap(Map<String, dynamic> map) =>
      VoyageReservation(
        codeReservation: map["code_reservation"],
        codeProgramme: map["code_programme"],
        idClient: map["id_client"],
        heureDepart: map["heure_depart"],
        heureArrivee: map["heure_arrivee"],
        lieuDepart: map["lieu_depart"],
        lieuArrivee: map["lieu_arrivee"],
        dateVoyage: map["date_voyage"],
        idBus: map["id_bus"],
        nbrPlace: map["nbr_place"],
        statutBagage: map["statut_bagage"],
        prix: map["prix"],
        confirmationVoyage: map["confirmation_voyage"],
        numeroPaiement: map["numero_paiement"],
        moyenPaiement: map["moyen_paiement"],
        dateSave: map["dateSave"],
      );

  Map<String, dynamic> toMap() => {
        "code_reservation": codeReservation,
        "code_programme": codeProgramme,
        "id_client": idClient,
        "heure_depart": heureDepart,
        "heure_arrivee": heureArrivee,
        "lieu_depart": lieuDepart,
        "lieu_arrivee": lieuArrivee,
        "date_voyage": dateVoyage,
        "id_bus": idBus,
        "nbr_place": nbrPlace,
        "statut_bagage": statutBagage,
        "prix": prix,
        "confirmation_voyage": confirmationVoyage,
        "numero_paiement": numeroPaiement,
        "moyen_paiement": moyenPaiement,
        "dateSave": dateSave,
      };
}
