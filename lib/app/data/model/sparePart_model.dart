class SparPart {
  int? id;
  String? partNo;
  String? pices;
  String? rate;
  String? specification;
  String? beschreibung;
  String? artikelnummer;
  String? productId;
  String? productCode;
  String? katalogArtNummer;
  String? artikelname;
  String? artikelbild;
  String? excelFile;
  String? createdAt;
  String? updatedAt;
  double? discountPercentage;
  double? finalRate;

  SparPart({
    this.id,
    this.partNo,
    this.pices,
    this.rate,
    this.specification,
    this.beschreibung,
    this.artikelnummer,
    this.productId,
    this.productCode,
    this.katalogArtNummer,
    this.artikelname,
    this.artikelbild,
    this.excelFile,
    this.createdAt,
    this.updatedAt,
    this.discountPercentage,
    this.finalRate,
  });

  // Factory constructor to create an instance from JSON
  factory SparPart.fromJson(Map<String, dynamic> json) {
    return SparPart(
      id: json['id'] ?? 0,
      partNo: json['part_no'] ?? '',
      pices: json['pices'] ?? '',
      rate: json['rate'] ?? '',
      specification: json['specification'] ?? '',
      beschreibung: json['Beschreibung'] ?? '',
      artikelnummer: json['Artikelnummer'] ?? '',
      productId: json['product_id'] ?? '',
      productCode: json['product_code'] ?? '',
      katalogArtNummer: json['Katalog_Art_Nummer'] ?? '',
      artikelname: json['Artikelname'] ?? '',
      artikelbild: json['Artikelbild'] ?? '',
      excelFile: json['Excel_file'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      discountPercentage: double.tryParse(json['discount_percentage'] ?? '0') ?? 0.0,
      finalRate: json['final_rate']?.toDouble() ?? 0.0,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'part_no': partNo,
      'pices': pices,
      'rate': rate,
      'specification': specification,
      'Beschreibung': beschreibung,
      'Artikelnummer': artikelnummer,
      'product_id': productId,
      'product_code': productCode,
      'Katalog_Art_Nummer': katalogArtNummer,
      'Artikelname': artikelname,
      'Artikelbild': artikelbild,
      'Excel_file': excelFile,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'discount_percentage': discountPercentage.toString(),
      'final_rate': finalRate,
    };
  }
}