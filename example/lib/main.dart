import 'package:flutter/material.dart';
import 'package:pro_validator/pro_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: const MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  // Compose with `&`: only RequiredValidator fails on empty input.
  ValidatorGroup<String> get emailValidator =>
      const RequiredValidator(error: 'Required field') &
      const EmailValidator(error: 'Invalid email');

  ValidatorGroup<String> get passwordValidator =>
      const RequiredValidator(error: 'Required field') &
      const LengthRangeValidator(
        min: 8,
        max: 24,
        error: 'Required from 8 to 24 symbols',
      );

  CreditCardValidator get creditCardValidator =>
      const CreditCardValidator(error: 'Invalid credit card number');

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: emailValidator.call,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: passwordValidator.call,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Confirm password'),
            obscureText: true,
            // MatchValidator compares by value (`==`), so two equal strings
            // typed into different fields correctly match.
            validator: (value) =>
                const MatchValidator(error: 'Passwords do not match')(
                  value,
                  _passwordController.text,
                ),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Credit card'),
            validator: creditCardValidator.call,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final result = _formKey.currentState!.validate();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: result
                      ? const Text('Processing Data')
                      : const Text('Invalid data'),
                ),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    ),
  );
}
