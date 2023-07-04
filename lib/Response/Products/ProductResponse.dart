class ProductResponse {
  String? status;
  Data? data;

  ProductResponse({this.status, this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
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
  Result? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? id;
  String? accountId;
  String? code;
  String? name;
  String? description;
  int? stock;
  int? price;
  String? measure;
  String? image;
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
      this.image, // url de la imgen del producto
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
    image = json['image'];
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
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}
