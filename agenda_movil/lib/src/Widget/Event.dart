// ignore_for_file: file_names

class Event{

  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;

  const Event({
    required this.title, 
    required this.description, 
    required this.from, 
    required this.to, 
    required this.isAllDay, 
    
  });

}