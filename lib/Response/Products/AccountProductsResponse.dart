class AccountProductResponse {
  String? status;
  Data? data;

  AccountProductResponse({this.status, this.data});

  AccountProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Result>? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? accountId;
  String? code; // codigo de barra
  String? name;
  String? description;
  int? stock;
  int? price;
  String? measure; // unida de medida
  String? imagePath; // url de la imagen del producto
  int? iV;

  Result(
      {this.id,
      this.accountId,
      this.code,
      this.name,
      this.description,
      this.stock,
      this.price,
      this.measure,
      this.imagePath,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    accountId = json['accountId'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    stock = json['stock'];
    price = json['price'];
    measure = json['measure'];
    imagePath = json['imagePath'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['accountId'] = this.accountId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['measure'] = this.measure;
    data['imagePath'] = this.imagePath;
    data['__v'] = this.iV;
    return data;
  }
}
