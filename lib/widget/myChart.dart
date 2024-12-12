import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SensorChart extends StatefulWidget {
  final String title;
  final List<FlSpot> points;
  final Color color;

  const SensorChart({
    Key? key,
    required this.title,
    required this.points,
    required this.color,
  }) : super(key: key);

  @override
  State<SensorChart> createState() => _SensorChartState();
}

class _SensorChartState extends State<SensorChart> {
  bool show_me = true;
  bool _isZoomed = false;
  double _minX = 0;
  double _maxX = 9;
  double _minY = 0;
  double _maxY = 100;
  @override
  void initState() {
    super.initState();
    show_me = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isZoomed = !_isZoomed;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isZoomed ? 400 : 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.points.isNotEmpty
                      ? widget.points.last.y.toStringAsFixed(1)
                      : '0.0',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 20,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 2,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      show: widget.points.isNotEmpty,
                      spots: widget.points,
                      isCurved: true,
                      color: widget.color,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: widget.color.withOpacity(0.2),
                      ),
                    ),
                  ],
                  minX: _minX,
                  maxX: _maxX,
                  minY: _minY,
                  maxY: _maxY,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
