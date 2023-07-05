class InvoiceResponse {
  String? status;
  Data? data;

  InvoiceResponse({this.status, this.data});

  InvoiceResponse.fromJson(Map<String, dynamic> json) {
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
  String? no;
  String? date;
  List<InvoiceDetail>? invoiceDetail;
  int? total;
  int? iV;

  Result(
      {this.id,
      this.accountId,
      this.no,
      this.date,
      this.invoiceDetail,
      this.total,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    accountId = json['accountId'];
    no = json['no'];
    date = json['date'];
    if (json['invoiceDetail'] != null) {
      invoiceDetail = <InvoiceDetail>[];
      json['invoiceDetail'].forEach((v) {
        invoiceDetail!.add(new InvoiceDetail.fromJson(v));
      });
    }
    total = json['total'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['accountId'] = this.accountId;
    data['no'] = this.no;
    data['date'] = this.date;
    if (this.invoiceDetail != null) {
      data['invoiceDetail'] =
          this.invoiceDetail!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['__v'] = this.iV;
    return data;
  }
}

class InvoiceDetail {
  Product? product;
  int? quantity;
  int? subTotal;
  String? id;

  InvoiceDetail({this.product, this.quantity, this.subTotal, this.id});

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    subTotal = json['subTotal'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['subTotal'] = this.subTotal;
    data['_id'] = this.id;
    return data;
  }
}

class Product {
  String? name;
  String? price;

  Product({this.name, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
