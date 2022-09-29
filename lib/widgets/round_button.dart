
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTapp;
  final bool loading ;
  const RoundButton({Key? key,
    required this.title,
    required this.onTapp,
    this.loading = false,
    //required bool loading,
  }) : super(key: key);

//   RoundButton({
//     required this.title,
// })

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTapp,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,):
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        )

    );
  }
}
