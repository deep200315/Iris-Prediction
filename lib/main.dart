// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iris Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  TextEditingController sepalLengthController = TextEditingController();
  TextEditingController sepalWidthController = TextEditingController();
  TextEditingController petalLengthController = TextEditingController();
  TextEditingController petalWidthController = TextEditingController();

  String predictionResult = '';

  Future<void> predict() async {
    const url = 'http://127.0.0.1:5000/predict';

    final Map<String, dynamic> data = {
      'sepal length (cm)': double.parse(sepalLengthController.text),
      'sepal width (cm)': double.parse(sepalWidthController.text),
      'petal length (cm)': double.parse(petalLengthController.text),
      'petal width (cm)': double.parse(petalWidthController.text),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      setState(() {
        predictionResult = 'Prediction: ${result['prediction']}';
      });

      _showResultPopup(context);
    } else {
      setState(() {
        predictionResult = 'Error: Unable to make a prediction';
      });
    }
  }

  // Function to show the result in a popup
  void _showResultPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.fastEaseInToSlowEaseOut,
            reverseCurve: Curves.fastEaseInToSlowEaseOut,
          ),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _buildPopupContent(context),
          ),
        );
      },
    );
  }

  // Function to build the content of the popup
  Widget _buildPopupContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Color.fromARGB(255, 0, 1, 2)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/celebrations.svg',
            height: 100,
          ),
          const SizedBox(height: 16),
          Text(
            predictionResult,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Iris Prediction'),
                centerTitle: true,
                floating: true, // Make the app bar float
                elevation: 0, // No shadow
                backgroundColor: Colors.transparent,
                expandedHeight: 0, // Adjust the height as needed
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(), // Empty container to allow overlay
                ),
              ),
              SliverToBoxAdapter(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 0), // Adjust the height as needed
                          Image.asset(
                            'assets/iris.png',
                            height: 200,
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: sepalLengthController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Sepal Length (cm)',
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              labelStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            ),
                          
                          const SizedBox(height: 10),
                          TextField(
                            controller: sepalWidthController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Sepal Width (cm)',
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              labelStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: petalLengthController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Petal Length (cm)',
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              labelStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: petalWidthController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Petal Width (cm)',
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              labelStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: predict,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: const Text(
                              'Predict',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // ... (previous Text widget code)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
