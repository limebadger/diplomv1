import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class alarmWidget extends StatefulWidget {
  const alarmWidget({super.key});

  @override
  State<alarmWidget> createState() => _alarmWidgetState();
}

class _alarmWidgetState extends State<alarmWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 5,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset('assets/chart.jpg'),
              );
            }),
      ),
    );
  }
}
