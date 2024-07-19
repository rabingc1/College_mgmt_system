import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late final ValueNotifier<List<dynamic>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]);
    _loadEvents();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void _loadEvents() {
    FirebaseFirestore.instance.collection('events').snapshots().listen((snapshot) {
      final events = snapshot.docs.map((doc) => {
        'id': doc.id,
        'title': doc['title'],
        'description': doc['description'],
        'date': DateTime.parse(doc['date']),
        'location': doc['location'],
      }).toList();

      // Auto-delete past events
      final now = DateTime.now();
      for (var event in events) {
        if (event['date'].isBefore(now)) {
          FirebaseFirestore.instance.collection('events').doc(event['id']).delete();
        }
      }

      setState(() {
        _selectedEvents.value = events;
      });
    });
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _selectedEvents.value.where((event) => isSameDay(event['date'], day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar Event")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 32,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${events.length}',
                          style: TextStyle().copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<dynamic>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  itemCount: _getEventsForDay(_selectedDay!).length,
                  itemBuilder: (context, index) {
                    final event = _getEventsForDay(_selectedDay!)[index];
                    return Card(
                      color: Colors.blueAccent.shade100,
                      elevation: 10,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(event['title']),
                        subtitle: Text('${event['description']} at ${event['location']}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
