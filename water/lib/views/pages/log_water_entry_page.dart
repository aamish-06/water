import 'package:flutter/material.dart';
import 'package:water/const/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogWaterEntry extends StatefulWidget {
  const LogWaterEntry({super.key});

  @override
  State<LogWaterEntry> createState() => _LogWaterEntryState();
}

class _LogWaterEntryState extends State<LogWaterEntry> {
  late int intake;
  bool isLoading = false;
  final String apiUrl = 'http://localhost:3000/intake';

  Future<void> logWaterIntake() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'amount': intake,
          'time': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 404) {
        Navigator.pop(context);
      } else {
        // Handle error
        print(
            'Failed to log water intake. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      // Handle network error
      print('Error logging water intake: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter the amount of water you drank today: "),
            SizedBox(
              width: 70,
              height: 30,
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: AppColors.black,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black,
                    ),
                  ),
                ),
                onChanged: (value) {
                  intake = int.parse(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: logWaterIntake,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                    ),
                    child: const Text("Enter"),
                  ),
          ],
        ),
      ),
    );
  }
}
