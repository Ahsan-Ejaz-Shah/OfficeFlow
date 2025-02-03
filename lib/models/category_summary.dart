class CategorySummary {
  final int categoryId;
  final String categoryName;
  final double amount;
  final double percentage;

  CategorySummary({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.percentage,
  });

  // Make sure to handle any missing data gracefully
  factory CategorySummary.fromJson(Map<String, dynamic> json) {
    return CategorySummary(
      categoryId: json['category_id'],
      categoryName:
          json['category_name'] ?? 'Unknown', // Default value if key is missing
      amount: (json['amount'] ?? 0.0)
          .toDouble(), // Default value if key is missing or null
      percentage: (json['percentage'] ?? 0.0)
          .toDouble(), // Default value if key is missing or null
    );
  }
}
