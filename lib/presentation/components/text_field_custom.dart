import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
 final String  labelText;
 final  textController;
 final dynamic validatorType;
 final dynamic iconType;
final bool obscureText;
 TextFieldCustom( this.labelText, this.textController, this.validatorType,this.iconType,this.obscureText);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      decoration:  InputDecoration(
        prefixIcon: iconType,
        labelText:  labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validatorType,
      //ValidationBuilder().maxLength(15).minLength(6).build(),
    );
  }
}
