import 'package:flutter/material.dart';

// Build questions based on disease
Widget buildQuestions(String disease, Map<String, String> answers, Function(String, String) onChanged) {
  List<Widget> questions = [];

  switch (disease) {
    case 'Eczema':
      questions = [
        buildQuestion('Do you experience dry, itchy patches of skin?', disease, answers, onChanged),
        buildQuestion('Is your skin red, inflamed, or cracked?', disease, answers, onChanged),
        buildQuestion('Do your symptoms worsen in cold or dry weather?', disease, answers, onChanged),
      ];
      break;
    case 'Warts':
      questions = [
        buildQuestion('Do you have small, grainy bumps on your skin?', disease, answers, onChanged),
        buildQuestion('Are the bumps rough to the touch and skin-colored, brown, or gray?', disease, answers, onChanged),
        buildQuestion('Are the warts located on your hands, feet, or knees?', disease, answers, onChanged),
      ];
      break;
    case 'Melanoma':
      questions = [
        buildQuestion('Have you noticed any new or changing moles on your skin?', disease, answers, onChanged),
        buildQuestion('Is the mole asymmetrical or has it changed in color or size recently?', disease, answers, onChanged),
        buildQuestion('Does the mole have irregular borders or bleed?', disease, answers, onChanged),
      ];
      break;
    case 'Atopic Dermatitis':
      questions = [
        buildQuestion('Do you frequently experience itchy, inflamed skin?', disease, answers, onChanged),
        buildQuestion('Does your skin develop red or brownish-gray patches?', disease, answers, onChanged),
        buildQuestion('Do you have thickened, cracked, or scaly skin, particularly after scratching?', disease, answers, onChanged),
      ];
      break;
    case 'Basal Cell Carcinoma':
      questions = [
        buildQuestion('Have you noticed a pearly or waxy bump on your skin?', disease, answers, onChanged),
        buildQuestion('Is the bump slow-growing and painless but bleeds easily?', disease, answers, onChanged),
        buildQuestion('Does the bump have visible blood vessels or a scar-like appearance?', disease, answers, onChanged),
      ];
      break;
    case 'Melanocytic':
      questions = [
        buildQuestion('Do you have a brown, tan, or black spot on your skin that’s smooth and round?', disease, answers, onChanged),
        buildQuestion('Is the spot or mole smaller than 6 millimeters in diameter?', disease, answers, onChanged),
        buildQuestion('Has the mole remained unchanged over time?', disease, answers, onChanged),
      ];
      break;
    case 'Benign':
      questions = [
        buildQuestion('Do you have a round, raised bump that feels soft or rubbery?', disease, answers, onChanged),
        buildQuestion('Is the bump flesh-colored or brownish, without any signs of inflammation?', disease, answers, onChanged),
        buildQuestion('Has the bump been on your skin for a long time without any changes?', disease, answers, onChanged),
      ];
      break;
    case 'Psoriasis':
      questions = [
        buildQuestion('Do you have thick, red patches of skin covered with silvery scales?', disease, answers, onChanged),
        buildQuestion('Are the patches located on your elbows, knees, or scalp?', disease, answers, onChanged),
        buildQuestion('Do you experience itching, burning, or soreness on the affected areas?', disease, answers, onChanged),
      ];
      break;
    case 'Seborrheic':
      questions = [
        buildQuestion('Do you have red, oily patches of skin with flaky scales?', disease, answers, onChanged),
        buildQuestion('Is the affected area on your scalp, eyebrows, or face?', disease, answers, onChanged),
        buildQuestion('Do you experience dandruff or greasy scales on your scalp?', disease, answers, onChanged),
      ];
      break;
    case 'Tinea (Ringworm)':
      questions = [
        buildQuestion('Do you have a red, circular rash with a clearer center?', disease, answers, onChanged),
        buildQuestion('Is the affected area itchy or scaly?', disease, answers, onChanged),
        buildQuestion('Does the rash appear on your feet, groin, or other areas?', disease, answers, onChanged),
      ];
      break;
    case 'Acne':
      questions = [
        buildQuestion('Do you have red, inflamed pimples on your face, chest, or back?', disease, answers, onChanged),
        buildQuestion('Are the pimples filled with pus or accompanied by blackheads and whiteheads?', disease, answers, onChanged),
        buildQuestion('Is the affected area oily or greasy?', disease, answers, onChanged),
      ];
      break;
    case 'Vitiligo':
      questions = [
        buildQuestion('Have you noticed patches of skin that have lost their pigmentation?', disease, answers, onChanged),
        buildQuestion('Are the patches more prominent on sun-exposed areas like your face, hands, or feet?', disease, answers, onChanged),
        buildQuestion('Do you have a family history of autoimmune diseases?', disease, answers, onChanged),
      ];
      break;
    case 'Chickenpox':
      questions = [
        buildQuestion('Do you have an itchy, blister-like rash that started on your face or chest?', disease, answers, onChanged),
        buildQuestion('Are the blisters filled with fluid and do they scab over after a few days?', disease, answers, onChanged),
        buildQuestion('Do you have fever, fatigue, or body aches along with the rash?', disease, answers, onChanged),
      ];
      break;
    default:
      questions = [const Text('No questions available for this disease.')];
      break;
  }

  return Column(children: questions);
}

// Helper method to build a single question
Widget buildQuestion(String questionText, String disease, Map<String, String> answers, Function(String, String) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        questionText,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Radio<String>(
            value: 'yes',
            groupValue: answers[disease],
            onChanged: (value) {
              onChanged(disease, value!);
            },
          ),
          const Text('Yes'),
          Radio<String>(
            value: 'no',
            groupValue: answers[disease],
            onChanged: (value) {
              onChanged(disease, value!);
            },
          ),
          const Text('No'),
        ],
      ),
    ],
  );
}
