import 'package:yulian_perpustakaan/app/data/models/response_ulasan.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yulian_perpustakaan/app/data/models/response_detailsbook.dart';

class MyBookDetails extends StatelessWidget {
  const MyBookDetails(
      {super.key, required this.dataBookDetails, required this.dataUlasan, required this.controller});
  final DataBookDetails dataBookDetails;
  final controller;
  final List<DataUlasan>? dataUlasan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              height: 190,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(dataBookDetails.coverBuku.toString()),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dataBookDetails.judulBuku.toString(),
                    style: TextStyle(
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w700)
                                .fontFamily,
                        fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 20),
                Text("Penulis : ${dataBookDetails.penulisBuku.toString()}",
                    style: TextStyle(
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 17),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
                Text("Penerbit : ${dataBookDetails.penerbitBuku.toString()}",
                    style: TextStyle(
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 17),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
                Text("Tahun Terbit : ${dataBookDetails.tahunTerbit.toString()}",
                    style: TextStyle(
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 17),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ],
            ))
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      dataBookDetails.rating.toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily:
                              GoogleFonts.poppins(fontWeight: FontWeight.w700)
                                  .fontFamily,
                          fontSize: 20),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 20,
                    )
                  ],
                ),
                Text(
                  "${dataBookDetails.totalUlasan.toString()} ulasan",
                  style: TextStyle(
                      fontFamily:
                          GoogleFonts.poppins(fontWeight: FontWeight.w700)
                              .fontFamily,
                      fontSize: 17),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            const ColoredBox(
                color: Colors.black,
                child: SizedBox(
                  height: 35,
                  width: 2,
                )),
            const SizedBox(
              width: 20,
            ),
            Text(
              "${dataBookDetails.jumlahHalaman.toString()} \n Halaman",
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700)
                      .fontFamily,
                  fontSize: 17),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 40),
        Center(
          child: ElevatedButton(
            onPressed: () {
              controller.showMyPinjam(
                );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D193),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.1),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2,
                  vertical: MediaQuery.of(context).size.height * 0.009),
            ),
            child: Text(
              'PINJAM',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: GoogleFonts.baloo2(fontWeight: FontWeight.bold)
                      .fontFamily),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "Tentang buku ini",
          style: TextStyle(
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
              fontSize: 20),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        Text(
          dataBookDetails.deskripsi.toString(),
          style: TextStyle(
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w400).fontFamily,
              fontSize: 20),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        Text(
          "Ranting dan review",
          style: TextStyle(
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
              fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
          child: Row(
            children: [
              Text(
                dataBookDetails.rating.toStringAsFixed(1),
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700)
                        .fontFamily,
                    fontSize: 70),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    direction: Axis.horizontal,
                    rating: dataBookDetails.rating!.toDouble(),
                    itemCount: 5,
                    itemSize: 24,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${dataBookDetails.totalUlasan.toString()} ulasan",
                    style: TextStyle(
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 17),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ),
        buildUlasanList()
      ]),
    );
  }

  Widget buildUlasanList() {
    final width = MediaQuery.of(Get.context!).size.width;

    return dataUlasan!.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataUlasan!.length,
            itemBuilder: (context, index) {
              DataUlasan ulasan = dataUlasan![index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(140),
                          ),
                          child: Image.asset("assets/profil.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          ulasan.username ?? '',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF000000),
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBarIndicator(
                      direction: Axis.horizontal,
                      rating: dataBookDetails.rating!.toDouble(),
                      itemCount: 5,
                      itemSize: 18,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      ulasan.ulasan ?? '',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 17.0),
                    ),
                  ],
                ),
              );
            },
          )
        : Container(
            width: width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF424242),
                width: 0.5,
              ),
            ),
            child: Text(
              'Belum ada ulasan buku',
              style: GoogleFonts.inriaSans(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          );
  }
}
