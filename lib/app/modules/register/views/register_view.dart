import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yulian_perpustakaan/app/components/myButton.dart';
import 'package:yulian_perpustakaan/app/components/myInput.dart';
import 'package:yulian_perpustakaan/app/components/myJarak.dart';
import 'package:yulian_perpustakaan/app/data/constans/constans.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final widthFullBody = MediaQuery.of(context).size.width;
    final heightFullBody = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Container(
          width: widthFullBody,
          height: heightFullBody,
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const MyJarak(flex: 1),
                Expanded(flex: 5,child: Image.asset("assets/logo.png")),
                const MyJarak(flex: 2),
                Text(
                  "DAFTAR",
                  style: GoogleFonts.poppins(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const MyJarak(flex: 2),
                myInput(
                  validator: controller.validatorEmail,
                  controller: controller,
                  controllerField: controller.username,
                  height: 20,
                  width: 10,
                  hintText: "Username",
                  autoFocus: true,
                ),
                const MyJarak(flex: 1),
                myInput(
                  validator: controller.validator,
                  controller: controller,
                  controllerField: controller.email,
                  height: 20,
                  width: 10,
                  hintText: "Email",
                  autoFocus: false,
                ),
                const MyJarak(flex: 1),
                myInput(
                  validator: controller.validatorPassword,
                  controller: controller,
                  controllerField: controller.password,
                  height: 20,
                  width: 10,
                  hintText: "Password",
                  autoFocus: false,
                  isPassword: true,
                ),
                const MyJarak(flex: 1),
                myInput(
                  validator: ValidationBuilder()
                      .confirmPassword(controller.password)
                      .build(),
                  controller: controller,
                  controllerField: controller.confirmPassword,
                  height: 20,
                  width: 10,
                  hintText: "Confirm Password",
                  autoFocus: false,
                  isPassword: true,
                ),
                const MyJarak(flex: 1),
                Align(alignment: Alignment.centerRight,child: MyButton(widthFullBody: widthFullBody, label: "DAFTAR", width: widthFullBody * 0.3, height: 50, onTap: (){controller.postRegister();},color: 0xFFFFFFFF,)),
                const MyJarak(flex: 2),
              ],
            ),
          ),
        ),
      ),
    )));
  }
}
