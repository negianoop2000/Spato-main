import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailData {
  bool? success;
  List<Product>? product;
  SparePart? sparePart;
  List<dynamic>? relatedProducts;
  List<dynamic>? featuredProducts;
  List<Review>? reviews;

  DetailData({
    this.success,
    this.product,
    this.sparePart,
    this.relatedProducts,
    this.featuredProducts,
    this.reviews,
  });

  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
      success: json['success'],
      product: json['product'] != null
          ? List<Product>.from(json['product'].map((x) => Product.fromJson(x)))
          : null,
      sparePart: json['sparePart'] != null
          ? SparePart.fromJson(json['sparePart'])
          : null,
      relatedProducts: json['related_Products'] != null
          ? List<dynamic>.from(json['related_Products'])
          : null,
      featuredProducts: json['featured_Products'] != null
          ? List<dynamic>.from(json['featured_Products'])
          : null,
      reviews: json['reviews'] != null
          ? List<Review>.from(json['reviews'].map((x) => Review.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'product': product != null
          ? List<dynamic>.from(product!.map((x) => x.toJson()))
          : null,
      'sparePart': sparePart?.toJson(),
      'related_Products': relatedProducts,
      'featured_Products': featuredProducts,
      'reviews': reviews != null
          ? List<dynamic>.from(reviews!.map((x) => x.toJson()))
          : null,
    };
  }
}

class Product {
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
  String? einkaufsPreisZzglMwSt;
  String? einkaufsRabatt;
  String? artikelname;
  String? beschreibungKurz;
  String? beschreibungLang;
  String? m3H;
  String? stichmass;
  String? kw;
  String? volt;
  String? kelvin;
  String? lm;
  String? druckstufePn;
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

  Product({
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
    this.einkaufsPreisZzglMwSt,
    this.einkaufsRabatt,
    this.artikelname,
    this.beschreibungKurz,
    this.beschreibungLang,
    this.m3H,
    this.stichmass,
    this.kw,
    this.volt,
    this.kelvin,
    this.lm,
    this.druckstufePn,
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
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
      einkaufsPreisZzglMwSt: json['Einkausfpreis_zzgl_MwSt'],
      einkaufsRabatt: json['Einkaufsrabatt'],
      artikelname: json['Artikelname'],
      beschreibungKurz: json['Beschreibung_kurz'],
      beschreibungLang: json['Beschreibung_lang'],
      m3H: json['m3_h'],
      stichmass: json['Stichmass'],
      kw: json['kW'],
      volt: json['Volt'],
      kelvin: json['Kelvin'],
      lm: json['lm'],
      druckstufePn: json['Druckstufe_PN'],
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
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
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
      'Einkausfpreis_zzgl_MwSt': einkaufsPreisZzglMwSt,
      'Einkaufsrabatt': einkaufsRabatt,
      'Artikelname': artikelname,
      'Beschreibung_kurz': beschreibungKurz,
      'Beschreibung_lang': beschreibungLang,
      'm3_h': m3H,
      'Stichmass': stichmass,
      'kW': kw,
      'Volt': volt,
      'Kelvin': kelvin,
      'lm': lm,
      'Druckstufe_PN': druckstufePn,
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
    };
  }
}

// class SparePart {
//   final String id;
//   final String partNo;
//   final int pieces;
//   final double rate;
//   final String specification;
//   final String description;
//   final String articleNumber;
//   final String productId;
//   final String catalogueArticleNumber;
//   final String articleName;
//   final String? articleImage;
//   final String? excelFile;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   SparePart({
//     required this.id,
//     required this.partNo,
//     required this.pieces,
//     required this.rate,
//     required this.specification,
//     required this.description,
//     required this.articleNumber,
//     required this.productId,
//     required this.catalogueArticleNumber,
//     required this.articleName,
//     this.articleImage,
//     this.excelFile,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   // Convert the SparePart instance to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'part_no': partNo,
//       'pieces': pieces,
//       'rate': rate,
//       'specification': specification,
//       'description': description,
//       'article_number': articleNumber,
//       'product_id': productId,
//       'catalogue_article_number': catalogueArticleNumber,
//       'article_name': articleName,
//       'article_image': articleImage,
//       'excel_file': excelFile,
//       'created_at': createdAt?.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }
//
//   // Factory constructor to create a SparePart from JSON
//   factory SparePart.fromJson(Map<String, dynamic> json) {
//     return SparePart(
//       id: json['id'] ?? '',
//       partNo: json['part_no'] ?? '',
//       pieces: json['pieces'] ?? 0,
//       rate: json['rate']?.toDouble() ?? 0.0,
//       specification: json['specification'] ?? '',
//       description: json['description'] ?? '',
//       articleNumber: json['article_number'] ?? '',
//       productId: json['product_id'] ?? '',
//       catalogueArticleNumber: json['catalogue_article_number'] ?? '',
//       articleName: json['article_name'] ?? '',
//       articleImage: json['article_image'],
//       excelFile: json['excel_file'],
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
//     );
//   }
// }



class SparePart {
  final int? id;
  final String? partNo;
  final String? pieces;
  final String? rate;
  final String? specification;
  final String? description;
  final String? articleNumber;
  final String? productId;
  final String? catalogueArticleNumber;
  final String? articleName;
  final String? articleImage;
  final String? excelFile;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SparePart({
    this.id,
    this.partNo,
     this.pieces,
    this.rate,
    this.specification,
    this.description,
    this.articleNumber,
    this.productId,
   this.catalogueArticleNumber,
    this.articleName,
    this.articleImage,
    this.excelFile,
    this.createdAt,
    this.updatedAt,
  });

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
      id: json['id'],
      partNo: json['part_no'],
      pieces: json['pices'],
      rate: json['rate'],
      specification: json['specification'],
      description: json['Beschreibung'],
      articleNumber: json['Artikelnummer'],
      productId: json['product_id'],
      catalogueArticleNumber: json['Katalog_Art_Nummer'],
      articleName: json['Artikelname'],
      articleImage: json['Artikelbild'],
      excelFile: json['Excel_file'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'part_no': partNo,
      'pices': pieces,
      'rate': rate,
      'specification': specification,
      'Beschreibung': description,
      'Artikelnummer': articleNumber,
      'product_id': productId,
      'Katalog_Art_Nummer': catalogueArticleNumber,
      'Artikelname': articleName,
      'Artikelbild': articleImage,
      'Excel_file': excelFile,
      'created_at':createdAt,
      'updated_at':updatedAt

    };
  }
}




class Review {
  String? sId;
  String? name;
  String? description;
  String? profileImage;
  String? rating;
  String? createdAt;
  int? iV;

  Review({
    this.sId,
    this.name,
    this.description,
    this.profileImage,
    this.rating,
    this.createdAt,
    this.iV,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      sId: json['_id'],
      name: json['name'],
      description: json['description'],
      profileImage: json['profileImage'],
      rating: json['rating'],
      createdAt: json['createdAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'description': description,
      'profileImage': profileImage,
      'rating': rating,
      'createdAt': createdAt,
      '__v': iV,
    };
  }
}
