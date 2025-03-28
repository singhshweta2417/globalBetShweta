import 'dart:convert';
import 'package:game_on/main.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/components/text_field.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class UsernameChange extends StatefulWidget {
  final String name;
  const UsernameChange({super.key, required this.name});

  @override
  State<UsernameChange> createState() => _UsernameChangeState();
}

class _UsernameChangeState extends State<UsernameChange> {

  @override
  void initState() {
    nameUpdateView();
    // TODO: implement initState
    super.initState();
  }


  nameUpdateView(){
    changename.text = widget.name.toString()=="null"?"":widget.name.toString().toString();
  }

  TextEditingController changename = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 270,
        width: width,
        child: Column(
          children: [
            SizedBox(height: height / 30),
            Text(" Change Nickname",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold)),
        SizedBox(height: height*0.01,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: changename,
            maxLines: 1,
            hintText: widget.name.toString(),
          ),
        ),

            SizedBox(height: height / 30),
            InkWell(
              onTap: (){
                profileUpdate(changename.text,context);

              },
              child: Container(
                height: height*0.06,
                width: width*0.28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red)
                ),
                child: Center(
                  child: textWidget(
                      text: "Confirm",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.red
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  UserViewModel userProvider = UserViewModel();

  profileUpdate(String changeusername,context) async {
    if (kDebugMode) {
      print("guycyg");
    }
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(token);
      print(changeusername);
    }
    final response = await http.post(Uri.parse(ApiUrl.profileUpdate),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic >{
          "userid":token,
          "username": changeusername,
        })
    );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
        print("👍👍👍👍update");
      }
      if(data["status"]=="200"){
        // getprofile();
        Navigator.pop(context);
        Navigator.pop(context);
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);

      }
      else {
        Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
      }
    }
    else{
      throw Exception("error");
    }

  }

}
