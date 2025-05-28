import 'package:flutter/material.dart';

commonTxtField(
    {required String labelText,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyboardType,
    IconData? suffixIcon,
    void Function()? onPressed,
    bool isObscure = false,
    required String? Function(String?) validator

// suffixIcon? widget,
    }) {
  return TextFormField(
    cursorColor: Colors.black,
    textInputAction: TextInputAction.next,
    keyboardType: keyboardType,
    controller: controller,
    obscureText: isObscure,
    validator: validator,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(
          suffixIcon,
          color: Colors.black,
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2,
          color: Colors.black,
        ), // default border
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: 2, color: Colors.black), // border on focus
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: 2, color: Colors.red), // border on focus
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
  );
}

btn({
  required BuildContext context,
  required String text,
  required Function() onPressed,
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: Colors.black,
    minWidth: double.infinity,
    height: 40,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}

divider() {
  return const Divider(
    thickness: 1,
    color: Colors.black,
  );
}

disposeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}
