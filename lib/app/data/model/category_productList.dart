class ProductList {
  int? id;
  String? type;
  String? availStatus;
  String? hersteller;
  String? herstNr;
  String? liefArtNr;
  String? herstellerArtikelnummer;
  String? katalogArtNummer;
  String? kategorie1;
  String? kategorie2;
  String? kategorie3;
  String? kategorie4;
  String? kategorie5;
  String? veVpe;
  String? einheit;
  String? rabattcode1;
  String? rabattcode2;
  String? rabattcode3;
  String? preisZzglMwSt;
  String? preisInklMwSt;
  String? einkausfpreisZzglMwSt;
  String? einkaufsrabatt;
  String? artikelname;
  String? beschreibungKurz;
  String? beschreibungLang;
  String? m3H;
  String? stichmass;
  String? kW;
  String? volt;
  String? kelvin;
  String? lm;
  String? druckstufePN;
  String? material;
  String? kornung;
  String? durchmesser;
  String? radius;
  String? gewicht;
  String? lange;
  String? breite;
  String? hohe;
  String? bild1;
  String? bild2;
  String? bild3;
  String? bild4;
  String? anleitungPdf1;
  String? anleitungPdf2;
  String? anleitungPdf3;
  String? addedBy;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  int? averageRating;
  int? reviewCount;

  ProductList({
    this.id,
    this.type,
    this.availStatus,
    this.hersteller,
    this.herstNr,
    this.liefArtNr,
    this.herstellerArtikelnummer,
    this.katalogArtNummer,
    this.kategorie1,
    this.kategorie2,
    this.kategorie3,
    this.kategorie4,
    this.kategorie5,
    this.veVpe,
    this.einheit,
    this.rabattcode1,
    this.rabattcode2,
    this.rabattcode3,
    this.preisZzglMwSt,
    this.preisInklMwSt,
    this.einkausfpreisZzglMwSt,
    this.einkaufsrabatt,
    this.artikelname,
    this.beschreibungKurz,
    this.beschreibungLang,
    this.m3H,
    this.stichmass,
    this.kW,
    this.volt,
    this.kelvin,
    this.lm,
    this.druckstufePN,
    this.material,
    this.kornung,
    this.durchmesser,
    this.radius,
    this.gewicht,
    this.lange,
    this.breite,
    this.hohe,
    this.bild1,
    this.bild2,
    this.bild3,
    this.bild4,
    this.anleitungPdf1,
    this.anleitungPdf2,
    this.anleitungPdf3,
    this.addedBy,
    this.status,
    this.createdAt,
    this.updatedAt,
   this.imageUrl,
    this.averageRating,
    this.reviewCount
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      id: json['id'],
      type: json['type'],
      availStatus: json['avail_status'],
      hersteller: json['Hersteller'],
      herstNr: json['Herst_Nr'],
      liefArtNr: json['Lief_Art_Nr'],
      herstellerArtikelnummer: json['Hersteller_Artikelnummer'],
      katalogArtNummer: json['Katalog_Art_Nummer'],
      kategorie1: json['Kategorie_1'],
      kategorie2: json['Kategorie_2'],
      kategorie3: json['Kategorie_3'],
      kategorie4: json['Kategorie_4'],
      kategorie5: json['Kategorie_5'],
      veVpe: json['VE_VPE'],
      einheit: json['Einheit'],
      rabattcode1: json['Rabattcode_1'],
      rabattcode2: json['Rabattcode_2'],
      rabattcode3: json['Rabattcode_3'],
      preisZzglMwSt: json['Preis_zzgl_MwSt'],
      preisInklMwSt: json['Preis_inkl_MwSt'],
      einkausfpreisZzglMwSt: json['Einkausfpreis_zzgl_MwSt'],
      einkaufsrabatt: json['Einkaufsrabatt'],
      artikelname: json['Artikelname'],
      beschreibungKurz: json['Beschreibung_kurz'],
      beschreibungLang: json['Beschreibung_lang'],
      m3H: json['m3_h'],
      stichmass: json['Stichmass'],
      kW: json['kW'],
      volt: json['Volt'],
      kelvin: json['Kelvin'],
      lm: json['lm'],
      druckstufePN: json['Druckstufe_PN'],
      material: json['Material'],
      kornung: json['Körnung'],
      durchmesser: json['Durchmesser'],
      radius: json['Radius'],
      gewicht: json['Gewicht'],
      lange: json['Länge'],
      breite: json['Breite'],
      hohe: json['Höhe'],
      bild1: json['Bild_1'],
      bild2: json['Bild_2'],
      bild3: json['Bild_3'],
      bild4: json['Bild_4'],
      anleitungPdf1: json['Anleitung_PDF_1'],
      anleitungPdf2: json['Anleitung_PDF_2'],
      anleitungPdf3: json['Anleitung_PDF_3'],
      addedBy: json['addedBy'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      imageUrl: json['imageUrl'],
      averageRating: json['average_rating'],
     reviewCount: json['review_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'avail_status': availStatus,
      'Hersteller': hersteller,
      'Herst_Nr': herstNr,
      'Lief_Art_Nr': liefArtNr,
      'Hersteller_Artikelnummer': herstellerArtikelnummer,
      'Katalog_Art_Nummer': katalogArtNummer,
      'Kategorie_1': kategorie1,
      'Kategorie_2': kategorie2,
      'Kategorie_3': kategorie3,
      'Kategorie_4': kategorie4,
      'Kategorie_5': kategorie5,
      'VE_VPE': veVpe,
      'Einheit': einheit,
      'Rabattcode_1': rabattcode1,
      'Rabattcode_2': rabattcode2,
      'Rabattcode_3': rabattcode3,
      'Preis_zzgl_MwSt': preisZzglMwSt,
      'Preis_inkl_MwSt': preisInklMwSt,
      'Einkausfpreis_zzgl_MwSt': einkausfpreisZzglMwSt,
      'Einkaufsrabatt': einkaufsrabatt,
      'Artikelname': artikelname,
      'Beschreibung_kurz': beschreibungKurz,
      'Beschreibung_lang': beschreibungLang,
      'm3_h': m3H,
      'Stichmass': stichmass,
      'kW': kW,
      'Volt': volt,
      'Kelvin': kelvin,
      'lm': lm,
      'Druckstufe_PN': druckstufePN,
      'Material': material,
      'Körnung': kornung,
      'Durchmesser': durchmesser,
      'Radius': radius,
      'Gewicht': gewicht,
      'Länge': lange,
      'Breite': breite,
      'Höhe': hohe,
      'Bild_1': bild1,
      'Bild_2': bild2,
      'Bild_3': bild3,
      'Bild_4': bild4,
      'Anleitung_PDF_1': anleitungPdf1,
      'Anleitung_PDF_2': anleitungPdf2,
      'Anleitung_PDF_3': anleitungPdf3,
      'addedBy': addedBy,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'imageUrl': imageUrl,
      'average_rating': averageRating,
      'review_count': reviewCount,
    };
  }
}
