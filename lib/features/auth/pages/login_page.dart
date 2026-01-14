import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../main/pages/main_screen.dart'; 
import '../api/auth_api.dart'; // ✅ On utilise uniquement cet import

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController(); 
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // ✅ Appel à l'API externe (l'import AuthApi)
    final response = await AuthApi.login(
      login: _loginController.text.trim(),
      password: _passwordController.text,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (response.success) {
        // Redirection vers l'écran principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()), 
        );
      } else {
        setState(() {
          _errorMessage = response.message ?? "Erreur de connexion";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.wifi_tethering, size: 80, color: AppColors.primary),
                  const SizedBox(height: 16),
                  const Text(
                    'Village Connecté',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  
                  // CHAMP LOGIN
                  TextFormField(
                    controller: _loginController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Identifiant / Login', 
                      prefixIcon: Icon(Icons.person_outline), 
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => 
                      value == null || value.isEmpty ? 'Merci d\'entrer votre identifiant' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  // CHAMP MOT DE PASSE
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: (value) => 
                      value == null || value.isEmpty ? 'Merci d\'entrer votre mot de passe' : null,
                  ),
                  const SizedBox(height: 24),

                  // MESSAGE D'ERREUR
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red.shade800),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // BOUTON CONNEXION
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Se connecter', style: TextStyle(fontSize: 16)),
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