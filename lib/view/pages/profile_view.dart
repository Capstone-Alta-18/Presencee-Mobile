import 'dart:io';
import 'helps/help_center_view.dart';
import '../../viewModels/mahasiswa_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:presencee/theme/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presencee/view/widgets/State_Status_widget.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MahasiswaViewModel>(context, listen: false).getOneMahasiswa(oneId: 2);
    });
  }

  Future getImage(ImageSource source) async {
    // final imagesData = Provider.of<MahasiswaViewModel>(context, listen: false);
    try {
      ImagePicker picker = ImagePicker();
      var photo = await picker.pickImage(source: source);

      setState(() {
        if (photo != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppTheme.primaryTheme,
            content: Text(
              'Foto profil kamu sudah disematkan !',
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
                                duration: const Duration(seconds: 1),
                                backgroundColor: AppTheme.error,
                                content: Text(
                                  'Foto Profil kamu sudah di hapus !',
                                  style: AppTextStyle.poppinsTextStyle(
                                    fontsWeight: FontWeight.w500,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                            );
                          }
                          image = null;
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

  Future<void> isLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dispose();
    await prefs.clear();
    await prefs.remove('token');
    Navigator.pushNamedAndRemoveUntil(context, '//login', (route) => false);
  }

  void alertLogout() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Apakah Anda yakin ingin keluar akun?",
                    style: AppTextStyle.poppinsTextStyle(
                      fontSize: 16,
                      fontsWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => isLogout(context),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.primaryTheme),
                          foregroundColor: AppTheme.primaryTheme,
                          fixedSize: const Size(150, 40),
                        ),
                        child: Text(
                          'Logout',
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 16,
                            fontsWeight: FontWeight.w500,
                            color: AppTheme.primaryTheme,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryTheme,
                          foregroundColor: AppTheme.white,
                          fixedSize: const Size(150, 40),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 16,
                            fontsWeight: FontWeight.w500,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* @override
  void dispose() {
    emailController.dispose();
    telponController.dispose();
    jurusanController.dispose();
    tahunController.dispose();
    ipkController.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    final dataMahas = Provider.of<MahasiswaViewModel>(context);

    if (dataMahas.state == Status.initial) {
      return const ProfileLoading();
    } else if (dataMahas.state == Status.loading) {
      return const ProfileLoading();
    } else if (dataMahas.state == Status.error) {
      return const ProfileError();
    }

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
        actions: [
          IconButton(
            onPressed: () => alertLogout(),
            icon: const Icon(
              PhosphorIcons.sign_out_bold,
              size: 24,
            ),
          ),
        ],
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
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: FloatingActionButton(
                            onPressed: () => bottomSheet(),
                            backgroundColor: AppTheme.white,
                            elevation: 0,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: FileImage(File(image!.path)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primaryTheme,
                            ),
                            child: IconButton(
                              color: AppTheme.white,
                              onPressed: () => bottomSheet(),
                              icon: const Icon(
                                PhosphorIcons.pencil_bold,
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
                          onPressed: () => bottomSheet(),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.primaryTheme),
                            elevation: 0,
                            shape: const CircleBorder(),
                            backgroundColor: AppTheme.white,
                            fixedSize: const Size(130, 130),
                          ),
                          child: const Icon(
                            PhosphorIcons.user,
                            color: AppTheme.primaryTheme,
                            size: 72,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primaryTheme,
                            ),
                            child: IconButton(
                              color: AppTheme.white,
                              onPressed: () => bottomSheet(),
                              icon: const Icon(
                                PhosphorIcons.pencil_bold,
                                color: AppTheme.white,
                                size: 32,
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
                dataMahas.mahasiswaSingle.name.toString(),
                style: AppTextStyle.poppinsTextStyle(
                  fontSize: 24,
                  fontsWeight: FontWeight.w500,
                  color: AppTheme.black,
                ),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8)),
              Text(
                dataMahas.mahasiswaSingle.nim.toString(),
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
                _buildTextField(
                    'Email',
                    dataMahas.mahasiswaSingle.email.toString() == 'failed to fetch Email'
                        ? emailController
                        : TextEditingController(
                            text: dataMahas.mahasiswaSingle.email.toString())),
                _buildTextField(
                    'No. Telp',
                    dataMahas.mahasiswaSingle.phone.toString() == 'failed to fetch phone'
                        ? telponController
                        : TextEditingController(
                            text: dataMahas.mahasiswaSingle.phone.toString())),
                _buildTextField(
                    'Jurusan',
                    dataMahas.mahasiswaSingle.jurusan.toString() == 'failed to fetch Jurusan'
                        ? jurusanController
                        : TextEditingController(
                            text:
                                dataMahas.mahasiswaSingle.jurusan.toString())),
                _buildTextField(
                    'Tahun',
                    dataMahas.mahasiswaSingle.tahunMasuk == '20??'
                        ? tahunController
                        : TextEditingController(
                            text: dataMahas.mahasiswaSingle.tahunMasuk
                                .toString())),
                _buildTextField(
                    'IPK',
                    dataMahas.mahasiswaSingle.ipk.toString() == '0.0'
                        ? ipkController
                        : TextEditingController(
                            text: dataMahas.mahasiswaSingle.ipk.toString())),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const PusatBantuanPage(),
                      transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(opacity: animation1, child: child),
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryTheme_2,
                  foregroundColor: AppTheme.white,
                  fixedSize: const Size(200, 40),
                ),
                child: const Text('Pusat Bantuan'),
              ),
              OutlinedButton(
                onPressed: () => alertLogout(),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryTheme),
                  foregroundColor: AppTheme.primaryTheme,
                  fixedSize: const Size(200, 40),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controllers) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.primaryTheme_4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
