import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? taskToEdit;

  const AddTaskScreen({super.key, this.taskToEdit});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late String _selectedPriority;

  // Naye variables Category aur Date ke liye
  late String _selectedCategory;
  DateTime? _selectedDate;

  final List<String> _priorities = ['High', 'Medium', 'Low'];
  final List<String> _categories = ['General', 'Work', 'Personal', 'Study'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.taskToEdit?.title ?? '');
    _descController = TextEditingController(text: widget.taskToEdit?.description ?? '');

    _selectedPriority = widget.taskToEdit?.priority ?? 'Low';
    // Agar purani list mein value na ho to default set karo
    if (!_priorities.contains(_selectedPriority)) _selectedPriority = 'Low';

    _selectedCategory = widget.taskToEdit?.category ?? 'General';
    if (!_categories.contains(_selectedCategory)) _selectedCategory = 'General';

    _selectedDate = widget.taskToEdit?.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // Date select karne ka function
  Future<void> _pickDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Helper function date format karne ke liye
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final desc = _descController.text.trim();

      if (widget.taskToEdit != null) {
        // --- EDIT MODE (Ab 6 arguments pass ho rahe hain) ---
        context.read<TaskProvider>().updateTask(
          widget.taskToEdit!,
          title,
          desc,
          _selectedPriority,
          _selectedCategory,
          _selectedDate,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task Updated Successfully')),
        );
      } else {
        // --- ADD MODE (Ab 5 arguments pass ho rahe hain) ---
        context.read<TaskProvider>().addTask(
            title,
            desc,
            _selectedPriority,
            _selectedCategory,
            _selectedDate
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task Added Successfully')),
        );
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.taskToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Task" : "Add New Task"),
        elevation: 0,
        backgroundColor: Colors.transparent, // Ab ye theme ke hisaab se khud color change karega
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.task_alt),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? "Please enter a title" : null,
              ),
              const SizedBox(height: 16),

              // Priority aur Category ko aamne-saamne (Row) mein rakha hai
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPriority,
                      decoration: InputDecoration(
                        labelText: "Priority",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.flag_outlined),
                      ),
                      items: _priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                      onChanged: (val) => setState(() => _selectedPriority = val!),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: // Category Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.category_outlined),
                      ),
                      items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (val) => setState(() => _selectedCategory = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Date Picker UI
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: Text(_selectedDate == null
                    ? 'Select Due Date (Optional)'
                    : 'Due Date: ${_formatDate(_selectedDate!)}'),
                trailing: _selectedDate != null
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () => setState(() => _selectedDate = null),
                )
                    : null,
                onTap: _pickDueDate,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Description (Optional)",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Icon(Icons.description),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: isEdit ? Colors.orange : Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isEdit ? "Update Task" : "Save Task",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}