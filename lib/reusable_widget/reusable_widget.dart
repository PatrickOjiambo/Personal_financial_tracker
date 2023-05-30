import 'package:flutter/material.dart';

Image logoWidget(String imageName)
{
  return Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: 240,
      height: 240,
      color: Colors.white
  );
}
TextField reusableTextField(String text, IconData icon, bool isPasswordType,
  TextEditingController controller){
  return TextField (controller: controller,
  obscureText: isPasswordType,
  enableSuggestions: !isPasswordType,
  autocorrect: !isPasswordType,
  cursorColor: Colors.white,
  style: TextStyle(color: Colors.white.withOpacity(0.9)),
  decoration: InputDecoration(prefixIcon: Icon(icon, color:Colors.white70,),
  labelText: text,
  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
  filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  fillColor: Colors.white.withOpacity(0.3),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
  ),
  keyboardType: isPasswordType
      ? TextInputType.visiblePassword
      : TextInputType.emailAddress);
}

Container reusableButton(
  BuildContext context, bool isLogin, Function onTap)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
           onTap();
    },
  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states)
      {
      if (states.contains(MaterialState.pressed)) {
      return Colors.black26;
      }
      return Colors.white;
      }),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    child: Text(
  isLogin ? 'LOG IN' : 'SIGN UP',
  style: const TextStyle(
          color: Colors.black87, fontWeight:  FontWeight.bold, fontSize: 16),
    ),
  ),
  );
}

TextField reusableTextField1(String text, IconData icon, bool isPasswordType,
  TextEditingController controller){
  return TextField (controller: controller,
  obscureText: isPasswordType,
  enableSuggestions: !isPasswordType,
  autocorrect: !isPasswordType,
  cursorColor: Color.fromARGB(255, 24, 23, 23),
  style: TextStyle(color: Color.fromARGB(255, 31, 142, 194).withOpacity(0.9)),
  decoration: InputDecoration(prefixIcon: Icon(icon, color:Color.fromARGB(179, 31, 28, 28),),
  labelText: text,
  labelStyle: TextStyle(color: Color.fromARGB(255, 48, 174, 206).withOpacity(0.9)),
  filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  fillColor: Color.fromARGB(255, 32, 151, 180).withOpacity(0.3),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
  ),
  keyboardType: isPasswordType
      ? TextInputType.visiblePassword
      : TextInputType.emailAddress);
}

Container reusableButton1(
  BuildContext context, bool isLogin, Function onTap)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
           onTap();
    },
  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states)
      {
      if (states.contains(MaterialState.pressed)) {
      return Color.fromARGB(66, 20, 112, 173);
      }
      return Color.fromARGB(255, 47, 139, 192);
      }),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    child: Text(
  isLogin ? 'LOG IN' : 'SUBMIT',
  style: const TextStyle(
          color: Color.fromARGB(221, 19, 18, 18), fontWeight:  FontWeight.bold, fontSize: 16),
    ),
  ),
  );
}