import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    String userMessage = _controller.text;
    setState(() {
      _messages.add({'user': userMessage});
      _messages.add({'bot': _generateResponse(userMessage)});
    });

    _controller.clear();
  }

  String _generateResponse(String message) {
    message = message.toLowerCase();

    if (message.contains('hello') || message.contains('hi')) {
      return 'Hello! How can I help you today?';
    } else if (message.contains('how are you')) {
      return 'I am just a bot, but I am here to help you!';
    } else if (message.contains('your name')) {
      return 'I am ChatBot!';
    } else if (message.contains('time')) {
      return 'I do not have the ability to tell time right now.';
    } else if (message.contains('admission process')) {
      return 'The admission process involves submitting an online application, followed by an entrance exam.';
    } else if (message.contains('course list')) {
      return 'You can find the course list on our college website under the Academics section.';
    } else if (message.contains('fee structure')) {
      return 'The fee structure varies by course. Please visit our Fees section for detailed information.';
    } else if (message.contains('library hours')) {
      return 'The library is open from 8 AM to 8 PM on weekdays and 9 AM to 5 PM on weekends.';
    } else if (message.contains('scholarships available')) {
      return 'Yes, we offer several scholarships based on merit and financial need.';
    } else if (message.contains('hostel facilities')) {
      return 'We provide separate hostels for boys and girls with all basic amenities.';
    } else if (message.contains('sports activities')) {
      return 'We have a variety of sports activities including football, basketball, cricket, and more.';
    } else if (message.contains('extracurricular activities')) {
      return 'We offer numerous extracurricular activities such as music, dance, drama, and art.';
    } else if (message.contains('placements')) {
      return 'Our placement cell assists students with job placements and internships.';
    } else if (message.contains('transport facilities')) {
      return 'We provide transport facilities for students living in nearby areas.';
    } else if (message.contains('faculty members')) {
      return 'Our faculty members are highly qualified and experienced in their respective fields.';
    } else if (message.contains('attendance policy')) {
      return 'Students are required to maintain a minimum of 75% attendance in all classes.';
    } else if (message.contains('exam schedule')) {
      return 'The exam schedule is released at the beginning of each semester.';
    } else if (message.contains('grading system')) {
      return 'Our grading system follows a 10-point scale.';
    } else if (message.contains('academic calendar')) {
      return 'The academic calendar is available on our website and includes all important dates.';
    } else if (message.contains('library membership')) {
      return 'Library membership is available to all students upon admission.';
    } else if (message.contains('hostel rules')) {
      return 'Hostel rules are provided to all residents upon admission to the hostel.';
    } else if (message.contains('canteen menu')) {
      return 'The canteen menu is updated weekly and offers a variety of meals and snacks.';
    } else if (message.contains('medical facilities')) {
      return 'We have a medical center on campus with a qualified doctor and nurse.';
    } else if (message.contains('wifi access')) {
      return 'WiFi access is available throughout the campus for all students and staff.';
    } else if (message.contains('library resources')) {
      return 'Our library has a vast collection of books, journals, and digital resources.';
    } else if (message.contains('research opportunities')) {
      return 'We encourage students to participate in research projects and offer various opportunities.';
    } else if (message.contains('student clubs')) {
      return 'We have numerous student clubs including tech clubs, cultural clubs, and more.';
    } else if (message.contains('internship programs')) {
      return 'Our internship programs are designed to provide practical experience in various fields.';
    } else if (message.contains('alumni network')) {
      return 'Our alumni network is strong and actively participates in college events and mentoring.';
    } else if (message.contains('financial aid')) {
      return 'Financial aid is available for eligible students based on their financial status.';
    } else if (message.contains('campus security')) {
      return 'Our campus is equipped with 24/7 security to ensure the safety of all students and staff.';
    } else if (message.contains('counseling services')) {
      return 'We offer counseling services to help students with their personal and academic concerns.';
    } else if (message.contains('student portal')) {
      return 'The student portal provides access to academic records, schedules, and more.';
    } else if (message.contains('course registration')) {
      return 'Course registration is done online at the beginning of each semester.';
    } else if (message.contains('timetable')) {
      return 'The timetable is available on the student portal and notice boards.';
    } else if (message.contains('event calendar')) {
      return 'The event calendar is available on our website and includes all upcoming events.';
    } else if (message.contains('faculty advisor')) {
      return 'Each student is assigned a faculty advisor to help with academic and career planning.';
    } else if (message.contains('credit transfer')) {
      return 'Credit transfer is possible for certain courses. Please contact the academic office for details.';
    } else if (message.contains('labs and equipment')) {
      return 'Our labs are equipped with the latest equipment and technology for hands-on learning.';
    } else if (message.contains('student exchange programs')) {
      return 'We offer student exchange programs with several partner institutions around the world.';
    } else if (message.contains('campus tour')) {
      return 'You can schedule a campus tour by contacting our admissions office.';
    } else if (message.contains('graduation requirements')) {
      return 'Graduation requirements include completing the required credits and passing all exams.';
    } else if (message.contains('library fines')) {
      return 'Library fines are charged for late returns and lost items. Details are available on our website.';
    } else if (message.contains('part-time jobs')) {
      return 'We offer part-time job opportunities on campus for students.';
    } else if (message.contains('faculty research')) {
      return 'Our faculty members are actively involved in research across various disciplines.';
    } else if (message.contains('student feedback')) {
      return 'We regularly collect student feedback to improve our services and facilities.';
    } else if (message.contains('online classes')) {
      return 'We offer online classes and resources through our e-learning platform.';
    } else if (message.contains('library catalog')) {
      return 'The library catalog is available online and can be accessed through our website.';
    } else if (message.contains('student handbook')) {
      return 'The student handbook contains all the rules and regulations and is available on our website.';
    } else if (message.contains('orientation program')) {
      return 'The orientation program for new students includes campus tours, meet-and-greet sessions, and more.';
    } else if (message.contains('exam results')) {
      return 'Exam results are published on the student portal and notice boards.';
    } else if (message.contains('academic advisors')) {
      return 'Academic advisors are available to help students with course selection and career planning.';
    } else if (message.contains('lab hours')) {
      return 'Lab hours vary by department and are posted on the notice boards and the website.';
    } else if (message.contains('student ID card')) {
      return 'Student ID cards are issued during the orientation program and are required for accessing campus facilities.';
    } else if (message.contains('computer labs')) {
      return 'Our computer labs are equipped with the latest hardware and software for student use.';
    } else if (message.contains('faculty office hours')) {
      return 'Faculty office hours are posted on their office doors and on the department website.';
    } else if (message.contains('course materials')) {
      return 'Course materials are provided by the faculty and are available on the student portal.';
    } else if (message.contains('library seating')) {
      return 'The library offers both individual and group seating arrangements for students.';
    } else if (message.contains('cafeteria menu')) {
      return 'The cafeteria menu includes a variety of meals and snacks, with vegetarian options available.';
    } else if (message.contains('student grievances')) {
      return 'Student grievances can be submitted online or in person at the student affairs office.';
    } else if (message.contains('sports facilities')) {
      return 'Our sports facilities include a gym, football field, basketball court, and more.';
    } else if (message.contains('research funding')) {
      return 'Research funding is available for eligible projects. Please contact the research office for details.';
    } else if (message.contains('cultural events')) {
      return 'We host a variety of cultural events throughout the year, including festivals, concerts, and plays.';
    } else if (message.contains('volunteer opportunities')) {
      return 'We offer numerous volunteer opportunities for students to get involved in the community.';
    } else if (message.contains('student discounts')) {
      return 'Student discounts are available at various local businesses. Check the student portal for details.';
    } else if (message.contains('study abroad programs')) {
      return 'Our study abroad programs offer students the chance to study in another country for a semester or year.';
    } else if (message.contains('student elections')) {
      return 'Student elections are held annually for various positions in the student council.';
    } else if (message.contains('alumni events')) {
      return 'We host regular alumni events, including reunions, networking sessions, and more.';
    } else if (message.contains('course prerequisites')) {
      return 'Course prerequisites are listed in the course catalog and on the student portal.';
    } else if (message.contains('internship placements')) {
      return 'Our placement cell assists students with securing internships in their field of study.';
    } else if (message.contains('faculty profiles')) {
      return 'Faculty profiles, including their qualifications and research interests, are available on our website.';
    } else if (message.contains('online library resources')) {
      return 'Our online library resources include e-books, journals, and databases.';
    } else if (message.contains('campus map')) {
      return 'A campus map is available on our website and in the student handbook.';
    } else if (message.contains('academic support')) {
      return 'Academic support services are available, including tutoring and study groups.';
    } else if (message.contains('student loans')) {
      return 'Student loans are available for eligible students. Please contact the financial aid office for details.';
    } else if (message.contains('career counseling')) {
      return 'Career counseling services are available to help students with job placement and career planning.';
    } else if (message.contains('library study rooms')) {
      return 'Library study rooms can be reserved online or at the library desk.';
    } else if (message.contains('course evaluations')) {
      return 'Course evaluations are conducted at the end of each semester to gather student feedback.';
    } else if (message.contains('faculty development')) {
      return 'We offer faculty development programs to help our teachers improve their skills and knowledge.';
    } else if (message.contains('campus events')) {
      return 'Campus events are listed on our website and in the student portal.';
    } else if (message.contains('online payment')) {
      return 'Online payment options are available for tuition fees and other charges.';
    } else if (message.contains('class schedules')) {
      return 'Class schedules are available on the student portal and on notice boards.';
    } else if (message.contains('faculty publications')) {
      return 'Faculty publications are available in our library and on our website.';
    } else if (message.contains('student mentorship')) {
      return 'Our mentorship program pairs students with faculty or senior students for guidance and support.';
    } else if (message.contains('hostel application')) {
      return 'Hostel applications are available online and should be submitted before the deadline.';
    } else if (message.contains('academic policies')) {
      return 'Academic policies are detailed in the student handbook and on our website.';
    } else if (message.contains('library events')) {
      return 'Library events include author talks, book clubs, and workshops.';
    } else if (message.contains('campus safety')) {
      return 'Campus safety is our priority. We have security personnel and emergency procedures in place.';
    } else if (message.contains('exam preparation')) {
      return 'We offer resources and workshops to help students prepare for exams.';
    } else if (message.contains('faculty awards')) {
      return 'Our faculty members have received numerous awards for their teaching and research.';
    } else if (message.contains('student health insurance')) {
      return 'Student health insurance is available and details can be found on our website.';
    } else if (message.contains('academic counseling')) {
      return 'Academic counseling services are available to help students with their academic progress.';
    } else if (message.contains('hostel amenities')) {
      return 'Our hostels are equipped with all necessary amenities for a comfortable stay.';
    } else if (message.contains('faculty directory')) {
      return 'The faculty directory is available on our website and includes contact information.';
    } else if (message.contains('library workshops')) {
      return 'Library workshops cover various topics, including research skills and citation methods.';
    } else {
      return 'I am not sure how to respond to that. Can you please rephrase?';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isUser = _messages[index].containsKey('user');
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[200] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(isUser ? _messages[index]['user']! : _messages[index]['bot']!),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}