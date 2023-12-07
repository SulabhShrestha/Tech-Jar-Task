import 'package:riverpod/riverpod.dart';

final userDataProvider = Provider<Map<String, dynamic>>((ref) {
  return Map<String, dynamic>.from({
    'name': 'Tech Jar',
    'email': 'TechyTech@it.com',
    'uid': "1377x.",
  });
});
