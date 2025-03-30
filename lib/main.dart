
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:provider/provider.dart';
// import 'package:google_generative_ai/google_generative_ai.dart'; // Import the Gemini package




// void main() {
//   runApp(const FoodDonationApp());
// }

// class FoodDonationApp extends StatelessWidget {
//   const FoodDonationApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => DonationProvider()),
//         ChangeNotifierProvider(create: (_) => GeminiProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Food Donation',
//         theme: ThemeData(
//           brightness: Brightness.dark,
//           primaryColor: Colors.black,
//           scaffoldBackgroundColor: Colors.blueGrey[900],
//           appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
//         ),
//         home: const LoginPage(),
//       ),
//     );
//   }
// }

// // ---------------------------- LOGIN PAGE ----------------------------

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _login(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       if (_usernameController.text == 'user' &&
//           _passwordController.text == 'password') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Invalid username or password')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Center(child: Text('Welcome to PlateMate'))),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Username',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _login(context),
//                 child: const Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ---------------------------- HOME SCREEN ----------------------------

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Food Donations'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginPage()),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.chat),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const GeminiScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Consumer<DonationProvider>(
//         builder: (context, provider, child) {
//           return ListView.builder(
//             padding: const EdgeInsets.all(10),
//             itemCount: provider.donations.length,
//             itemBuilder: (context, index) {
//               final donation = provider.donations[index];
//               return Card(
//                 color: Colors.blueGrey[800],
//                 child: ListTile(
//                   title: Text(
//                     donation.foodName,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   subtitle: Text(
//                     "Location: ${donation.location}\nExpires on: ${donation.expiryDate}",
//                     style: const TextStyle(color: Colors.white70),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const DonateFoodScreen()),
//         ),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// // ---------------------------- DONATE FOOD SCREEN ----------------------------

// class DonateFoodScreen extends StatelessWidget {
//   const DonateFoodScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     String foodName = '', description = '', location = '', expiryDate = '';
//     int quantity = 1, freshnessRating = 3;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Donate Food')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Food Name'),
//                 onSaved: (value) => foodName = value!,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Location'),
//                 onSaved: (value) => location = value!,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Expiry Date (YYYY-MM-DD)'),
//                 onSaved: (value) => expiryDate = value!,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     formKey.currentState!.save();
//                     Provider.of<DonationProvider>(context, listen: false).addDonation(
//                       FoodDonation(foodName, location, expiryDate),
//                     );
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ---------------------------- DONATION PROVIDER ----------------------------

// class FoodDonation {
//   final String foodName;
//   final String location;
//   final String expiryDate;

//   FoodDonation(this.foodName, this.location, this.expiryDate);
// }

// class DonationProvider extends ChangeNotifier {
//   final List<FoodDonation> _donations = [];
//   List<FoodDonation> get donations => _donations;

//   void addDonation(FoodDonation donation) {
//     _donations.add(donation);
//     notifyListeners();
//   }
// }

// // ---------------------------- GEMINI AI INTEGRATION ----------------------------

// class GeminiProvider extends ChangeNotifier {
//   final String apiKey = 'AIzaSyADEyMAlZvrImhqHxb9TEtFaUExZAy9EzU'; // Replace with your Gemini API key
//   late GenerativeModel _model;
//   String _geminiResponse = '';

//   GeminiProvider() {
//     _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
//   }

//   String get geminiResponse => _geminiResponse;

//   Future<void> generateContent(String prompt) async {
//     try {
//       final content = [Content.text(prompt)];
//       final response = await _model.generateContent(content);
//       _geminiResponse = response.text ?? 'No response from Gemini.';
//       notifyListeners();
//     } catch (e) {
//       _geminiResponse = 'Error: $e';
//       notifyListeners();
//     }
//   }
// }

// // ---------------------------- GEMINI CHAT SCREEN ----------------------------



// class GeminiScreen extends StatefulWidget {
//   const GeminiScreen({super.key});

//   @override
//   State<GeminiScreen> createState() => _GeminiScreenState();
// }

// class _GeminiScreenState extends State<GeminiScreen> {
//   String _geminiResponse = 'Loading...';
//   final TextEditingController _promptController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _getGeminiResponse("Explain how AI works"); //Initial prompt
//   }


//   Future<void> _getGeminiResponse(String prompt) async {
//     setState(() {
//       _isLoading = true;
//       _geminiResponse = 'Loading...'; // Show loading indicator.
//     });

//     final apiKey = 'YOUR_GEMINI_API_KEY'; // Replace with your actual API key.
//     final url = Uri.parse(
//         'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "contents": [
//             {
//               "parts": [{"text": prompt}]
//             }
//           ]
//         }),
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         // Extract the text from the response.  This may need adjustment based on the exact API response format.
//         final generatedText = jsonResponse['candidates'][0]['content']['parts'][0]['text'] ?? 'No response';

//         setState(() {
//           _geminiResponse = generatedText;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _geminiResponse =
//           'Error: ${response.statusCode} - ${response.reasonPhrase}';
//           _isLoading = false;
//         });
//         print('Request failed with status: ${response.statusCode}.');
//       }
//     } catch (e) {
//       setState(() {
//         _geminiResponse = 'Error: $e';
//         _isLoading = false;
//       });
//       print('Error during API call: $e');
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Gemini Chat')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _promptController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your prompt...',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: (value) {
//                 _getGeminiResponse(value);
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _getGeminiResponse(_promptController.text);
//               },
//               child: Text('Get Response'),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   _isLoading ? 'Loading...' : _geminiResponse,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _promptController.dispose();
//     super.dispose();
//   }
// }





import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const FoodDonationApp());
}

class FoodDonationApp extends StatelessWidget {
  const FoodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DonationProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()), // Add ChatProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Donation',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey[900],
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          cardColor: Colors.grey[850],
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}

