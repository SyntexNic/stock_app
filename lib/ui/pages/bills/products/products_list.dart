import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/Response/Products/AccountProductsResponse.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/models/products.dart';
import 'package:stock_app/ui/widgets/Products/Product_list.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';
import 'package:http/http.dart' as http;

class Inventory extends StatefulWidget {
  final String accountId; // ID de la cuenta

  const Inventory({super.key, required this.accountId});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  bool isLoading = true;
  List<Result> products = [];
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url =
        'https://stockapi-vmuc.onrender.com/account/${widget.accountId}/products';
    final headers = {
      'Content-Type': 'application/json',
      'api-key': '\$yntexNicApiKey23',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonresponse = jsonDecode(response.body);
        final accountProductsResponse =
            AccountProductResponse.fromJson(jsonresponse);

        setState(() {
          products = accountProductsResponse.data?.result ?? [];
          isLoading = false;
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
        title: 'Inventario',
        backgroundColor: ColorsApp.primary,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorsApp.primary,
              ),
            )
          : products.isEmpty
              ? Center(
                  child: Text(
                    "No hay facturas disponibles",
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 24,
                      color: ColorsApp.primary,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: ColorsApp.primary),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorsApp.primary,
                            ),
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search,
                                color: ColorsApp.primary),
                            onPressed: () {},
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.clear,
                                color: ColorsApp.primary),
                          ),
                          hintText: 'Buscar',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, index) {
                          final product = products[index];

                          return Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListTile(
                                  leading: product.imagePath == null
                                      ? const Icon(
                                          Icons.circle_outlined,
                                          size: 35,
                                          color: ColorsApp.primary,
                                        )
                                      : product.imagePath != HttpStatus.accepted
                                          ? const Icon(
                                              Icons.circle_outlined,
                                              size: 35,
                                              color: ColorsApp.primary,
                                            )
                                          : Image.network(
                                              "${product.imagePath}"),
                                  title: Text(
                                    "${product.name}",
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: ColorsApp.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "stock: ${product.stock}",
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: ColorsApp.primary,
                                    ),
                                  ),
                                  trailing: Text(
                                    "${product.measure}${product.price}",
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: ColorsApp.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  dense: true,
                                  onTap: () {
                                    final data = {
                                      'nombre': product.name,
                                      'stock': product.stock,
                                      'price': product.price,
                                      'code': product.code,
                                      'desc': product.description,
                                      'id':product.id
                                      

                                      // otros datos...
                                    };
                                    Navigator.pop(context,data);
                                  },
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 80, right: 35),
                                child: const Divider(
                                  height: 1.5,
                                  color: ColorsApp.primary,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
            backgroundColor: ColorsApp.primary,
            child: const Icon(
              Icons.add,
              color: ColorsApp.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/AddProduct');
            }),
      ],
    );
  }
}

//Divider()
class Product {
  final String name;
  final String description;
  final int stock;
  final double price;
  final String measure;
  final String amount;

  Product({
    required this.name,
    required this.description,
    required this.stock,
    required this.price,
    required this.measure,
    required this.amount,
  });
}
