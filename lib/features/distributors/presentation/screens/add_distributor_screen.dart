import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/cubit/distributor_cubit.dart';

import '../cubit/distributor_state.dart';

class AddDistributorScreen extends StatefulWidget {
  const AddDistributorScreen({super.key});

  @override
  State<AddDistributorScreen> createState() => _AddDistributorScreenState();
}

class _AddDistributorScreenState extends State<AddDistributorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _areaController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DistributorCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add New Distributor',
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    controller: _fullNameController,
                    label: 'Full Name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppTheme.defaultPadding),
                  _buildTextField(
                    controller: _phoneNumberController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppTheme.defaultPadding),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email (Optional)',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: AppTheme.defaultPadding),
                  _buildTextField(
                    controller: _areaController,
                    label: 'Area/Zone',
                    icon: Icons.location_on,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter area/zone';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppTheme.defaultPadding * 2),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: AppTheme.defaultPadding,
                      ),
                    ),
                    child: const Text('Create Account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final distributor = DistributorModel(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        area: _areaController.text,
        joinDate: DateTime.now(),
      );

      context.read<DistributorCubit>().addDistributor(distributor);
    }
  }
}
