import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import '../datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[800],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(19, 90, 2, 179),
          2: Color.fromARGB(40, 132, 2, 179),
          3: Color.fromARGB(59, 120, 2, 179),
          4: Color.fromARGB(80, 102, 2, 179),
          5: Color.fromARGB(99, 79, 2, 179),
          6: Color.fromARGB(120, 102, 2, 179),
          7: Color.fromARGB(149, 108, 2, 179),
          8: Color.fromARGB(180, 114, 2, 179),
          9: Color.fromARGB(220, 132, 2, 179),
          10: Color.fromARGB(255, 114, 2, 179),
        },
      ),
    );
  }
}
