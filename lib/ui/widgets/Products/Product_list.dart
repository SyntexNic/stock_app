import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/Response/Products/AccountProductsResponse.dart';
import 'package:stock_app/ui/pages/inventory/inventory_page.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';

import '../../../constants/Theme.dart';
import 'package:http/http.dart' as http;

Widget inventoryWidget({required String accountId}) {
  final String AccountId; // ID de la cuenta
  AccountId = accountId;
  bool isLoading = true;
  List<Result> products = [];

  void fetchProducts() async {
    final url =
        'https://stockapi-vmuc.onrender.com/account/$AccountId/products';
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

        products = accountProductsResponse.data?.result ?? [];
        isLoading = false;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  return Scaffold(
    body: isLoading
        ? const Center(
            child: CircularProgressIndicator(),
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
                          icon:
                              const Icon(Icons.clear, color: ColorsApp.primary),
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
                                        : Image.network("${product.imagePath}"),
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
                                onTap: () => Navigator.pushNamed(
                                    context, '/DetailsProduct'),
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
    //floatingActionButton:
  );
}
