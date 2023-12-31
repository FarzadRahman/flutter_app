import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid=Uuid();
final dateFormatter=DateFormat.yMd();

enum Category {
  food, travel, leisure, work
}

const categoryIcons={
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work
};
class Expense{
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category

  }): id=uuid.v4();
  final String id;
  late final String title;
  late final double amount;
  final DateTime date;
  final Category category;

  get formattedDate{
    return dateFormatter.format(date);
  }


}