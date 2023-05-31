import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presencee/theme/constant.dart';
import 'package:presencee/view/pages/maintenance_view.dart';

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

  Future getImage(ImageSource source) async {
    try {
      ImagePicker picker = ImagePicker();
      var photo = await picker.pickImage(source: source);

      setState(() {
        if (photo != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppTheme.gray,
            content: Text('Foto profil kamu sudah disematkan !',
                style: AppTextStyle.poppinsTextStyle(
                  fontsWeight: FontWeight.w400,
                  color: AppTheme.primaryTheme,
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        context: context,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 28),
            height: 230,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                /* IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    icon: const Icon(
                      PhosphorIcons.x_circle,
                    )
                  ), */
                Row(
                  children: [
                    Text(
                      "Ganti foto profil",
                      style: AppTextStyle.poppinsTextStyle(
                        fontSize: 20,
                        fontsWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await getImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black38),
                            elevation: 0,
                            shape: CircleBorder(),
                            backgroundColor: Colors.white,
                            fixedSize: const Size(60, 60),
                          ),
                          child: const Icon(
                            PhosphorIcons.camera_fill,
                            size: 30,
                            color: AppTheme.primaryTheme,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
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
                              side: const BorderSide(color: Colors.black38),
                              elevation: 0,
                              shape: const CircleBorder(),
                              backgroundColor: AppTheme.white,
                              fixedSize: const Size(60, 60),
                            ),
                            child: const Icon(
                              PhosphorIcons.image_fill,
                              size: 30,
                              color: AppTheme.primaryTheme,
                            )),
                        const Padding(padding: EdgeInsets.only(top: 20)),
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
                                    backgroundColor: AppTheme.gray,
                                    content: Text(
                                      'Foto Profil kamu sudah di hapus !',
                                      style: AppTextStyle.poppinsTextStyle(
                                          fontsWeight: FontWeight.w400,
                                          color: AppTheme.primaryTheme),
                                    ),
                                  ),
                                );
                                image = null;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black38),
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
                        const Padding(padding: EdgeInsets.only(top: 20)),
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
        });
  }

  // dikasih sizedbox

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil',
            style: AppTextStyle.poppinsTextStyle(fontsWeight: FontWeight.w500)),
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
                              child: ClipOval(
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
                                  Icons.edit,
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
                              side: const BorderSide(
                                  color: AppTheme.primaryTheme),
                              elevation: 0,
                              shape: CircleBorder(),
                              fixedSize: Size(130, 130),
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
          Form(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 13,
                            fontsWeight: FontWeight.w400,
                          ),
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'No Telpon',
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 14,
                            fontsWeight: FontWeight.w400,
                          ),
                          controller: telponController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jurusan',
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 14,
                            fontsWeight: FontWeight.w400,
                          ),
                          controller: jurusanController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tahun',
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 14,
                            fontsWeight: FontWeight.w400,
                          ),
                          controller: tahunController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'IPK',
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 14,
                            fontsWeight: FontWeight.w400,
                          ),
                          controller: ipkController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 50)),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PusatBantuanPage(),
                      ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryTheme_2,
                  foregroundColor: Colors.white,
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
}

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIcons.x, color: AppTheme.primaryTheme),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: AppTheme.primaryTheme),
        elevation: 0.5,
        backgroundColor: AppTheme.gray,
        title: Text(
          'Pusat Bantuan',
          style: AppTextStyle.poppinsTextStyle(
              fontsWeight: FontWeight.w500, color: AppTheme.primaryTheme),
        ),
      ),
      body: const MaintenancePage(),
    );
  }
}
