import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:presencee/model/API/jadwal_api.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:presencee/model/jadwal_model.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:presencee/view_model/mahasiswa_view_model.dart';
import 'package:presencee/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:presencee/view/widgets/today.dart';
import '../../model/jadwal_model.dart';
import '../../theme/constant.dart';
// import '../widgets/alerted_attendance.dart';
import '../widgets/card_absensi.dart';
import 'package:grouped_list/grouped_list.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool isTodaySelected =
      true; // Set initial selection state of "Hari ini" button
  bool isAllSelected = false; // Set initial selection state of "Semua" button
  StreamController<DateTime> timeController = StreamController<DateTime>();
  final TextEditingController _searchController = TextEditingController();

  List<Data> _searchResults = [];
  bool _isLoading = false;
  bool isSearching = false;

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
        isSearching = true;
      });

      JadwalApi.getFilterJadwalSemua(
        userId: 0,
        jamAfter: '',
        jamBefore: '',
      ).then((List<Data> jadwalList) {
        setState(() {
          _isLoading = false;
          _searchResults = jadwalList
              .where((jadwal) => jadwal.name
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
          _searchResults = [];
          isSearching = false;
        });
        print('Error: $error');
      });
    } else {
      setState(() {
        _searchResults = [];
        isSearching = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<JadwalViewModel>(context, listen: false).getJadwal(
      //   pages: 1,
      //   limits: 10,
      // );
      final user =
          Provider.of<UserViewModel>(context, listen: false).user?.data;
      var now = DateTime.now();
      var jamAfter = DateFormat('yyyy-MM-ddT00:00:00+00:00').format(now);
      var jamBefore = DateFormat('yyyy-MM-ddT23:59:00+00:00').format(now);
      var previousMonday = now.subtract(Duration(days: now.weekday - 1));
      var nextSaturday = previousMonday.add(Duration(days: 6));
      var createdAfter =
          DateFormat('yyyy-MM-ddT00:00:00+00:00').format(previousMonday);
      var createdBefore =
          DateFormat('yyyy-MM-ddT23:59:00+00:00').format(nextSaturday);

      Provider.of<JadwalViewModel>(context, listen: false).getFilterJadwal(
          userId: user?.id ?? 0, jamAfter: jamAfter, jamBefore: jamBefore);

      Provider.of<JadwalViewModel>(context, listen: false).getFilterJadwalSemua(
          userId: user?.id ?? 0,
          jamAfter: createdAfter,
          jamBefore: createdBefore);
    });
    Timer.periodic(const Duration(seconds: 1), (_) {
      timeController.add(DateTime.now());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<DateTime>(
              stream: timeController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DateTime currentTime = snapshot.data!;
                  return TodayWidgets(
                    presensi: false,
                    back: false,
                    currentTime: currentTime,
                  );
                } else {
                  return Container(
                    height: 237,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gray_2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppTheme.gradient_1, AppTheme.gradient_2],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading',
                          style: AppTextStyle.poppinsTextStyle(
                              color: AppTheme.white,
                              fontSize: 14,
                              fontsWeight: FontWeight.w400),
                        ),
                        Text(
                          'Loading',
                          style: AppTextStyle.poppinsTextStyle(
                            color: AppTheme.white,
                            fontSize: 45,
                            fontsWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                _searchBar(),
                // SearchScreen(),
                const SizedBox(height: 20),
                _viewJadwal(),
                const SizedBox(height: 20),
                _buildJadwalAbsensi(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    // bool isSearch = false;

    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(15),
      ],
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        hintText: 'input search text...',
        hintStyle: const TextStyle(
          color: AppTheme.gray_2,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: AppTheme.gray_2,
          ),
        ),
        suffixIcon: Container(
          decoration: const BoxDecoration(
            // color: isSearch ? highlightSearch : Colors.transparent,      // change color when search are clicked
            border: Border(
              left: BorderSide(
                color: AppTheme.gray_2,
              ),
            ),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              _performSearch(_searchController.text);
              // isSearch = !isSearch;
            },
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: AppTheme.primaryTheme_2,
            width: 1,
          ),
        ),
      ),
      onChanged: _performSearch,
      // onChanged: (value) {
      //   // Implementasi logika pencarian di sini
      // },
    );
  }

  Widget _buildJadwalAbsensi() {
    final allJadwal = Provider.of<JadwalViewModel>(context);
    final filterJadwal = Provider.of<JadwalViewModel>(context);

    String getInitials(String name) {
      if (name.isEmpty) return '';

      final words = name.split(' ');
      final initials = words.map((word) => word[0].toUpperCase()).join('');

      return initials;
    }

    String getDayName(String dateString) {
      final dateTime = DateTime.parse(dateString);
      final dayName = DateFormat('EEEE', 'id').format(dateTime);
      return dayName;
    }

    String getTime(String dateString) {
      final dateTime = DateTime.parse(dateString);
      final time = DateFormat('HH:mm').format(dateTime);
      return time;
    }

    // final fullName = allJadwal.jadwals[0].name!;
    // final initials = getInitials(fullName);
    // final dayName = getDayName(allJadwal.jadwals[0].jam!);
    // final time = getTime(allJadwal.jadwals[0].jam!);

    // Filter Jadwal
    // final namaJadwal = filterJadwal.filterJadwals[0].name!;
    // print(namaJadwal);

    if (isSearching) {
      return _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                Data jadwal = _searchResults[index];
                final namaHari = getDayName(jadwal.jam!);
                final jam = getTime(jadwal.jam!);
                final kodeKelas = getInitials(jadwal.name!);
                return CardAbsensi(
                  matkul: jadwal.name!,
                  dosen: jadwal.dosen!.name!,
                  jam: "$namaHari $jam",
                  kodeKelas: kodeKelas,
                  idJadwal: jadwal.id!,
                );
              },
            );
    } else {
      if (isTodaySelected) {
        return filterJadwal.filterJadwals.isEmpty
            ? Card(
                elevation: 1.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  splashColor: AppTheme.primaryTheme.withOpacity(0.2),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Center(
                    child: Text('Tidak ada jadwal',
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.black,
                          fontsWeight: FontWeight.w500,
                          fontSize: 16,
                        )),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filterJadwal.filterJadwals.length,
                itemBuilder: (context, index) {
                  final fullName = filterJadwal.filterJadwals[index].name!;
                  final initials = getInitials(fullName);
                  final dayName =
                      getDayName(filterJadwal.filterJadwals[index].jam!);
                  final time = getTime(filterJadwal.filterJadwals[index].jam!);
                  return CardAbsensi(
                    matkul: fullName,
                    dosen: filterJadwal.filterJadwals[index].dosen!.name!,
                    jam: "$dayName $time",
                    kodeKelas: initials,
                    idJadwal: filterJadwal.filterJadwals[index].id!,
                  );
                });
      } else if (isAllSelected) {
        return allJadwal.jadwals.isEmpty
            ? Card(
                elevation: 1.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  splashColor: AppTheme.primaryTheme.withOpacity(0.2),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Center(
                    child: Text('Tidak ada jadwal',
                        style: AppTextStyle.poppinsTextStyle(
                          color: AppTheme.black,
                          fontsWeight: FontWeight.w500,
                          fontSize: 16,
                        )),
                  ),
                ),
              )
            : GroupedListView<Data, String>(
                shrinkWrap: true,
                elements: allJadwal.jadwals.map((jadwal) => jadwal).toList(),
                groupBy: (element) => element.jam!,
                groupSeparatorBuilder: (String groupByValue) {
                  final groupHari = getDayName(groupByValue);
                  return Row(
                    children: [
                      Flexible(
                          child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 10, bottom: 5, top: 20),
                            child: Text(
                              // groupByValue,
                              groupHari,
                              textAlign: TextAlign.start,
                              style: AppTextStyle.poppinsTextStyle(
                                  fontSize: 18,
                                  fontsWeight: FontWeight.w500,
                                  color: AppTheme.black),
                            ),
                          )
                        ],
                      ))
                    ],
                  );
                },
                itemBuilder: (context, Data element) {
                  final initials = getInitials(element.name!);
                  final hari = getDayName(element.jam!);
                  final jam = getTime(element.jam!);
                  return CardAbsensi(
                    matkul: element.name!,
                    dosen: element.dosen!.name!,
                    jam: '$hari $jam',
                    kodeKelas: initials,
                    idJadwal: element.id!,
                  );
                },
                itemComparator: (item1, item2) =>
                    item1.name!.compareTo(item2.name!),
                // useStickyGroupSeparators: true,
                floatingHeader: true,
                order: GroupedListOrder.ASC,
              );
        // ListView.builder(
        //   shrinkWrap: true,
        //   padding: const EdgeInsets.all(0),
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: allJadwal.jadwals.length,
        //   itemBuilder: (context, index) {
        //     final initials = getInitials(allJadwal.jadwals[index].name!);
        //     final hari = getDayName(allJadwal.jadwals[index].jam!);
        //     final jam = getTime(allJadwal.jadwals[index].jam!);
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(left: 15),
        //           child: Text(
        //             hari,
        //             style: AppTextStyle.poppinsTextStyle(
        //                 fontSize: 18,
        //                 fontsWeight: FontWeight.w500,
        //                 color: AppTheme.black),
        //           ),
        //         ),
        //         CardAbsensi(
        //           matkul: allJadwal.jadwals[index].name!,
        //           dosen: allJadwal.jadwals[index].dosen!.name!,
        //           jam: '$hari $jam',
        //           kodeKelas: initials,
        //           idJadwal: allJadwal.jadwals[index].id!,
        //         ),
        //         const SizedBox(height: 30),
        //       ],
        //     );
        //   },
        // );
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget _viewJadwal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isTodaySelected = true;
              isAllSelected = false;
            });
          },
          child: Container(
            height: 22,
            width: 57,
            decoration: BoxDecoration(
              color:
                  isTodaySelected ? AppTheme.primaryTheme_2 : AppTheme.gray_2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Hari ini',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              isTodaySelected = false;
              isAllSelected = true;
            });
          },
          child: Container(
            height: 22,
            width: 57,
            decoration: BoxDecoration(
              color: isAllSelected ? AppTheme.primaryTheme_2 : AppTheme.gray_2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Semua',
                style: AppTextStyle.poppinsTextStyle(
                  color: AppTheme.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
