import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yulian_perpustakaan/app/data/constans/constans.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.widthFullBody,
      required this.label,
      this.color,
      required this.width,
      required this.height,
      required this.onTap,
      this.controller = false});

  final double widthFullBody;
  final String label;
  final int? color;
  final double width;
  final double height;
  final Function()? onTap;
  final controller;

  @override
  Widget build(BuildContext context) {
    return controller == false
        ? ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.black, // Warna border
                  width: 2.0, // Ketebalan border
                ),
                backgroundColor: Color(color ?? buttonFillColor)),
            child: Container(
              alignment: Alignment.center,
              height: height,
              width: width,
              child: AutoSizeText(
                label,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: widthFullBody * 0.04,
                    fontFamily: GoogleFonts.inika().fontFamily,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Obx(() => ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black, // Warna border
                    width: 2.0, // Ketebalan border
                  ),
                  backgroundColor: Color(color ?? buttonFillColor)),
              child: Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                child: controller.loading.value
                    ? const CircularProgressIndicator()
                    : AutoSizeText(
                        label,
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: widthFullBody * 0.04,
                            fontFamily: GoogleFonts.inika().fontFamily,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
              ),
            ));
  }
}
