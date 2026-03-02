import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;
  final double size;
  const CustomPieChart({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    final pendingTasks = totalTasks - completedTasks;
    double percentage = (totalTasks == 0)
        ? 0.0
        : (completedTasks / totalTasks) * 100;
    String displayPercentage =
        "${percentage.toStringAsFixed(1)}%";

    if (totalTasks == 0) {
      return SizedBox(
        width: size,
        height: size,
        child: const Center(child: Text("No Tasks")),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          PieChart(
            duration: const Duration(milliseconds: 700),
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: size * 0.28,
              sections: [
                PieChartSectionData(
                  titlePositionPercentageOffset: 0.3,
                  color: Colors.green,
                  value: completedTasks.toDouble(),
                  title: '',
                  radius: size * 0.20,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.amber,
                  value: pendingTasks.toDouble(),
                  title: '',
                  radius: size * 0.20,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              displayPercentage,
              style: TextStyle(
                fontSize: size * 0.15,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(
                  255,
                  97,
                  20,
                  231,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
