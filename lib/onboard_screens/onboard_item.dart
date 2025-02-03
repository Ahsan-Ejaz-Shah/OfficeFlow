import 'package:officeflow/onboard_screens/onboard_model.dart';

class OnboardItem {
  List<OnboardModel> items = [
    OnboardModel(
        imagePath: 'assets/images/finance-one.png',
        title: 'Track Your Expenses, Effortlessly!',
        description:
            'Stay organized, gain insights, and manage your finances with ease.'),
    OnboardModel(
        imagePath: 'assets/images/finance-two.png',
        title: 'Add Expenses, \nQuickly!',
        description:
            'Log expenses in seconds with simple forms and smart categories.'),
    OnboardModel(
        imagePath: 'assets/images/finance-three.png',
        title: 'Gain Insights Into Your \nSpending!',
        description:
            'Log expenses in seconds with simple forms and smart categories.'),
    OnboardModel(
        imagePath: 'assets/images/finance-four.png',
        title: 'Welcome to OfficeFlow',
        description:
            'Your all-in-one solution for \nmanaging office tasks effortlessly.'),
  ];
}
