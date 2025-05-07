import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supply_chain_bolt/core/routing/routes.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../logic/distributor_auth_cubit.dart';
import '../../logic/distributor_auth_state.dart';

class DistributorSignupScreen extends StatelessWidget {
  DistributorSignupScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<DistributorAuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Distributor Sign Up'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Sign up to start delivering orders',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<DistributorAuthCubit, DistributorAuthState>(
                    builder: (context, state) {
                      if (state is DistributorAuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is DistributorAuthError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message.toString())));
                        });

                        return ElevatedButton(
                          onPressed: () => context
                              .read<DistributorAuthCubit>()
                              .distSignUp(
                                  nameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  "Distributor"),
                          child: const Text('Sign Up'),
                        );
                      }
                      if (state is DistributorAuthSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.main,
                            (Route<dynamic> route) => false,
                            arguments: {'isManager': false},
                          );
                        });
                      }
                      return ElevatedButton(
                        onPressed: () => context
                            .read<DistributorAuthCubit>()
                            .distSignUp(
                                nameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                "Distributor"),
                        child: const Text('Sign Up'),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Already have an account? Sign in'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
