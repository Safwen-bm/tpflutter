import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'AIzaSyDDxZljJK8WrDHXstp4F7oakMN5rsby_DI';
const String model = 'gemini-2.5-pro';

final String apiUrl = 'https://generativelanguage.googleapis.com/v1/models/$model:generateContent?key=$apiKey';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty || _isLoading) return;

    final userText = _controller.text.trim();
    setState(() {
      messages.add({'text': userText, 'sender': 'user'});
      _isLoading = true;
    });

    _controller.clear();

    final response = await getChatbotResponse(userText);
    setState(() {
      messages.add({'text': response, 'sender': 'bot'});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f8fb),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("AI Chatbot", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isUser = messages[index]['sender'] == 'user';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.all(14),
                    constraints: BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft:
                            isUser ? Radius.circular(18) : Radius.circular(0),
                        bottomRight:
                            isUser ? Radius.circular(0) : Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Text(
                      messages[index]['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 15,
                        height: 1.3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (_isLoading) ...[
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  CircularProgressIndicator(strokeWidth: 2),
                  SizedBox(width: 12),
                  Text("Le bot écrit...",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black54)),
                ],
              ),
            ),
          ],

          // Input bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff2f3f7),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Tape ton message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// BACKEND LOGIC UNTOUCHED
Future<String> getChatbotResponse(String query) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "role": "user",
            "parts": [
              {"text": query}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final candidates = data['candidates'];
      if (candidates != null &&
          candidates is List &&
          candidates.isNotEmpty &&
          candidates[0]['content'] != null &&
          candidates[0]['content']['parts'] != null &&
          candidates[0]['content']['parts'] is List &&
          candidates[0]['content']['parts'].isNotEmpty &&
          candidates[0]['content']['parts'][0]['text'] != null) {
        return candidates[0]['content']['parts'][0]['text'];
      } else {
        return 'Erreur: format de réponse inattendu.';
      }
    } else {
      print('Gemini error: ${response.statusCode} - ${response.body}');
      return 'Erreur: ${response.statusCode} lors de l’appel à l’API.';
    }
  } catch (e) {
    print('Exception: $e');
    return 'Erreur réseau ou exception: $e';
  }
}
