import 'package:yulian_perpustakaan/app/components/starRating.dart';
import 'package:yulian_perpustakaan/app/data/models/response_buku.dart';
import 'package:flutter/material.dart';
import 'package:yulian_perpustakaan/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class buildSection extends StatelessWidget {
  const buildSection({
    super.key,
    required this.data,
  });

  final List<DataBuku> data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyBuku(data: data[index].buku!),
            const SizedBox(height: 10,)
          ],
        );
      },
    );
  }
}

class MyBuku extends StatelessWidget {
  const MyBuku({super.key, required this.data});
  final List<Buku> data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.6, mainAxisSpacing: 10, crossAxisSpacing: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.DETAILBOOK, parameters: {"idbook" : data[index].bukuID.toString()}),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(data[index].coverBuku.toString()), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 140,
                    width: 100,
                    child: Image.network(data[index].coverBuku.toString(),
                        fit: BoxFit.fill),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(data[index].judul.toString(),style: TextStyle(fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.bold).fontFamily),maxLines: 1,overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(data[index].deskripsi.toString(),maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.normal).fontFamily, fontSize: 10)),
                          ),
                          StarRating(
                            rating: data[index].rating!.toDouble(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
