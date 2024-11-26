import 'package:emailjs/emailjs.dart' as emailjs;

class SendEmailUtils {
  Future<void> sendEmail({required String sendTo}) async {
    try {
      Map<String, dynamic> templateParams = {
        'name': 'James',
        'notes': 'Check this out!',
        'to_email': sendTo,
        'message': 'Hi hello !',
        'first_name': 'Darshan6069',
        'second_name': 'Flutter',
        'secret_message': 'secret'
      };

      await emailjs.send(
        'service_s60bjnw',
        'template_e6q8nl6',
        templateParams,
        const emailjs.Options(
          publicKey: 'L4BVWfhk0zUuCxAfL',
          privateKey: 'r7BRSlykpz_6sIG4mHClY',
        ),
      );
      print('SUCCESS!');
    } catch (error) {
      print('$error');
    }
  }
}
