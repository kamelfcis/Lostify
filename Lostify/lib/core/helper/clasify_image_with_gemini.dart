import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

Future<String> classifyImageWithGemini({
  required File selectedImage,
  required List<String> categoryNames,
  required String apiKey,
}) async {
  final model = GenerativeModel(
    model: 'gemini-2.5-flash', // ← استخدم ده
    apiKey: apiKey,
  );

  final prompt = '''
This image belongs to which of the following categories?
${categoryNames.join(', ')}      
Answer with the category name only without any additions.
If the image doesn't belong to any category, answer with "Unknown".
''';

  final content = [
    Content.multi([
      TextPart(prompt),
      DataPart('image/jpeg', await selectedImage.readAsBytes()),
    ]),
  ];

  final response = await model.generateContent(content);
  return response.candidates.first.text?.trim() ?? 'Unknown';
}
