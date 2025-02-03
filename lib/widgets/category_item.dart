import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final int id; 
  final String title; // Title of the category
  
  final VoidCallback onDelete; // Function to handle delete action
  final VoidCallback onEdit; // Function to handle edit action

  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
   
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.category,
        ),
      ),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit, 
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