// ---------------------------- LOGIN PAGE ----------------------------

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to PlateMate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.white70),
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent[700],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------- HOME SCREEN ----------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlateMate', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<DonationProvider>(
              builder: (context, provider, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: provider.donations.length,
                  itemBuilder: (context, index) {
                    final donation = provider.donations[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationDetailsScreen(donation: donation),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: donation.image != null
                                    ? Image.file(
                                        File(donation.image!),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )
                                    : Image.network(
                                        'https://source.unsplash.com/200x200/?food,${donation.foodName}',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    donation.foodName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Expires on: ${donation.expiryDate}",
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "Best Before: ${donation.bestBeforeTime}",
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "Quantity: ${donation.quantity}",
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "Category: ${donation.category}",
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "Description: ${donation.description}",
                                    style: const TextStyle(color: Colors.white70),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RequestFoodScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent[700],
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Request Food", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10), // Add some spacing
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DonateFoodScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ---------------------------- DONATION DETAILS SCREEN ----------------------------

class DonationDetailsScreen extends StatelessWidget {
  final FoodDonation donation;

  const DonationDetailsScreen({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(donation.foodName)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: donation.image != null
                    ? Image.file(
                        File(donation.image!),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://source.unsplash.com/200x200/?food,${donation.foodName}',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Food: ${donation.foodName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Expires on: ${donation.expiryDate}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Text(
              'Best Before: ${donation.bestBeforeTime}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Text(
              'Quantity: ${donation.quantity}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Text(
              'Category: ${donation.category}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Text(
              'Description: ${donation.description}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(donation: donation),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent[700],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Chat with Donor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickupArrangementScreen(donation: donation),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[700],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Arrange Pickup', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------- CHAT SCREEN ----------------------------

class ChatScreen extends StatefulWidget {
  final FoodDonation donation;

  const ChatScreen({super.key, required this.donation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = []; // Store chat messages

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: messageText,
          isMe: true, // Assume the current user is the sender
        ));
        _messageController.clear();
      });
      // In a real app, you would send the message to a backend server
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with Donor')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(message: message);
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        border: Border(top: BorderSide(color: Colors.grey[800]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

// Chat Message Model
class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}

// Chat Bubble Widget
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.green[700] : Colors.grey[700],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// ---------------------------- PICKUP ARRANGEMENT SCREEN ----------------------------

class PickupArrangementScreen extends StatefulWidget {
  final FoodDonation donation;

  const PickupArrangementScreen({super.key, required this.donation});

  @override
  State<PickupArrangementScreen> createState() => _PickupArrangementScreenState();
}

class _PickupArrangementScreenState extends State<PickupArrangementScreen> {
  String? _pickupTime;
  String? _pickupLocation;
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _timeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _pickupTime = pickedTime.format(context);
        _timeController.text = _pickupTime!; // Update the text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arrange Pickup')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Arranging pickup for: ${widget.donation.foodName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _timeController, // Use the controller
              decoration: InputDecoration(
                labelText: 'Preferred Pickup Time',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time, color: Colors.white70),
                  onPressed: () => _selectTime(context),
                ),
              ),
              readOnly: true, // Make the field read-only
              onTap: () => _selectTime(context), // Open the time picker on tap
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _locationController, // Use the controller
              decoration: InputDecoration(
                labelText: 'Pickup Location',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _pickupLocation = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to save pickup arrangement details or notify the donor
                // You can use _pickupTime and _pickupLocation
                _showConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[700],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Confirm Pickup Arrangement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Pickup Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Time: ${_pickupTime ?? "Not selected"}'),
              Text('Location: ${_pickupLocation ?? "Not specified"}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                // Implement actual confirmation logic, like sending a notification
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pickup arrangement confirmed!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// ---------------------------- DONATION PROVIDER ----------------------------

enum FoodCategory { veg, nonVeg, vegan }

class FoodDonation {
  final String foodName;
  final String expiryDate;
  final String? image;
  final String quantity;
  final String description;
  final String bestBeforeTime;
  final FoodCategory category;

  FoodDonation({
    required this.foodName,
    required this.expiryDate,
    this.image,
    required this.quantity,
    required this.description,
    required this.bestBeforeTime,
    required this.category,
  });
}

class DonationProvider extends ChangeNotifier {
  final List<FoodDonation> _donations = [];

  List<FoodDonation> get donations => _donations;

  void addDonation(FoodDonation donation) {
    _donations.add(donation);
    notifyListeners();
  }
}

// ---------------------------- DONATE FOOD SCREEN ----------------------------

class DonateFoodScreen extends StatefulWidget {
  const DonateFoodScreen({super.key});

  @override
  State<DonateFoodScreen> createState() => _DonateFoodScreenState();
}

class _DonateFoodScreenState extends State<DonateFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _bestBeforeTimeController = TextEditingController();

  File? _image;
  final picker = ImagePicker();
  FoodCategory _selectedCategory = FoodCategory.veg;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose image source"),
          actions: [
            TextButton(
              child: const Text("Camera"),
              onPressed: () {
                Navigator.of(context).pop();
                getImage(ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text("Gallery"),
              onPressed: () {
                Navigator.of(context).pop();
                getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _expiryDateController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    _bestBeforeTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donate Food')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _image!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          color: Colors.white70,
                          size: 60,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _foodNameController,
                decoration: InputDecoration(
                  labelText: 'Food Name',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the food name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.calendar_today, color: Colors.white70),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      _expiryDateController.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bestBeforeTimeController,
                decoration: InputDecoration(
                  labelText: 'Best Before (Time)',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.access_time, color: Colors.white70), // Optional time icon
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    // Format TimeOfDay to a string
                    final formattedTime = pickedTime.format(context);
                    setState(() {
                      _bestBeforeTimeController.text = formattedTime;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the best before time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<FoodCategory>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: _selectedCategory,
                items: FoodCategory.values.map((category) {
                  return DropdownMenuItem<FoodCategory>(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[700],
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final foodName = _foodNameController.text;
                    final expiryDate = _expiryDateController.text;
                    final quantity = _quantityController.text;
                    final description = _descriptionController.text;
                    final bestBeforeTime = _bestBeforeTimeController.text;

                    final donationProvider = Provider.of<DonationProvider>(context, listen: false);

                    donationProvider.addDonation(
                      FoodDonation(
                        foodName: foodName,
                        expiryDate: expiryDate,
                        image: _image?.path,
                        quantity: quantity,
                        description: description,
                        bestBeforeTime: bestBeforeTime,
                        category: _selectedCategory,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Donation added successfully!')),
                    );

                    _foodNameController.clear();
                    _expiryDateController.clear();
                    _quantityController.clear();
                    _descriptionController.clear();
                    _bestBeforeTimeController.clear();
                    setState(() {
                      _image = null;
                      _selectedCategory = FoodCategory.veg;
                    });

                    Navigator.pop(context);
                  }
                },
                child: const Text('Donate Food', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------------------------- REQUEST FOOD PROVIDER AND SCREEN ----------------------------

class FoodRequest {
  final String foodName;
  final String quantity;
  final String description;

  FoodRequest({
    required this.foodName,
    required this.quantity,
    required this.description,
  });
}

class RequestProvider extends ChangeNotifier {
  final List<FoodRequest> _requests = [];

  List<FoodRequest> get requests => _requests;

  void addRequest(FoodRequest request) {
    _requests.add(request);
    notifyListeners();
  }
}

class RequestFoodScreen extends StatefulWidget {
  const RequestFoodScreen({super.key});

  @override
  State<RequestFoodScreen> createState() => _RequestFoodScreenState();
}

class _RequestFoodScreenState extends State<RequestFoodScreen> {
  // Key to identify and manage the Form state
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage text input fields
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Dispose controllers when the widget is removed from the widget tree
  // to free up resources and prevent memory leaks.
  @override
  void dispose() {
    _foodNameController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitRequest() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, access the data
      final foodName = _foodNameController.text;
      final quantity = _quantityController.text; // Keep as string or parse if needed
      final description = _descriptionController.text;

      // --- TODO: Implement your submission logic here ---
      // For example, send data to an API, update state management, etc.
      print('Food Name: $foodName');
      print('Quantity: $quantity');
      print('Description: $description');

      // Show a confirmation message (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Food request submitted!')),
      );

      // Optionally clear the form after submission
      // _formKey.currentState?.reset();
      // _foodNameController.clear();
      // _quantityController.clear();
      // _descriptionController.clear();

      // Optionally navigate back or to another screen
      // Navigator.pop(context);
    } else {
      // If the form is invalid, show an error message (optional, validation messages handle most cases)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // Define consistent input decoration for text fields
    InputDecoration inputDecoration(String labelText) {
      return InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[800], // Dark background for text field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // No visible border line
        ),
        focusedBorder: OutlineInputBorder( // Border when field is focused
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder( // Border when field has error
           borderRadius: BorderRadius.circular(10),
           borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
         focusedErrorBorder: OutlineInputBorder( // Border when field has error and is focused
           borderRadius: BorderRadius.circular(10),
           borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      );
    }

    return Scaffold(
      // Use a dark theme background for consistency if desired
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Request Food'),
        // backgroundColor: Colors.grey[850], // Match background theme
        // elevation: 0, // Remove shadow if desired
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Assign the key to the Form
          child: SingleChildScrollView( // Use SingleChildScrollView to prevent overflow on smaller screens
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Make button stretch
              children: [
                // Food Name Field
                TextFormField(
                  controller: _foodNameController,
                  style: const TextStyle(color: Colors.white), // Text color
                  decoration: inputDecoration('Food Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the food name';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                const SizedBox(height: 20), // Spacing between fields

                // Quantity Field
                TextFormField(
                  controller: _quantityController,
                  style: const TextStyle(color: Colors.white), // Text color
                  decoration: inputDecoration('Quantity (e.g., 2 packs, 500g, 3 pieces)'),
                  // Consider using TextInputType.number if you only want numbers,
                  // but text allows for units like 'kg', 'packs'.
                  // keyboardType: TextInputType.number,
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.digitsOnly // Only allow digits if type is number
                  // ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the quantity';
                    }
                    // Add more specific validation if needed (e.g., check for numbers)
                    // if (int.tryParse(value) == null) {
                    //   return 'Please enter a valid number for quantity';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Spacing

                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white), // Text color
                  decoration: inputDecoration('Description (Optional - e.g., specific brand, dietary notes)'),
                  maxLines: 3, // Allow multiple lines for description
                  // Description is optional, so no validator is added here.
                  // Add one if it should be mandatory.
                  // validator: (value) { ... }
                ),
                const SizedBox(height: 30), // Spacing before button

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary, // Use theme primary color
                    foregroundColor: Colors.white, // Text color on button
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _submitRequest, // Call the submit handler
                  child: const Text('Submit Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// ... (Keep all the code from the previous response up to this point)

//---------------------------- REQUEST FOOD PROVIDER AND SCREEN ----------------------------


//---------------------------- CHAT PROVIDER ----------------------------

class ChatProvider extends ChangeNotifier {
  // This is a placeholder. In a real app, you would store messages per chat/donation.
  // Example: Map<String, List<ChatMessage>> _chats = {};
  // Where the key could be a unique identifier for the donation/chat.

  // You would add methods here to add messages to specific chats,
  // fetch messages, etc., and call notifyListeners() when data changes.
  // Example:
  // void addMessage(String donationId, ChatMessage message) {
  //   if (!_chats.containsKey(donationId)) {
  //     _chats[donationId] = [];
  //   }
  //   _chats[donationId]!.add(message);
  //   notifyListeners();
  // }
  
  // List<ChatMessage> getMessages(String donationId) {
  //   return _chats[donationId] ?? [];
  // }
}