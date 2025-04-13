import 'package:flutter/material.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports',
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
            Text(
              'Available Reports',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            _buildReportCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppTheme.defaultPadding,
      crossAxisSpacing: AppTheme.defaultPadding,
      children: [
        _buildReportCard(
          'Sales Report',
          Icons.attach_money,
          AppTheme.primaryBlue,
          'View sales analytics and trends',
        ),
        _buildReportCard(
          'Inventory Report',
          Icons.inventory,
          AppTheme.successColor,
          'Track stock levels and movements',
        ),
        _buildReportCard(
          'Distributor Report',
          Icons.people,
          AppTheme.secondaryBlue,
          'Monitor distributor performance',
        ),
        _buildReportCard(
          'Order Report',
          Icons.shopping_cart,
          AppTheme.warningColor,
          'Analyze order patterns and status',
        ),
      ],
    );
  }

  Widget _buildReportCard(
    String title,
    IconData icon,
    Color color,
    String description,
  ) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: AppTheme.defaultPadding),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppTheme.defaultFontSize,
                  fontWeight: AppTheme.boldWeight,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppTheme.defaultPadding / 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: AppTheme.captionFontSize,
                  color: AppTheme.secondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
