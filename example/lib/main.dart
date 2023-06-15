import 'package:flutter/material.dart';
import 'package:pro_validator/pro_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  CreditCardValidator get creditCardValidator => const CreditCardValidator(
        error: 'Invalid credit card number',
      );

  MultiValidator get emailValidator => const MultiValidator(
        validators: [
          RequiredValidator(
            error: 'Required field',
          ),
          EmailValidator(
            error: 'Invalid email',
          ),
        ],
      );

  MultiValidator get passwordValidator => const MultiValidator(
        validators: [
          RequiredValidator(
            error: 'Required field',
          ),
          LengthRangeValidator(
            min: 8,
            max: 24,
            error: 'Required from 8 to 24 symbols',
          )
        ],
      );

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
                decoration: const InputDecoration(labelText: 'Password'),
                validator: passwordValidator.call,
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
