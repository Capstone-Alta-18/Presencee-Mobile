import 'dart:ui';
import 'package:presencee/view_model/upload_view_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../view_model/mahasiswa_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:presencee/theme/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? image;
  bool isLoading = true;
  final emailController = TextEditingController();
  final telponController = TextEditingController();
  final jurusanController = TextEditingController();
  final tahunController = TextEditingController();
  final ipkController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final idMahasiswa = sharedPreferences.getInt('id_mahasiswa');
      if (mounted) {
        await Provider.of<MahasiswaViewModel>(context, listen: false)
            .getOneMahasiswa(oneId: idMahasiswa ?? 0);
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
        });
      }
    });
    super.initState();
  }

  Future getImage(ImageSource source) async {
    // final imagesData = Provider.of<MahasiswaViewModel>(context, listen: false);
    try {
      ImagePicker picker = ImagePicker();
      XFile? photo = await picker.pickImage(source: source);
      if (photo != null) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
          await Provider.of<UploadImageViewModel>(context, listen: false)
              .uploadImage(photo);
          if (mounted) {
            final url =
                Provider.of<UploadImageViewModel>(context, listen: false)
                    .image
                    ?.url;
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            final idMahasiswa = sharedPreferences.getInt('id_mahasiswa');
            if (mounted) {
              final dataMahas =
                  Provider.of<MahasiswaViewModel>(context, listen: false);
              await Provider.of<MahasiswaViewModel>(context, listen: false)
                  .updateMahasiswa(
                      idMahasiswa: idMahasiswa!,
                      name: dataMahas.mahasiswaSingle.name!,
                      email: dataMahas.mahasiswaSingle.email!,
                      nim: dataMahas.mahasiswaSingle.nim!,
                      image: url!,
                      phone: dataMahas.mahasiswaSingle.phone!,
                      jurusan: dataMahas.mahasiswaSingle.jurusan!,
                      tahunMasuk: dataMahas.mahasiswaSingle.tahunMasuk!,
                      ipk: dataMahas.mahasiswaSingle.ipk!,
                      userId: dataMahas.mahasiswaSingle.userId!);
              if (mounted) {
                await Provider.of<MahasiswaViewModel>(context, listen: false)
                    .getOneMahasiswa(oneId: idMahasiswa);
                if (mounted) {
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
                  Navigator.pop(context);
                }
              }
            }
          }
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick Image : $e');
    }
  }

  Future hapusImage() async {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final idMahasiswa = sharedPreferences.getInt('id_mahasiswa');
    if (mounted) {
      final dataMahas = Provider.of<MahasiswaViewModel>(context, listen: false);
      await Provider.of<MahasiswaViewModel>(context, listen: false)
          .updateMahasiswa(
              idMahasiswa: idMahasiswa!,
              name: dataMahas.mahasiswaSingle.name!,
              email: dataMahas.mahasiswaSingle.email!,
              nim: dataMahas.mahasiswaSingle.nim!,
              image: '',
              phone: dataMahas.mahasiswaSingle.phone!,
              jurusan: dataMahas.mahasiswaSingle.jurusan!,
              tahunMasuk: dataMahas.mahasiswaSingle.tahunMasuk!,
              ipk: dataMahas.mahasiswaSingle.ipk!,
              userId: dataMahas.mahasiswaSingle.userId!);
      if (mounted) {
        await Provider.of<MahasiswaViewModel>(context, listen: false)
            .getOneMahasiswa(oneId: idMahasiswa);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppTheme.primaryTheme,
            content: Text(
              'Foto Profil kamu sudah di hapus !',
              style: AppTextStyle.poppinsTextStyle(
                fontsWeight: FontWeight.w500,
                color: AppTheme.white,
              ),
            ),
          ));
          Navigator.pop(context);
        }
      }
    }
  }

  Future<void> bottomSheet() async {
    return showModalBottomSheet(
        backgroundColor: AppTheme.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                            shape: const CircleBorder(),
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
                            hapusImage();
                            // setState(() {
                            //   if (dataMahas.mahasiswaSingle.image != null) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         duration: const Duration(seconds: 1),
                            //         backgroundColor: AppTheme.error,
                            //         content: Text(
                            //           'Foto Profil kamu sudah di hapus !',
                            //           style: AppTextStyle.poppinsTextStyle(
                            //             fontsWeight: FontWeight.w500,
                            //             color: AppTheme.white,
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   }
                            //   image = null;
                            // });
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
        });
  }

  void isLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.remove('token');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '//login', (route) => false);
    }
  }

  void alertLogout() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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
                  padding: const EdgeInsets.only(
                      bottom: 30.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => isLogout(),
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

  @override
  Widget build(BuildContext context) {
    final dataMahas = Provider.of<MahasiswaViewModel>(context);

    // if (dataMahas.state == Status.initial) {
    //   return const ProfileLoading();
    // } else if (dataMahas.state == Status.completed) {
    //   return const ProfilePage();
    // } else if (dataMahas.state == Status.error) {
    //   return const ProfileError();
    // }

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
              // image != null
              dataMahas.mahasiswaSingle.image != ''
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
                                backgroundColor: AppTheme.white,
                                // backgroundImage: FileImage(File(image!.path)),
                                backgroundImage: NetworkImage(
                                    dataMahas.mahasiswaSingle.image ?? '',
                                    scale: 1.0),
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
                              side: const BorderSide(
                                  color: AppTheme.primaryTheme),
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
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Text(
                        'Nama',
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 24,
                          fontsWeight: FontWeight.w500,
                          color: AppTheme.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : dataMahas.mahasiswaSingle.name != null
                      ? Text(
                          dataMahas.mahasiswaSingle.name.toString(),
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 24,
                            fontsWeight: FontWeight.w500,
                            color: AppTheme.black,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Name',
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 24,
                            fontsWeight: FontWeight.w500,
                            color: AppTheme.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
              const Padding(padding: EdgeInsets.only(bottom: 8)),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Text(
                        'NIM',
                        style: AppTextStyle.poppinsTextStyle(
                          fontSize: 16,
                          fontsWeight: FontWeight.w400,
                          color: AppTheme.black_3,
                        ),
                      ),
                    )
                  : dataMahas.mahasiswaSingle.nim != null
                      ? Text(
                          dataMahas.mahasiswaSingle.nim.toString(),
                          style: AppTextStyle.poppinsTextStyle(
                            fontSize: 16,
                            fontsWeight: FontWeight.w400,
                            color: AppTheme.black_3,
                          ),
                        )
                      : Text(
                          'NIM',
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
                  dataMahas.mahasiswaSingle.email == null
                      ? emailController
                      : TextEditingController(
                          text: dataMahas.mahasiswaSingle.email.toString()),
                  isLoading,
                ),
                _buildTextField(
                  'No. Telp',
                  dataMahas.mahasiswaSingle.phone == null
                      ? telponController
                      : TextEditingController(
                          text: dataMahas.mahasiswaSingle.phone.toString()),
                  isLoading,
                ),
                _buildTextField(
                  'Jurusan',
                  dataMahas.mahasiswaSingle.jurusan == null
                      ? jurusanController
                      : TextEditingController(
                          text: dataMahas.mahasiswaSingle.jurusan.toString()),
                  isLoading,
                ),
                _buildTextField(
                  'Tahun',
                  dataMahas.mahasiswaSingle.tahunMasuk == null
                      ? tahunController
                      : TextEditingController(
                          text:
                              dataMahas.mahasiswaSingle.tahunMasuk.toString()),
                  isLoading,
                ),
                _buildTextField(
                  'IPK',
                  dataMahas.mahasiswaSingle.ipk == null
                      ? ipkController
                      : TextEditingController(
                          text: dataMahas.mahasiswaSingle.ipk.toString()),
                  isLoading,
                ),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/profiles/underMaintenance'),
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

  Widget _buildTextField(
      String label, TextEditingController controllers, bool isLoading) {
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
              controller: isLoading
                  ? TextEditingController(text: 'Loading')
                  : controllers,
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
