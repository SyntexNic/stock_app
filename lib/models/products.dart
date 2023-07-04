class ProductsArguments {
  final String? accountId;
  final String? code; // codigo de barra
  final String? name;
  final String? description;
  final int? stock;
  final int? price;
  final String? measure; // unida de medida
  final String? imagePath; // url de la imagen del producto

  ProductsArguments(
      this.accountId,
      this.code,
      this.name,
      this.description,
      this.stock,
      this.price,
      this.measure,
      this.imagePath,
      );
}
