// import 'package:flutter/material.dart';
//
// class NumbersInRow extends StatelessWidget {
//   // List of numbers from 0 to 9
//   final List<int> numbers = List.generate(10, (index) => index);
//
//   // Example index connections: [target index each number will connect to]
//   final List<int> indexConnections = [5, 7, 3, 8, 4, 6, 2, 1, 9, 0];
//
//   NumbersInRow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Numbers with Connections'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: CustomPaint(
//           painter: LinePainter(numbers, indexConnections),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: numbers
//                 .map(
//                   (number) => CircleAvatar(
//                 radius: 20,
//                 child: Text(
//                   number.toString(),
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             )
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LinePainter extends CustomPainter {
//   final List<int> numbers;
//   final List<int> indexConnections;
//
//   LinePainter(this.numbers, this.indexConnections);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint linePaint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 2.0;
//
//     // Calculate spacing between numbers
//     final double circleSpacing = size.width / (numbers.length + 1);
//     final double rowY = size.height / 2; // Y-coordinate for the row
//
//     // Loop through the list and draw lines between connected indices
//     for (int i = 0; i < numbers.length; i++) {
//       final int targetIndex = indexConnections[i];
//
//       // Ensure the target index is within bounds
//       if (targetIndex >= 0 && targetIndex < numbers.length) {
//         final double startX = (i + 1) * circleSpacing; // X-position of the current number
//         final double endX = (targetIndex + 1) * circleSpacing; // X-position of the target number
//
//         // Draw a line connecting the current number to the target number
//         canvas.drawLine(Offset(startX, rowY), Offset(endX, rowY), linePaint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
