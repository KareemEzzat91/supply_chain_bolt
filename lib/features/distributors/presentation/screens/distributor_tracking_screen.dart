import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/cubit/distributor_cubit.dart';

import '../cubit/distributor_state.dart';

class DistributorTrackingScreen extends StatefulWidget {
  const DistributorTrackingScreen({super.key});

  @override
  State<DistributorTrackingScreen> createState() =>
      _DistributorTrackingScreenState();
}

class _DistributorTrackingScreenState extends State<DistributorTrackingScreen> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  String _selectedFilter = 'all';
  String _selectedArea = 'all';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DistributorCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Track Distributors',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
            ),
          ),
        ),
        body: Column(
          children: [
            _buildFilters(),
            Expanded(
              child: BlocBuilder<DistributorCubit, DistributorState>(
                builder: (context, state) {
                  if (state is DistributorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is DistributorError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is DistributorLoaded) {
                    _updateMarkers(state.distributors);
                    return GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(0, 0), // TODO: Set initial position
                        zoom: 12,
                      ),
                      markers: _markers,
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedFilter,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(AppTheme.defaultBorderRadius),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All')),
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'blocked', child: Text('Blocked')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
          ),
          SizedBox(width: AppTheme.defaultPadding),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedArea,
              decoration: InputDecoration(
                labelText: 'Area',
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(AppTheme.defaultBorderRadius),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Areas')),
                DropdownMenuItem(value: 'north', child: Text('North Zone')),
                DropdownMenuItem(value: 'south', child: Text('South Zone')),
                DropdownMenuItem(value: 'east', child: Text('East Zone')),
                DropdownMenuItem(value: 'west', child: Text('West Zone')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedArea = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateMarkers(List<DistributorModel> distributors) {
    _markers.clear();
    for (final distributor in distributors) {
      if (_shouldShowDistributor(distributor)) {
        _markers.add(
          Marker(
            markerId: MarkerId(distributor.id),
            position: LatLng(
              distributor.lastLocation?['latitude'] ?? 0,
              distributor.lastLocation?['longitude'] ?? 0,
            ),
            infoWindow: InfoWindow(
              title: distributor.fullName,
              snippet: 'Status: ${distributor.status}',
            ),
          ),
        );
      }
    }
  }

  bool _shouldShowDistributor(DistributorModel distributor) {
    if (_selectedFilter != 'all' &&
        distributor.status.toLowerCase() != _selectedFilter) {
      return false;
    }
    if (_selectedArea != 'all' &&
        distributor.area.toLowerCase() != _selectedArea) {
      return false;
    }
    return true;
  }
}
