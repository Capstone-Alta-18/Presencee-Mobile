import 'package:flutter/material.dart';
import 'package:presencee/view/widgets/diagram_history.dart';
import 'package:presencee/view/widgets/header_history.dart';
import 'package:presencee/view/widgets/list_history.dart';

class CourseHistory extends StatefulWidget {
  const CourseHistory({Key? key}) : super(key: key);

  @override
  State<CourseHistory> createState() => _CourseHistoryState();
}

class _CourseHistoryState extends State<CourseHistory> {
  @override
  Widget build(BuildContext context) {

    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: HeaderHistory()),
        body: TabBarView(
          children: [
            ListHistory(),
            DiagramHistory()
          ],
        ),
      ),
    );
  }
}
