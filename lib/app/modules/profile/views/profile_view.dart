import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color(0xFF00D193),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              await controller.getDataUser();
            },
            child: AutoSizeText(
              "Profile User",
              style: GoogleFonts.alegreya(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 20.0
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              // Tindakan yang diambil saat tombol di tekan
            },
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
                ],
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: const Color(0xFFC6D3E3),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: sectionDataUser(),
            ),

            sectionMenuProfile(),
          ],
        ),
      )
    );
  }

  Widget sectionDataUser(){

    return Obx((){
      var dataUser = controller.detailProfile.value;

      if(controller.detailProfile.value == null){
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF271C68)),
          ),
        );
      }else{

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.black,
                          width: 5, // Adjust the width of the stroke as needed
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/profil.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),


                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      dataUser!.namaLengkap.toString(),
                      style: GoogleFonts.alegreya(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: const Color(0xFF260534),
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      dataUser.email.toString(),
                      style: GoogleFonts.alegreya(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  Widget sectionMenuProfile(){

    const Color primary = Color(0xFFFFFFFF);
    const Color logoutButton = Color(0xFF00D193);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 55,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: primary
              ),
              onPressed: (){
                controller.kontenUpdateProfile();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Edit Data Profile",
                        maxFontSize: 14,
                        minFontSize: 10,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.alegreya(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                      AutoSizeText(
                        "Perbarui dan modifikasi profil",
                        maxFontSize: 14,
                        minFontSize: 10,
                        maxLines: 1,
                        style: GoogleFonts.abhayaLibre(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 14
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

         const SizedBox(
            height: 30,
          ),

          Center(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: logoutButton
                ),
                onPressed: (){
                  controller.logout();
                },
                child: Text(
                  "Keluar dari Akun",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.abhayaLibre(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
