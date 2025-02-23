import 'package:flutter/material.dart';
import 'package:login_app/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class RegistroPage extends StatelessWidget {
  RegistroPage({super.key});
  final TextEditingController _nickController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginF_Provider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: DecoratedBox(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 96, 108, 93)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: size.width * 0.80,
              height: size.height * 0.17,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/GOT_Logo.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
              width: size.width * 0.80,
              height: size.height * 0.05,
              alignment: Alignment.center,
            ),
            TextField(
              controller: _nickController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 244, 244),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'ejemplo@gmail.com',
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 244, 244),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 244, 244),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                print('no que no');
                Navigator.pushNamed(context, 'login', arguments: '');
              },
              child: const Text(
                '¿Si tienes cuenta? Inicia sesión',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 244, 244),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 244, 244)),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      // TODO: validar si el login es correcto
                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        // TODO: mostrar error en pantalla
                        print(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
              child: const Text(
                'Registrar',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 96, 108, 93),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
