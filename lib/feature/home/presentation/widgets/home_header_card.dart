import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final double balance;
  const HeaderCard({
    super.key,
    required this.balance
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width:  MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD1C4E9), Color(0xFFF8BBD0)], // You can choose any colors you prefer
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10), // Optional: adds rounded corners to the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                  "Available Balance",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${balance.toStringAsFixed(2)}₹",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),                        
          ],
        ),
      ),
    );
  }
}