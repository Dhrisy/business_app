import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({ Key? key,
  this.screenHeading,
  required this.isBusinessProfile,
   }) : super(key: key);

  final String? screenHeading;
  final bool isBusinessProfile;

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {

  final confidentialForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.screenHeading.toString()),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.red,
                  child: Form(
                    key: confidentialForm,
                    child: const Column(
                      children: [
                        Text("Confidential Information"),
                      ],
                    )),
                )


              ],
            ),
          ),
        ),
        
      ),
    );
  }
}