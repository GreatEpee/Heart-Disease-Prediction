import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  final Map<String, TextEditingController> controllers = {
    "age": TextEditingController(),
    "sex": TextEditingController(),
    "cp": TextEditingController(),
    "trestbps": TextEditingController(),
    "chol": TextEditingController(),
    "fbs": TextEditingController(),
    "restecg": TextEditingController(),
    "thalach": TextEditingController(),
    "exang": TextEditingController(),
    "oldpeak": TextEditingController(),
    "slope": TextEditingController(),
    "ca": TextEditingController(),
    "thal": TextEditingController(),
  };

  final Map<String, dynamic> lowRiskInput = {
    "age": 45,
    "sex": 0,
    "cp": 0,
    "trestbps": 120,
    "chol": 200,
    "fbs": 0,
    "restecg": 0,
    "thalach": 170,
    "exang": 0,
    "oldpeak": 0.5,
    "slope": 2,
    "ca": 0,
    "thal": 3
  };

  final Map<String, dynamic> highRiskInput = {
    "age": 68,
    "sex": 1,
    "cp": 3,
    "trestbps": 160,
    "chol": 280,
    "fbs": 1,
    "restecg": 1,
    "thalach": 110,
    "exang": 1,
    "oldpeak": 3.5,
    "slope": 0,
    "ca": 2,
    "thal": 2
  };

  Widget buildNumberField(String label, String key, {bool isDouble = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controllers[key],
        style: TextStyle(color: Colors.white, fontSize: 18.sp),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withAlpha(50)),
            borderRadius: BorderRadius.circular(15.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.r),
          ),
          filled: true,
          fillColor: Colors.white.withAlpha(25),
        ),
        keyboardType: TextInputType.numberWithOptions(
          decimal: isDouble,
          signed: false,
        ),
        validator: (val) {
          if (val == null || val.isEmpty) return "Please enter $label";
          if (!isDouble && int.tryParse(val) == null) return "Enter valid number";
          if (isDouble && double.tryParse(val) == null) return "Enter valid number";
          return null;
        },
      ),
    );
  }
  void fillInputs(Map<String, dynamic> data) {
    data.forEach((key, value) {
      controllers[key]!.text = value.toString();
    });
  }
  Map<String, dynamic> getInputData() {
    final Map<String, dynamic> inputData = {};
    controllers.forEach((key, controller) {
      if (key == "oldpeak") {
        inputData[key] = double.tryParse(controller.text) ?? 0.0;
      } else {
        inputData[key] = int.tryParse(controller.text) ?? 0;
      }
    });
    return inputData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Heart Disease Prediction",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20.r),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A1D37), Color(0xFF1E3A6E)],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Enter Your Details',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                buildNumberField("Age", "age"),
                buildNumberField("Sex (0=F, 1=M)", "sex"),
                buildNumberField("Chest Pain (cp)", "cp"),
                buildNumberField("Resting BP (trestbps)", "trestbps"),
                buildNumberField("Cholesterol (chol)", "chol"),
                buildNumberField("Fasting Blood Sugar >120 mg/dl (fbs)", "fbs"),
                buildNumberField("Resting ECG (restecg)", "restecg"),
                buildNumberField("Max Heart Rate (thalach)", "thalach"),
                buildNumberField("Exercise Induced Angina (exang)", "exang"),
                buildNumberField("ST Depression (oldpeak)", "oldpeak", isDouble: true),
                buildNumberField("Slope of ST (slope)", "slope"),
                buildNumberField("Major Vessels (ca)", "ca"),
                buildNumberField("Thalassemia (thal)", "thal"),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => fillInputs(lowRiskInput),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text("Low Risk"),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => fillInputs(highRiskInput),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: const Text("High Risk"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final result = await apiService.predict(getInputData());
                      Get.to(() => ResultScreen(result: result));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4757),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(75),
                          blurRadius: 20.r,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      'Predict',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
