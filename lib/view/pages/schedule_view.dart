import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:presencee/view/widgets/State_Status_widget.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:presencee/model/jadwal_model.dart';
import 'package:presencee/model/API/jadwal_api.dart';
import 'package:presencee/view_model/jadwal_view_model.dart';
import 'package:presencee/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:presencee/view/widgets/today.dart';
import '../../model/jadwal_model.dart';
import '../../theme/constant.dart';
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
        log('Error: $error');
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
      final user =
          Provider.of<UserViewModel>(context, listen: false).user?.data;
      var now = DateTime.now();
      var jamAfter = DateFormat('yyyy-MM-ddT00:00:00+00:00').format(now);
      var jamBefore = DateFormat('yyyy-MM-ddT23:59:00+00:00').format(now);
      var previousMonday = now.subtract(Duration(days: now.weekday - 1));
      var nextSaturday = previousMonday.add(const Duration(days: 6));
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
    );
  }

  Widget _buildJadwalAbsensi() {
    final allJadwal = Provider.of<JadwalViewModel>(context);
    final filterJadwal = Provider.of<JadwalViewModel>(context);

    if (allJadwal.status == Status.initial) {
      return const Center();
    } else if (allJadwal.status == Status.loading) {
      return const Center();
    } else if (allJadwal.status == Status.error) {
      return const Center();
    }

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
                final namaHari = getDayName(jadwal.jamMulai!);
                final jamMulai = getTime(jadwal.jamMulai!);
                final jamSelesai = getTime(jadwal.jamSelesai!);
                final kodeKelas = getInitials(jadwal.room!.name!);
                return CardAbsensi(
                  matkul: jadwal.name!,
                  dosen: jadwal.dosen!.name!,
                  jam: "$namaHari $jamMulai-$jamSelesai",
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
                  final initials = getInitials(
                      filterJadwal.filterJadwals[index].room!.name!);
                  final dayName =
                      getDayName(filterJadwal.filterJadwals[index].jamMulai!);
                  final jamMulai =
                      getTime(filterJadwal.filterJadwals[index].jamMulai!);
                  final jamSelesai =
                      getTime(filterJadwal.filterJadwals[index].jamSelesai!);
                  return CardAbsensi(
                    matkul: fullName,
                    dosen: filterJadwal.filterJadwals[index].dosen!.name!,
                    jam: "$dayName $jamMulai-$jamSelesai",
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
                groupBy: (element) => element.jamMulai!,
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
                  final initials = getInitials(element.room!.name!);
                  final hari = getDayName(element.jamMulai!);
                  final jamMulai = getTime(element.jamMulai!);
                  final jamSelesai = getTime(element.jamSelesai!);
                  return CardAbsensi(
                    matkul: element.name!,
                    dosen: element.dosen!.name!,
                    jam: '$hari $jamMulai-$jamSelesai',
                    kodeKelas: initials,
                    idJadwal: element.id!,
                  );
                },
                itemComparator: (item1, item2) =>
                    item1.name!.compareTo(item2.name!),
                floatingHeader: true,
                order: GroupedListOrder.ASC,
              );
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
