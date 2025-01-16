import 'package:flutter/material.dart';

class UserDataField extends StatelessWidget {
  final String label;
  final String value;

  const UserDataField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 265,
      height: 43,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 265,
              height: 43,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
            ),
          ),
          Positioned(
            left: 25,
            top: 12,
            child: SizedBox(
              width: 147,
              height: 22,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 15,
                  fontFamily: 'Abel',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 120,
            top: 12,
            child: SizedBox(
              width: 147,
              height: 22,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Abel',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
