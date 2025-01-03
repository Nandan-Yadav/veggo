import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget> actions,
  String soursePath = 'assets/illustrations/location.svg',
}) async {
  //final dialogWidth = MediaQuery.sizeOf(context).width;
  final dialogHight = MediaQuery.sizeOf(context).height;
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 24,
        shadowColor: Colors.grey,
        backgroundColor: const Color(0xFFC5DDC4),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    Colors.white.withOpacity(0.2),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: dialogHight * 0.2,
                    child: SvgPicture.asset(soursePath),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: actions,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      );
    },
  );
}
