class VoyageColis {
  late int id;
  String idClient;
  String nomColis;
  int? statutReception;
  int? statutLivraison;
  int? statutVoyage;
  String numeroDestinataire;
  String lieuReception;
  String lieuDepart;
  String nomDestinataire;
  String dateSave;

  VoyageColis({
    required this.idClient,
    required this.nomColis,
    this.statutLivraison,
    this.statutVoyage,
    this.statutReception,
    required this.lieuReception,
    required this.lieuDepart,
    required this.nomDestinataire,
    required this.numeroDestinataire,
    required this.dateSave,
  });
}
