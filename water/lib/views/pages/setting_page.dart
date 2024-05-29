import 'package:flutter/material.dart';
import 'package:water/const/app_colors.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late int dailywaterintake;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Text(
              "Set your Daily Water Intake Goal: ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SizedBox(
              width: 100,
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
                    ))),
                onChanged: (value) {
                  dailywaterintake = int.parse(value);
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.white),
              child: const Text("Enter"),
            ),
          ],
        ),
      ),
    );
  }
}
