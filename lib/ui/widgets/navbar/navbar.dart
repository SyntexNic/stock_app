import 'package:flutter/material.dart';
import 'package:stock_app/constants/Theme.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsApp.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
                accountName: const Text('nombre'),
                accountEmail: const Text('correo'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: ColorsApp.primary,
                  child: ClipOval(
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                decoration: BoxDecoration(color: ColorsApp.primary)),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.file_upload,
              color: ColorsApp.white,
            ),
            title: Text('prueba',
                style: TextStyle(
                  color: ColorsApp.white,
                )),
            onTap: () => print('Upload tapped'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_upload, color: ColorsApp.white),
            title: Text('prueba',
                style: TextStyle(
                  color: ColorsApp.white,
                )),
            onTap: () => print('Upload tapped'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.file_upload,
              color: ColorsApp.white,
            ),
            title: Text('prueba',
                style: TextStyle(
                  color: ColorsApp.white,
                )),
            onTap: () => print('Upload tapped'),
          ),
        ],
      ),
    );
  }
}
