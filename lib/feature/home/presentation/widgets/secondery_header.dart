import 'package:flutter/material.dart';

class SeconderyCard extends StatelessWidget {
  final String amount;
  final String text;
  final Color color;
  final Icon icon;
  const SeconderyCard({
    required this.amount,
    required this.text,
    required this.color,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: color,
      ),
      height: MediaQuery.of(context).size.height*0.2,
      width: MediaQuery.of(context).size.width*0.4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),color: Color(0xFF23AF7C),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(text,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
            Text("${amount}₹",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600))
    
            ],
          ),
        ],
        ),
      ),);
  }
}