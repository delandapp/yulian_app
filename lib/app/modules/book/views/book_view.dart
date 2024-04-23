import 'package:yulian_perpustakaan/app/components/bookSearch.dart';
import 'package:yulian_perpustakaan/app/components/buildSection.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yulian_perpustakaan/app/components/searchInput.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final heightFullBody =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final widthFullBody = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("BUKU"),
        backgroundColor: const Color(0XFF58CBA2),
      ),
      body: controller.obx(
        (state) => Container(
          color: const Color(0xFF00D193),
          width: widthFullBody,
          height: heightFullBody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyInputSearch(
                  prefixIcon: Icons.search,
                  validator: controller.validator,
                  controller: controller,
                  controllerField: controller.search,
                  height: 20,
                  width: 10,
                  hintText: "Search Your Favorit Book",
                  autoFocus: false,
                ),
              ),
              Obx(
                () => Expanded(
                  child: controller.searchLenght.value == 1
                      ? controller.loading.value == false ? controller.listDataBuku.isEmpty ? const Center(child: Text("Tidak Ada Buku")) : BookSearch(data: controller.listDataBuku) : const Center(child: CircularProgressIndicator())
                      : buildSection(data: state!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
