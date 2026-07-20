import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_strings.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';

import '../admin/dashboard/dashboard_screen.dart';
import '../customer/home/home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController employeeIdController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isOwner = true;
  bool hidePassword = true;

  @override
  void dispose() {
    employeeIdController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();

    bool success;

    if (isOwner) {
      success = await auth.adminLogin(
        employeeId: employeeIdController.text.trim(),
        password: passwordController.text.trim(),
      );
    } else {
      success = await auth.customerLogin(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),
        ),
      );

      if (isOwner) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Credentials"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  const Icon(
                    Icons.shopping_cart_rounded,
                    size: 90,
                    color: Colors.deepOrange,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Cartly",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Smart Retail Intelligence",
                  ),

                  const SizedBox(height: 40),

                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                        value: true,
                        label: Text("Owner"),
                      ),
                      ButtonSegment(
                        value: false,
                        label: Text("Customer"),
                      ),
                    ],
                    selected: {isOwner},
                    onSelectionChanged: (value) {
                      setState(() {
                        isOwner = value.first;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  if (isOwner)
                    CustomTextField(
                      controller: employeeIdController,
                      hintText: AppStrings.employeeId,
                      prefixIcon: Icons.badge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.enterEmployeeId;
                        }
                        return null;
                      },
                    ),

                  if (!isOwner)
                    CustomTextField(
                      controller: emailController,
                      hintText: AppStrings.email,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.enterEmail;
                        }
                        return null;
                      },
                    ),

                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: passwordController,
                    hintText: AppStrings.password,
                    prefixIcon: Icons.lock,
                    obscureText: hidePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterPassword;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  CustomButton(
                    text: AppStrings.loginButton,
                    isLoading: auth.isLoading,
                    onPressed: login,
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Create New Account"),
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