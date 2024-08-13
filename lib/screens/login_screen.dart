import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          "MCQUIZ ADMIN",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text("Login",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) =>
                        loginController.emailController.value = value,
                    keyboardType: TextInputType.emailAddress,
                    enabled: true,
                    decoration: const InputDecoration(
                      hintText: "Enter Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return TextFormField(
                      onChanged: (value) =>
                          loginController.passwordController.value = value,
                      obscureText: !loginController.visible.value,
                      enabled: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: loginController.visible.value
                            ? IconButton(
                                onPressed: () {
                                  loginController.visible.value = false;
                                },
                                icon: const Icon(Icons.visibility))
                            : IconButton(
                                onPressed: () {
                                  loginController.visible.value = true;
                                },
                                icon: const Icon(Icons.visibility_off)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(() => ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    // }
                    loginController.isLoading.value
                        ? null
                        : () {
                      loginController.login();
                    };
                  },
                  child: loginController.isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: Get.width * 0.4,
                          child: const Center(child: Text("Login"))),
                )),
          ],
        ),
      ),
    );
  }
}
