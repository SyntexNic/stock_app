import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/pages/inventory/inventory_page.dart';
import 'package:stock_app/ui/widgets/Products/ProductForm.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late String id;
  late String AccountId;
  bool isLoading = true;

  Future<void> putProduct() async {
    var url = 'https://stockapi-vmuc.onrender.com/product';
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };
    // int stock1 = int.parse(stock);
    // double price1 = double.parse(price);
    // var datapost = {
    //   "accountId": accountId,
    //   "name": name,
    //   "code": code,
    //   "description": description,
    //   "stock": stock1,
    //   "price": price1,
    //   "measure": measure,
    //   "image": base64String
    // };

    // var jsonString = jsonEncode(datapost);
    // print(jsonString);
    // print(code);
    // print(name);
    // print(description);
    // print(stock);
    // print(base64String);
    // print(price);
    // print(measure);
    // print(accountId);

    try {
      var response =
          await http.put(Uri.parse(url), body: "jsonString", headers: headers);
      if (response.statusCode == 200) {
        //final jsonresponse = jsonDecode(response.body);
        setState(() {
          print('Request gg with status: ${response.statusCode}');
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Editar',
        backgroundColor: ColorsApp.primary,
      ),
      body: ProductForm(),
    );
  }
}
