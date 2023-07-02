class CreateAccountResponse {
  String? status;
  Data? data;

  CreateAccountResponse({this.status, this.data});

  CreateAccountResponse.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? pass;
  String? bussinessName;
  String? currency;
  int? iV;

  Result(
      {this.id,
      this.name,
      this.email,
      this.pass,
      this.bussinessName,
      this.currency,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    pass = json['pass'];
    bussinessName = json['bussinessName'];
    currency = json['currency'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['pass'] = this.pass;
    data['bussinessName'] = this.bussinessName;
    data['currency'] = this.currency;
    data['__v'] = this.iV;
    return data;
  }
}
