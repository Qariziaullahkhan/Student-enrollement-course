import 'package:flutter/material.dart';

class Costomtextfield extends StatelessWidget {
  final controller;
  final labeltext;
  final hinttext;
  final icon;

  final obscuretext;
  final maximum;
  final phonelength;
  bool obsecuretext = false;
  final formvalues;
  final toggleIcon;
  Costomtextfield(
      {super.key,
      this.controller,
      this.labeltext,
      this.hinttext,
      this.icon,
      this.obscuretext,
      this.maximum,
      this.phonelength,
      this.toggleIcon,
      this.formvalues});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: TextFormField(
        validator: formvalues,
        maxLength: phonelength,
        obscureText: obsecuretext,
        controller: controller,
        keyboardType: maximum,
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          hintText: hinttext,
          labelText: labeltext,
          prefixIcon: Icon(
            icon,
            color: Colors.pinkAccent,
          ),
          suffixIcon: toggleIcon != null
              ? IconButton(
                  icon: Icon(
                    obsecuretext ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Toggle the password visibility

                    obsecuretext = !obscuretext;
                  },
                )
              : null,
        ),
      ),
    );
  }
}
    

    // suffix: IconButton(
    //     onPressed: () {
    //       isvisibile = !isvisibile;
    //     },
    //     icon: isvisibile
    //         ? icons(
    //             Icons.visibility,
    //             color: Colors.black,
    //           )
