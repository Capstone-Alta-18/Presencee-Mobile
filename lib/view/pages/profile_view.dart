import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/maintenance_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final emailController = TextEditingController();
  final telponController = TextEditingController();
  final jurusanController = TextEditingController();
  final tahunController = TextEditingController();
  final ipkController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = 'kristina.faboulus@students.com';
    telponController.text = '081213476509';
    jurusanController.text = 'Seni Rupa';
    tahunController.text = '2020/Semester 6';
    ipkController.text = '3,85';
  }

  @override
  Widget build(BuildContext context) {
    File? image;

    Future getCamera() async {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      image = File(photo!.path);
      setState(() {});
    }

    Future getGallery() async {
      final ImagePicker picker = ImagePicker();
      final XFile? gallery = await picker.pickImage(source: ImageSource.gallery);
      image = File(gallery!.path);
      setState(() {});
    }

    Future<void> bottomSheet() async {
      return showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          context: context,
          builder: (context) {
            return Container(
              margin: EdgeInsets.only(top: 10,left: 28),
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close)),
                  Row(
                    children: [
                      Text("Ganti foto profil",
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await getCamera();
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(color: Colors.black38),
                              elevation: 0,
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              fixedSize: const Size(60, 60),
                            ),
                            child: const Icon(
                              Icons.photo_camera_rounded,
                              size: 30,
                              color: Color.fromARGB(255, 254, 121, 104),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text("Kamera",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await getGallery();
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(color: Colors.black38),
                              elevation: 0,
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              fixedSize: const Size(60, 60),
                            ),
                            child: const Icon(
                              Icons.photo_library_rounded,
                              size: 30,
                              color: Color.fromARGB(255, 254, 121, 104),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text("Galeri",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(color: Colors.black38),
                              elevation: 0,
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              fixedSize: const Size(60, 60),
                            ),
                            child: const Icon(
                              Icons.delete,
                              size: 30,
                              color: Color.fromARGB(255, 254, 121, 104),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text("Hapus",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          });
    }

    ;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil',style: AppTextStyle.poppinsTextStyle(fontsWeight: FontWeight.w500)),
      ),
      body: ListView(
        children: [
          image == null
              ? Container(
                  margin: EdgeInsets.all(21),
                  child: ElevatedButton(
                    onPressed: () {
                      bottomSheet();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color.fromARGB(255, 254, 121, 104)),
                        elevation: 0,
                        shape: CircleBorder(),
                        fixedSize: Size(130, 130)),
                    child: Icon(Icons.person,
                        size: 70, color: Colors.black38),
                  ))
              : Container(
                  margin: EdgeInsets.all(21),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          bottomSheet();
                        },
                        child: ClipOval(
                            child: Image.file(
                          image!,
                          fit: BoxFit.contain,
                        ))),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Kristina Fabulous",
                style: AppTextStyle.poppinsTextStyle(
                  fontSize: 24,
                  fontsWeight: FontWeight.w500,
                  color: AppTheme.black
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 8)),
              Text('200280120739',
                  style: AppTextStyle.poppinsTextStyle(
                      fontSize: 16,
                      fontsWeight: FontWeight.w400,
                      color: AppTheme.black_3
                  )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Form(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email',
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 16, fontsWeight: FontWeight.w500)),
                      Container(
                        width: 250,
                        height: 35,
                        child: TextField(
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 13, fontsWeight: FontWeight.w400),
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('No Telpon',
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 16, fontsWeight: FontWeight.w500)),
                      Container(
                        width: 250,
                        height: 35,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 13, fontsWeight: FontWeight.w400),
                          controller: telponController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jurusan',
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 16, fontsWeight: FontWeight.w500)),
                      Container(
                        width: 250,
                        height: 35,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 13, fontsWeight: FontWeight.w400),
                          controller: jurusanController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tahun Masuk',
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 16, fontsWeight: FontWeight.w500)),
                      Container(
                        width: 250,
                        height: 35,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 13, fontsWeight: FontWeight.w400),
                          controller: tahunController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'IPK',
                        style: AppTextStyle.poppinsTextStyle(
                            fontSize: 16, fontsWeight: FontWeight.w500),
                      ),
                      Container(
                        width: 250,
                        height: 35,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                              fontSize: 13, fontsWeight: FontWeight.w400),
                          controller: ipkController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 50)),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PusatBantuanPage()));
                },
                child: Text('Pusat Bantuan'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 254, 121, 104),
                    foregroundColor: Colors.white),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Color.fromARGB(255, 254, 121, 104)),
                    foregroundColor: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: AppTheme.primaryTheme
        ),
        elevation: 0.5,
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        title: Text('Pusat Bantuan',
          style: AppTextStyle.poppinsTextStyle(
            fontsWeight: FontWeight.w500,
            color: AppTheme.primaryTheme
          ),
        ),
      ),
      body: const MaintenancePage(),
    );
  }
}
