import 'package:flutter/material.dart';

class Invoice {
  final String accountid;
  final DateTime date;
  final List<InvoiceDetail> details;
  final double total;

  Invoice({
    required this.accountid,
    required this.date,
    required this.details,
    required this.total,
  });
}

class InvoiceDetail {
  final Product product;
  final int quantity;
  final int subtotal;

  InvoiceDetail({
    required this.product,
    required this.quantity,
    required this.subtotal,
  });
}

class Product {
  final String productId;
  final String name;
  final double price;

  Product({
    required this.productId,
    required this.name,
    required this.price,
  });
}