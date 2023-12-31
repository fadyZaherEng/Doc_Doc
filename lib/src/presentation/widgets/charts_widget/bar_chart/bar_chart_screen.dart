import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/bar_chart/widgets/bar_chart_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/bar_chart/widgets/bar_color_widget.dart';

class BarChartScreen extends StatefulWidget {
  const BarChartScreen({super.key});

  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  late List<BarChart> data;

  @override
  void initState() {
    super.initState();
    data = [
      BarChart([
        BarData("Mega", 0.5),
        BarData("Sanitary", 0.3),
        BarData("Construction", 0.2),
      ], ColorSchemes.barOrange),
      BarChart([
        BarData("Mega", 0.4),
        BarData("Sanitary", 0.2),
        BarData("Construction", 0.6),
      ], ColorSchemes.redError),
      BarChart([
        BarData("Mega", 0.8),
        BarData("Sanitary", 0.2),
        BarData("Construction", 0.1),
      ], ColorSchemes.black),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
          decoration: BoxDecoration(
            color: ColorSchemes.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
                color: ColorSchemes.black.withOpacity(
                  0.1,
                ),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BarChartWidget(
                maximumLabels: 3,
                labelRotation: 0,
                data: data,
                width: 0.3,
                height: 250,
                minimum: 0,
                maximum: 0.9,
                interval: 1,
              ),
              BarColorWidget(
                barColors: [
                  BarColorModel(
                    title: "Total Delay Less Equal Than",
                    color: ColorSchemes.barOrange,
                  ),
                  BarColorModel(
                    title: "Total Delay More Than",
                    color: ColorSchemes.redError,
                  ),
                  BarColorModel(
                    title: "Total Delay More Than",
                    color: ColorSchemes.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
