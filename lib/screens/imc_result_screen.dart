import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_styles.dart';

class ImcResultScreen extends StatelessWidget {
  final double height;
  final int weight;
  const ImcResultScreen({
    super.key,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: toolbarResult(),
      body: bodyResult(context),
    );
  }

  Padding bodyResult(BuildContext context) {
    double fixedHeight = height / 100; // Convert cm to meters
    double imcResult = weight / (fixedHeight * fixedHeight);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tu resultado",
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getTextByImc(imcResult),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: getColorByImc(imcResult),
                      ),
                    ),
                    Text(
                      imcResult.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 76,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getDescriptionByImc(imcResult),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
              ),
              child: Text("Finalizar", style: TextStyles.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text("IMC Result"),
      foregroundColor: Colors.white,
    );
  }

  Color getColorByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => Colors.blue, //Imc bajo
      < 24.9 => Colors.green, //Imc normal
      < 29.9 => Colors.yellow, //Imc sobrepeso
      < 34.9 => Colors.orange, //Imc obesidad grado 1
      < 39.9 => Colors.red, //Imc obesidad grado 2
      _ => Colors.purple, //Imc obesidad grado 3
    };
  }

  String getTextByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => "Bajo peso",
      < 24.9 => "Peso normal",
      < 29.9 => "Sobrepeso",
      < 34.9 => "Obesidad grado 1",
      < 39.9 => "Obesidad grado 2",
      _ => "Obesidad grado 3",
    };
  }

  String getDescriptionByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => "Tu IMC indica que tienes un peso inferior al normal.",
      < 24.9 => "Tu IMC indica que tienes un peso normal.",
      < 29.9 => "Tu IMC indica que tienes sobrepeso.",
      < 34.9 => "Tu IMC indica obesidad grado 1.",
      < 39.9 => "Tu IMC indica obesidad grado 2.",
      _ => "Tu IMC indica obesidad grado 3.",
    };
  }
}
