// import 'package:flutter/material.dart';
// import 'package:shriwin/widgets/build_questions.dart';

// class SymptomCheck extends StatefulWidget {
//   final List<String> diseases;

//   const SymptomCheck({super.key, required this.diseases});

//   @override
//   State<SymptomCheck> createState() => _SymptomCheckState();
// }

// class _SymptomCheckState extends State<SymptomCheck> {
//   final Map<String, String> _answers = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[150],
//       appBar: AppBar(
//         backgroundColor: Colors.blue[100],
//         title: const Text('Symptom Check'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'Answer the following questions for ${widget.diseases[0]}:',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             buildQuestions(widget.diseases[0], _answers, (String disease, String value) {
//               setState(() {
//                 _answers[disease] = value;
//               });
//             }),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 final result = _getFinalPrediction();
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text('Final Prediction'),
//                     content: Text(result),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text('OK'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: const Text('Get Final Prediction'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getFinalPrediction() {
//     if (_answers.containsValue('yes')) {
//       return 'Based on your symptoms, the disease is likely ${widget.diseases[0]}.';
//     } else {
//       return 'It is difficult to determine a conclusive disease.';
//     }
//   }
// }









import 'package:flutter/material.dart';
import 'package:shriwin/widgets/build_questions.dart';

class SymptomCheck extends StatefulWidget {
  final List<String> diseases;

  const SymptomCheck({super.key, required this.diseases});

  @override
  State<SymptomCheck> createState() => _SymptomCheckState();
}

class _SymptomCheckState extends State<SymptomCheck> {
  final Map<String, Map<String, String>> _answers = {}; // Store answers for each disease

  @override
  void initState() {
    super.initState();
    // Initialize the answers map for each disease
    for (String disease in widget.diseases) {
      _answers[disease] = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text('Symptom Check'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Answer the following questions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.diseases.length,
                itemBuilder: (context, index) {
                  String disease = widget.diseases[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'For $disease:',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      buildQuestions(disease, _answers[disease]!, (String disease, String value) {
                        setState(() {
                          _answers[disease]![disease] = value;
                        });
                      }),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final result = _getFinalPrediction();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Final Prediction'),
                    content: Text(result),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Get Final Prediction'),
            ),
          ],
        ),
      ),
    );
  }

  // Calculate the final prediction based on the most "yes" answers
  String _getFinalPrediction() {
    Map<String, int> yesCount = {};

    // Count the number of "Yes" responses for each disease
    for (String disease in widget.diseases) {
      yesCount[disease] = _answers[disease]!.values.where((answer) => answer == 'yes').length;
    }

    // Find the disease with the maximum number of "Yes" answers
    String predictedDisease = '';
    int maxYesCount = 0;
    yesCount.forEach((disease, count) {
      if (count > maxYesCount) {
        maxYesCount = count;
        predictedDisease = disease;
      }
    });

    if (maxYesCount > 0) {
      return 'Based on your symptoms, the disease is likely $predictedDisease.';
    } else {
      return 'It is difficult to determine a conclusive disease.';
    }
  }
}
