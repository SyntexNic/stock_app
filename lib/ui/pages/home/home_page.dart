import 'package:flutter/material.dart';
import 'package:stock_app/ui/widgets/navbar/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
        appBar: AppBar(
          title: Text('holi'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text(
            'data',
            style: TextStyle(fontSize: 40.0),
          ),
        ));
  }
}
