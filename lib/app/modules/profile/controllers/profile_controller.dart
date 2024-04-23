import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/constans/endpoint.dart';
import '../../../data/models/response_profile.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController with StateMixin{

  var detailProfile = Rxn<DataProfile>();
  final loading = false.obs;
  final loadingLogout = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController namalengkapController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Update Profile
  Future<void> getDataUser() async {
    detailProfile.value = null;
    change(null, status: RxStatus.loading());

    try {
       final bearerToken = StorageProvider.read(StorageKey.bearerToken);
      final responseDetailBuku = await ApiProvider.instance().get(Endpoint.profil,options: Options(headers: {"Authorization": "Bearer $bearerToken"}));
      if (responseDetailBuku.statusCode == 200) {
        final ResponseProfile responseBuku = ResponseProfile.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          detailProfile(responseBuku.data);
          emailController.text = detailProfile.value!.email.toString();
          teleponController.text = detailProfile.value!.noTelp.toString();
          usernameController.text = detailProfile.value!.username.toString();
          namalengkapController.text = detailProfile.value!.namaLengkap.toString();
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  updateProfilePost() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
       final bearerToken = StorageProvider.read(StorageKey.bearerToken);
        var response = await ApiProvider.instance().put(Endpoint.updateProfile,
            data:
            {
              "Username" : usernameController.text.toString(),
              "NamaLengkap" : namalengkapController.text.toString(),
              "Email" : emailController.text.toString(),
              "NoTelepon" : teleponController.text.toString(),
            },options: Options(headers: {"Authorization": "Bearer $bearerToken"})
        );
        if (response.statusCode == 201) {
          final ResponseProfile responseBuku = ResponseProfile.fromJson(response.data);
          detailProfile(responseBuku.data);
          emailController.text = detailProfile.value!.email.toString();
          teleponController.text = detailProfile.value!.noTelp.toString();
          usernameController.text = detailProfile.value!.username.toString();
          namalengkapController.text = detailProfile.value!.namaLengkap.toString();
          change(null, status: RxStatus.success());
          await StorageProvider.write(StorageKey.status, "logged");
          await StorageProvider.write(StorageKey.username, detailProfile.value!.username.toString());
          await StorageProvider.write(StorageKey.idUser, detailProfile.value!.id.toString());
          String username = usernameController.text.toString();
          _showMyDialog(
                  (){
                getDataUser();
                Navigator.pop(Get.context!, 'OK');
              },
              "Update Profile Akun $username Berhasil",
              "Lanjut",
              QuickAlertType.success);
        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Update Profile Gagal",
              "Ok",
              QuickAlertType.error
          );
        }
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "${e.response?.data?['Message']}",
              "Oke",
              QuickAlertType.warning
          );
        }
      } else {
        _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          e.message ?? "",
            "Oke",
            QuickAlertType.error
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            (){
          Navigator.pop(Get.context!, 'OK');
        },
        e.toString(),
          "Oke",
          QuickAlertType.error
      );
    }
  }

  Future<void> kontenUpdateProfile() async{
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: GoogleFonts.abhayaLibre(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: const Color(0xFFC6D3E3),
          ),
          backgroundColor: const Color(0xFFC6D3E3),
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xFF00D193),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Form Update Profile',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.abhayaLibre(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Form(
                key: formKey,
                child: ListBody(
                  children: <Widget>[

                    const SizedBox(
                      height: 10,
                    ),

                    textFormField(
                        namalengkapController,
                        "Nama Lengkap",
                        "Masukan Nama Lengkap"
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    textFormField(
                        usernameController,
                        "Username",
                        "Masukan Username"
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    textFormField(
                        emailController,
                        "Email",
                        "Masukan Email"
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    textFormField(
                        teleponController,
                        "Telepon",
                        "Masukan Telepon"
                    ),

                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width,
                  height: 40,
                  child: TextButton(
                    autofocus: true,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF00D193),
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    onPressed: (){
                      updateProfilePost();
                      Navigator.of(Get.context!).pop();
                    },
                    child: Text(
                      'Simpan Ulasan Buku',
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  // End Update Profile

  // Logout
   logout() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      final bearerToken = StorageProvider.read(StorageKey.bearerToken);
      var response = await ApiProvider.instance().get(
          Endpoint.logout,options: Options(headers: {"Authorization": "Bearer $bearerToken"})
      );

      if (response.statusCode == 200) {
        
        StorageProvider.clearAll();
        Get.offAllNamed(Routes.LOGIN);
      } else {
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
        }
      } else {
      }
    } catch (e) {
      loading(false);
    }
  }

  Future<void> _showMyDialog(final onTap, String deskripsi, String nameButton, QuickAlertType type) async {
    return QuickAlert.show(
      context: Get.context!,
      type: type,
      text: deskripsi,
      confirmBtnText: nameButton,
      confirmBtnTextStyle: const TextStyle(color: Colors.black),
      confirmBtnColor: const Color(0xFFC6D3E3),
      onConfirmBtnTap: onTap,
      title: 'YULIAN PERPUSTAKAAN',
      animType: QuickAlertAnimType.scale,
      textColor: Colors.black,
      titleColor: Colors.black,
      barrierDismissible: true,
    );
  }

  // Widget TextFormField
  Widget textFormField(final TextEditingController controller, String hintText, String messageValidator) {
    const Color textColor = Color(0xFF000AFF);
    const Color backgroundInput = Color(0xFFEFEFEF);
    const Color colorBorder = Color(0xFFC6D3E3);

    return TextFormField(
      controller: controller,
      style: GoogleFonts.abhayaLibre(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
      maxLines: 1,
      decoration: InputDecoration(
          fillColor: backgroundInput,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textColor.withOpacity(0.90),
              ),
              borderRadius: BorderRadius.circular(100.100)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorBorder.withOpacity(0.90),
              ),
              borderRadius: BorderRadius.circular(100.100)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textColor.withOpacity(0.90),
              ),
              borderRadius: BorderRadius.circular(100.100)),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorBorder.withOpacity(0.90),
              ),
              borderRadius: BorderRadius.circular(100.100)),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          hintText: hintText,
          hintStyle: GoogleFonts.abhayaLibre(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          )
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return messageValidator;
        }
        return null;
      },
    );
  }
}
