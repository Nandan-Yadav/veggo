import 'package:flutter/material.dart';

class SnackbarService {
  late final BuildContext _context;

  SnackbarService(this._context);

  Future<void> showSnackBarWithIconMessage(
      {IconData? icon, String title = ""}) async {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.white,
          backgroundColor: const Color(0xFFF35148),
          content: Row(
            children: [
              Icon(icon,color: Colors.white,),
              const SizedBox(width: 10,),
              Expanded(child: Text(title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
            ],
          )),
    );
  }
}
