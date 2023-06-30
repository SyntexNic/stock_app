import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});
  @override
  State<Inventory> createState() => _InventoryState();
}

final List<Product> products = [
  Product(
      name: 'Coquita',
      description: "coquita",
      amount: "USD",
      price: 20.00,
      stock: 1,
      measure: "2"),
  Product(
      name: 'Joya',
      description: "uwu",
      amount: "USD",
      price: 10.00,
      stock: 1,
      measure: "2"),
  Product(
      name: 'Joya',
      description: "uwu",
      amount: "USD",
      price: 10.00,
      stock: 1,
      measure: "2"),
  Product(
      name: 'Joya',
      description: "uwu",
      amount: "USD",
      price: 10.00,
      stock: 1,
      measure: "2"),
  Product(
      name: 'Joya',
      description: "uwu",
      amount: "USD",
      price: 10.00,
      stock: 1,
      measure: "2"),
  Product(
      name: 'Joya',
      description: "uwu",
      amount: "USD",
      price: 10.00,
      stock: 1,
      measure: "2"),
  Product(
      name: 'Joya',
      description: "uwu",
      amount: "USD",
      price: 10.00,
      stock: 1,
      measure: "2"),
  Product(
      name: 'Joya',
      description: "uwu",
      amount: "USD",
      price: 10.00,
      stock: 1,
      measure: "2"),

  // Agrega más facturas según tus necesidades
];

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.primary,
        title: Container(
            margin: const EdgeInsets.only(left: 70),
            child: Text(
              'Inventario',
              style: GoogleFonts.getFont(
                'Lato',
              ),
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: ColorsApp.primary),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsApp
                        .primary, // Color del borde cuando está en foco
                  ),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: ColorsApp.primary),
                  onPressed: () {},
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.clear, color: ColorsApp.primary),
                ),
                hintText: 'Buscar',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListTile(
                        leading: const Icon(
                          Icons.circle_outlined,
                          size: 35,
                          color: ColorsApp.primary,
                        ),
                        title: Text(products[index].name,
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: ColorsApp.primary,
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Text("stock:${products[index].stock}",
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: ColorsApp.primary,
                            )),
                        trailing: Text("C\$ ${products[index].price}",
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: ColorsApp.primary,
                              fontWeight: FontWeight.bold,
                            )),
                        dense: true,
                        onTap: () =>
                            Navigator.pushNamed(context, '/DetailsProduct'),
                      ),
                    ),
                    Container(
                      //height: 1.5,
                      padding: const EdgeInsets.only(left: 80, right: 35),
                      child: const Divider(
                        height: 1.5, // Ajusta el grosor del Divider
                        color: ColorsApp.primary, // Ajusta el color del Divider
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buttons(),
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
