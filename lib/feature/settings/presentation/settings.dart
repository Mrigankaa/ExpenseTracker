import 'package:expencetracker/feature/settings/presentation/add_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        Container(
          child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 60.0,
                    color: Colors.pinkAccent,
                  ),
                ),
        ),
        SizedBox(height: 40,),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(title: Text("Category"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
          trailing: Icon(Icons.arrow_forward_ios,size: 10,
          ),
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategory()));},),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(title: Text("Privecy & Terms"),
          onTap: _showToaste,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
          trailing: Icon(Icons.arrow_forward_ios,size: 10,),),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(title: Text("Support"),
          onTap: _showToaste,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
          trailing: Icon(Icons.arrow_forward_ios,size: 10,),),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(title: Text("Contact us"),
          onTap: _showToaste,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
          trailing: Icon(Icons.arrow_forward_ios,size: 10,),),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(title: Text("Language"),
          onTap: _showToaste,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
          trailing: Icon(Icons.arrow_forward_ios,size: 10,),),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(title: Text("Report"),
          onTap: _showToaste,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
          trailing: Icon(Icons.arrow_forward_ios,size: 10,),),
        )
      ],
    );
  }

  void _showToaste(){
showToast("Not Implemented",
                context: context,
                position: StyledToastPosition.bottom,
                duration: Duration(seconds: 1)
              );

  }
}