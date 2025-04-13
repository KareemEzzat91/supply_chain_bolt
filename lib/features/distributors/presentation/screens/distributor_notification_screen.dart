import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/cubit/distributor_cubit.dart';

import '../cubit/distributor_state.dart';

class DistributorNotificationScreen extends StatefulWidget {
  final DistributorModel? selectedDistributor;

  const DistributorNotificationScreen({
    super.key,
    this.selectedDistributor,
  });

  @override
  State<DistributorNotificationScreen> createState() =>
      _DistributorNotificationScreenState();
}

class _DistributorNotificationScreenState
    extends State<DistributorNotificationScreen> {
  final _messageController = TextEditingController();
  bool _isBulkNotification = false;
  List<DistributorModel> _selectedDistributors = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DistributorCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Send Notification',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
            ),
          ),
        ),
        body: BlocListener<DistributorCubit, DistributorState>(
          listener: (context, state) {
            if (state is DistributorError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is DistributorLoaded) {
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppTheme.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationType(),
                SizedBox(height: AppTheme.defaultPadding),
                if (_isBulkNotification) _buildDistributorSelector(),
                SizedBox(height: AppTheme.defaultPadding),
                _buildMessageInput(),
                SizedBox(height: AppTheme.defaultPadding * 2),
                _buildSendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationType() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Type',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Single Distributor'),
                    value: false,
                    groupValue: _isBulkNotification,
                    onChanged: (value) {
                      setState(() {
                        _isBulkNotification = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Bulk Notification'),
                    value: true,
                    groupValue: _isBulkNotification,
                    onChanged: (value) {
                      setState(() {
                        _isBulkNotification = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistributorSelector() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Distributors',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            BlocBuilder<DistributorCubit, DistributorState>(
              builder: (context, state) {
                if (state is DistributorLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is DistributorError) {
                  return Center(child: Text(state.message));
                }
                if (state is DistributorLoaded) {
                  return Column(
                    children: state.distributors.map((distributor) {
                      return CheckboxListTile(
                        title: Text(distributor.fullName),
                        subtitle: Text(distributor.area),
                        value: _selectedDistributors.contains(distributor),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              _selectedDistributors.add(distributor);
                            } else {
                              _selectedDistributors.remove(distributor);
                            }
                          });
                        },
                      );
                    }).toList(),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Message',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your message here...',
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(AppTheme.defaultBorderRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return ElevatedButton(
      onPressed: _sendNotification,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: AppTheme.defaultPadding,
        ),
        minimumSize: const Size(double.infinity, 0),
      ),
      child: const Text('Send Notification'),
    );
  }

  void _sendNotification() {
    if (_messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a message')),
      );
      return;
    }

    if (_isBulkNotification && _selectedDistributors.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one distributor')),
      );
      return;
    }

    final message = _messageController.text;
    if (_isBulkNotification) {
      for (final distributor in _selectedDistributors) {
        context.read<DistributorCubit>().sendNotification(
          distributor.id,
          message,
        );
      }
    } else if (widget.selectedDistributor != null) {
      context.read<DistributorCubit>().sendNotification(
        widget.selectedDistributor!.id,
        message,
      );
    }
  }
}
