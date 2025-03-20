import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';

class WinPopUpPage extends StatelessWidget {
  final String winNumber;
  final dynamic winAmount;
  final int gameSrNo;

  const WinPopUpPage({
    super.key,
    required this.winNumber,
    required this.winAmount,
    required this.gameSrNo,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.yellowAccent.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        width: width * 0.9,
        height: height * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Trophy Icon
            const Icon(Icons.emoji_events, size: 50, color: Colors.amberAccent),
            SizedBox(height: height *0.02),

            Text(
              "Game No: $gameSrNo",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.white54, thickness: 1.2),

            const Text(
              "Winning Numbers",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              winNumber,
              style: const TextStyle(
                color: Colors.yellowAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height*0.03),

            const Text(
              "Win Amount",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              "₹$winAmount",
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height*0.02),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                elevation: 5,
              ),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
