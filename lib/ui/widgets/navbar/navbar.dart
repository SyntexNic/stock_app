import 'package:flutter/material.dart';
import 'package:stock_app/ui/pages/bills/bills_page.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('nombre'),
            accountEmail: const Text('correo'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('images/logo.png')),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('prueba'),
            onTap: () => print('Upload tapped'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Facturas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Bills()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('prueba'),
            onTap: () => print('Upload tapped'),
          ),
        ],
      ),
    );
  }
}
