import 'dart:io';

void main() {
  final tracker = InternshipTracker();

  print('=== Internship Application Tracker ===');

  var isRunning = true;

  while (isRunning) {
    showMenu();
    final choice = readText('Choose an option: ');

    switch (choice) {
      case '1':
        tracker.addApplication();
        break;
      case '2':
        tracker.listApplications();
        break;
      case '3':
        tracker.updateStatus();
        break;
      case '4':
        tracker.deleteApplication();
        break;
      case '5':
        isRunning = false;
        break;
      default:
        print('Please choose a number from 1 to 5.');
    }
  }

  print('Good luck with your internship search.');
}

void showMenu() {
  print('');
  print('1. Add application');
  print('2. View applications');
  print('3. Update application status');
  print('4. Delete application');
  print('5. Exit');
}

String readText(String message) {
  while (true) {
    stdout.write(message);
    final input = stdin.readLineSync()?.trim();

    if (input != null && input.isNotEmpty) {
      return input;
    }

    print('Input cannot be empty.');
  }
}

int readApplicationNumber(int maxNumber) {
  while (true) {
    final input = readText('Enter application number: ');
    final number = int.tryParse(input);

    if (number != null && number >= 1 && number <= maxNumber) {
      return number;
    }

    print('Please enter a number between 1 and $maxNumber.');
  }
}

class InternshipApplication {
  InternshipApplication({
    required this.company,
    required this.role,
    required this.status,
  });

  String company;
  String role;
  String status;

  @override
  String toString() {
    return '$company - $role [$status]';
  }
}

class InternshipTracker {
  final List<InternshipApplication> _applications = [];

  void addApplication() {
    final company = readText('Company name: ');
    final role = readText('Role title: ');
    final status = readText('Application status: ');

    _applications.add(
      InternshipApplication(company: company, role: role, status: status),
    );

    print('Application added.');
  }

  void listApplications() {
    if (_applications.isEmpty) {
      print('No applications yet.');
      return;
    }

    print('');
    print('Your applications:');

    for (var index = 0; index < _applications.length; index++) {
      print('${index + 1}. ${_applications[index]}');
    }
  }

  void updateStatus() {
    if (_applications.isEmpty) {
      print('No applications to update.');
      return;
    }

    listApplications();
    final applicationNumber = readApplicationNumber(_applications.length);
    final newStatus = readText('New status: ');

    _applications[applicationNumber - 1].status = newStatus;
    print('Status updated.');
  }

  void deleteApplication() {
    if (_applications.isEmpty) {
      print('No applications to delete.');
      return;
    }

    listApplications();
    final applicationNumber = readApplicationNumber(_applications.length);
    final removedApplication = _applications.removeAt(applicationNumber - 1);

    print('Deleted: $removedApplication');
  }
}
