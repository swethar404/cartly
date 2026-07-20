class SupplierModel {
  final int? supplierId;
  final String supplierName;
  final String supplierPhone;
  final String supplierEmail;

  const SupplierModel({
    this.supplierId,
    required this.supplierName,
    required this.supplierPhone,
    required this.supplierEmail,
  });

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      supplierId: map['supplier_id'],
      supplierName: map['supplier_name'],
      supplierPhone: map['supplier_phone'],
      supplierEmail: map['supplier_email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'supplier_phone': supplierPhone,
      'supplier_email': supplierEmail,
    };
  }

  SupplierModel copyWith({
    int? supplierId,
    String? supplierName,
    String? supplierPhone,
    String? supplierEmail,
  }) {
    return SupplierModel(
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      supplierPhone: supplierPhone ?? this.supplierPhone,
      supplierEmail: supplierEmail ?? this.supplierEmail,
    );
  }
}