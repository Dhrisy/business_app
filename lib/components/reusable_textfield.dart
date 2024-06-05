import 'package:business_app/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReusableTextfield extends StatefulWidget {
   ReusableTextfield({Key? key, 
   required this.controller,
   this.hintText,
   this.validation,
   this.keyBoard,
   this.suffixIcon,
   this.prefixIcon,
   this.suffixIconAction,
   this.obscureText,
   this.readOnly,
   this.password
   
   })
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validation;
  final TextInputType? keyBoard;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? suffixIconAction;
  final bool? obscureText;
  final bool? readOnly;
  final bool? password;

  @override
  _ReusableTextfieldState createState() => _ReusableTextfieldState();
}

class _ReusableTextfieldState extends State<ReusableTextfield> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: widget.controller,
      validator: widget.validation,
    keyboardType: widget.keyBoard,
    readOnly: widget.readOnly ?? false,
    maxLines: widget.password == true ? 1 : null,
    // contentInsertionConfiguration: true,
    obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon != null
        ? IconButton(
            icon: Icon(widget.suffixIcon),
            onPressed:  widget.suffixIconAction,
          )
        : null,
        prefixIcon: widget.prefixIcon != null
        ? Icon(widget.prefixIcon) 
        : null,
        // prefixIcon: Icon(widget.prefixIcon),
        prefixIconColor: const Color.fromARGB(255, 195, 191, 191),
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.transparent,
      
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 195, 191, 191)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 201, 200, 200),)
        ),
          focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 201, 200, 200)
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 227, 44, 31))
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 227, 44, 31))
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 201, 200, 200)
        ),
      ),
    
    
      ),
    
      
    );
  }
}
