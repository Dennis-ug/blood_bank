import 'package:flutter/material.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff2D070A).withOpacity(0.4),
                blurRadius: 19,
              ),
            ],
          ),
          child: Column(
            children: [
              TextFormField(
                // controller: bNo,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Batch No'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
