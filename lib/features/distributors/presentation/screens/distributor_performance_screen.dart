import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';

class DistributorPerformanceScreen extends StatelessWidget {
  final DistributorModel distributor;

  const DistributorPerformanceScreen({
    super.key,
    required this.distributor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Performance Analytics',
          style: TextStyle(
            fontSize: AppTheme.headingFontSize,
            fontWeight: AppTheme.boldWeight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: AppTheme.defaultPadding),
            _buildMonthlyOrdersChart(),
            SizedBox(height: AppTheme.defaultPadding),
            _buildPerformanceMetrics(),
            SizedBox(height: AppTheme.defaultPadding),
            _buildFeedbackSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: _getStatusColor(distributor.status),
              child: Text(
                distributor.fullName[0],
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: AppTheme.defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    distributor.fullName,
                    style: TextStyle(
                      fontSize: AppTheme.subheadingFontSize,
                      fontWeight: AppTheme.boldWeight,
                    ),
                  ),
                  Text(
                    'Area: ${distributor.area}',
                    style: TextStyle(
                      fontSize: AppTheme.defaultFontSize,
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyOrdersChart() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Order Count',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(5, 3),
                      ],
                      isCurved: true,
                      color: AppTheme.primaryBlue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            _buildMetricRow(
              'Success Rate',
              '95%',
              AppTheme.successColor,
            ),
            _buildMetricRow(
              'Cancellation Rate',
              '2%',
              AppTheme.errorColor,
            ),
            _buildMetricRow(
              'Average Delivery Time',
              '${distributor.averageDeliveryTime} min',
              AppTheme.primaryBlue,
            ),
            _buildMetricRow(
              'Customer Rating',
              distributor.rating.toString(),
              AppTheme.warningColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Feedback',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.star, color: Colors.amber),
                  title: Text(
                    'Customer ${index + 1}',
                    style: TextStyle(
                      fontSize: AppTheme.defaultFontSize,
                      fontWeight: AppTheme.mediumWeight,
                    ),
                  ),
                  subtitle: Text(
                    'Great service! Very professional and punctual.',
                    style: TextStyle(
                      fontSize: AppTheme.captionFontSize,
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppTheme.defaultFontSize,
              color: AppTheme.secondaryTextColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: AppTheme.defaultFontSize,
              fontWeight: AppTheme.boldWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppTheme.successColor;
      case 'blocked':
        return AppTheme.errorColor;
      default:
        return AppTheme.secondaryTextColor;
    }
  }
}
