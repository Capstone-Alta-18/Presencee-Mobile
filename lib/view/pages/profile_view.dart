import 'dart:io';
import 'help_center_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presencee/theme/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? image;

  final emailController = TextEditingController();
  final telponController = TextEditingController();
  final jurusanController = TextEditingController();
  final tahunController = TextEditingController();
  final ipkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = 'kristina.faboulus@mail.com';
    telponController.text = '081213476509';
    jurusanController.text = 'Seni Rupa';
    tahunController.text = '2020/Semester 6';
    ipkController.text = '3,85';
  }

  Future getImage(ImageSource source) async {
    try {
      ImagePicker picker = ImagePicker();
      var photo = await picker.pickImage(source: source);

      setState(() {
        if (photo != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppTheme.primaryTheme,
            content: Text('Foto profil kamu sudah disematkan !',
                style: AppTextStyle.poppinsTextStyle(
                  fontsWeight: FontWeight.w500,
                  color: AppTheme.white,
                  ),
                ),
          ));
          image = photo;
        }
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick Image : $e');
    }
  }

  Future<void> bottomSheet() async {
    return showModalBottomSheet(
      backgroundColor: AppTheme.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          height: 180,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ganti foto profil",
                    style: AppTextStyle.poppinsTextStyle(
                      fontSize: 22,
                      fontsWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await getImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.gray_2),
                          elevation: 0,
                          shape: CircleBorder(),
                          backgroundColor: AppTheme.white,
                          fixedSize: const Size(60, 60),
                        ),
                        child: const Icon(
                          PhosphorIcons.camera_fill,
                          size: 30,
                          color: AppTheme.primaryTheme,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Kamera",
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await getImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.gray_2),
                          elevation: 0,
                          shape: const CircleBorder(),
                          backgroundColor: AppTheme.white,
                          fixedSize: const Size(60, 60),
                        ),
                        child: const Icon(
                          PhosphorIcons.image_fill,
                          size: 30,
                          color: AppTheme.primaryTheme,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Galeri",
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            if (image != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppTheme.primaryTheme,
                                  content: Text(
                                    'Foto Profil kamu sudah di hapus !',
                                    style: AppTextStyle.poppinsTextStyle(
                                      fontsWeight: FontWeight.w500,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ),
                              );
                              image = null;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.gray_2),
                          elevation: 0,
                          shape: const CircleBorder(),
                          backgroundColor: AppTheme.white,
                          fixedSize: const Size(60, 60),
                        ),
                        child: const Icon(
                          PhosphorIcons.trash_fill,
                          size: 30,
                          color: AppTheme.primaryTheme,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Hapus",
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: AppTextStyle.poppinsTextStyle(
            fontsWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              image != null
                ? Container(
                    margin: const EdgeInsets.all(21),
                    height: 130,
                    width: 130,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: AppTheme.white,
                          child: InkWell(
                            onTap: () {
                              bottomSheet();
                            },
                            child: ClipPath(
                              clipper: const ShapeBorderClipper(
                                shape: CircleBorder(),
                              ),
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () => bottomSheet(),
                            child: const CircleAvatar(
                              backgroundColor: AppTheme.primaryTheme,
                              child: Icon(
                                PhosphorIcons.pencil_bold,
                                weight: 29.0,
                                size: 32,
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(21),
                    height: 130,
                    width: 130,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            bottomSheet();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.white,
                            side: const BorderSide(color: AppTheme.primaryTheme),
                            elevation: 0,
                            shape: const CircleBorder(),
                            fixedSize: const Size(130, 130),
                          ),
                          child: const Icon(
                            PhosphorIcons.camera_fill,
                            size: 70,
                            color: AppTheme.black_3,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () => bottomSheet(),
                            child: const CircleAvatar(
                              backgroundColor: AppTheme.primaryTheme,
                              child: Icon(
                                PhosphorIcons.pencil,
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Kristina Fabulous",
                style: AppTextStyle.poppinsTextStyle(
                    fontSize: 24,
                    fontsWeight: FontWeight.w500,
                    color: AppTheme.black),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8)),
              Text(
                '200280120739',
                style: AppTextStyle.poppinsTextStyle(
                  fontSize: 16,
                  fontsWeight: FontWeight.w400,
                  color: AppTheme.black_3,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Email', emailController),
                const SizedBox(height: 14,),
                _buildTextField('No. Telp', telponController),
                const SizedBox(height: 14,),
                _buildTextField('Jurusan', jurusanController),
                const SizedBox(height: 14,),
                _buildTextField('Tahun', tahunController),
                const SizedBox(height: 14,),
                _buildTextField('IPK', ipkController),
                const SizedBox(height: 14,),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 36)),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const PusatBantuanPage(),
                      transitionsBuilder: (context, animation1, animation2, child) {
                        return FadeTransition(opacity: animation1, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryTheme_2,
                  foregroundColor: AppTheme.white,
                ),
                child: const Text('Pusat Bantuan'),
              ),
              OutlinedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryTheme),
                  foregroundColor: AppTheme.primaryTheme),
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controllers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.poppinsTextStyle(
            fontSize: 16,
            fontsWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 245,
          height: 40,
          child: TextField(
            style: AppTextStyle.poppinsTextStyle(
              fontSize: 14,
              fontsWeight: FontWeight.w400,
              color: AppTheme.black,
            ),
            readOnly: true,
            controller: controllers,
            textAlign: TextAlign.left,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryTheme_4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
