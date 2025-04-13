import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/cubit/distributor_cubit.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_details_screen.dart';

import '../cubit/distributor_state.dart';

class DistributorListScreen extends StatelessWidget {
  const DistributorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DistributorCubit()..loadDistributors(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Distributors',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Navigate to add distributor screen
              },
            ),
          ],
        ),
        body: BlocBuilder<DistributorCubit, DistributorState>(
          builder: (context, state) {
            if (state is DistributorLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DistributorError) {
              return Center(child: Text(state.message));
            }
            if (state is DistributorLoaded) {
              return _buildDistributorList(context, state.distributors);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildDistributorList(
      BuildContext context, List<DistributorModel> distributors) {
    return ListView.builder(
      padding: EdgeInsets.all(AppTheme.defaultPadding),
      itemCount: distributors.length,
      itemBuilder: (context, index) {
        final distributor = distributors[index];
        return Card(
          margin: EdgeInsets.only(bottom: AppTheme.defaultPadding),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(distributor.status),
              child: Text(
                distributor.fullName[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              distributor.fullName,
              style: TextStyle(
                fontSize: AppTheme.defaultFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Area: ${distributor.area}',
                  style: TextStyle(
                    fontSize: AppTheme.captionFontSize,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
                Text(
                  'Orders: ${distributor.completedOrders}',
                  style: TextStyle(
                    fontSize: AppTheme.captionFontSize,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: AppTheme.warningColor,
                  size: AppTheme.defaultIconSize,
                ),
                Text(
                  distributor.rating.toString(),
                  style: TextStyle(
                    fontSize: AppTheme.captionFontSize,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DistributorDetailsScreen(distributor: distributor),
                ),
              );
            },
          ),
        );
      },
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
