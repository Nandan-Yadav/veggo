import 'package:flutter/material.dart';

class SnackbarService {
  late final BuildContext _context;

  SnackbarService(this._context);

  Future<void> showSnackBarWithIconMessage({required IconData icon, String title = ""}) async {
    ScaffoldMessenger.of(_context).showSnackBar(
       SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white,),
            )),
        backgroundColor: const Color(0xFFF35148)
      ),
    );
  }
}
