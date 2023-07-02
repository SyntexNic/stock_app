import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/constants/Theme.dart';
import 'package:stock_app/ui/widgets/Products/ProductForm.dart';
import 'package:stock_app/ui/widgets/appBar/appbar.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
