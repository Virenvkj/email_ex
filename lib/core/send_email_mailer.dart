import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendEmailMailer {
  Future<void> sendMail({required String sendTo}) async {
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    String username = 'YOUR_SENDER_MAIL';
    String password = 'YOUR_APP_PASSWORD';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(sendTo)
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // close the connection
    await connection.close();
  }
}
