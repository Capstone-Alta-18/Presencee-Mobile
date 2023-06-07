import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:presencee/theme/constant.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key});

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  bool isExpand = false;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DraggableScrollableSheet(
          initialChildSize: 0.25,
          minChildSize: 0.25,
          maxChildSize: 0.55,
          builder: (context, scrollController) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('Item $index'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}