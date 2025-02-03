class Expense {
  final int id;
  final String title;
  final String dateTime;
  final int amount;

  Expense({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.amount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      dateTime: json['date_time'],
      amount: json['amount'],
    );
  }
}
