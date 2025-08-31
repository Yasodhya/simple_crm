import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/customer.dart';
import '../../providers/note_provider.dart';
import '../notes/add_note_screen.dart';

class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;
  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false)
        .loadNotesByCustomer(widget.customer.id!);
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.customer.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${widget.customer.name}", style: const TextStyle(fontSize: 18)),
            Text("Phone: ${widget.customer.phone}", style: const TextStyle(fontSize: 18)),
            Text("Email: ${widget.customer.email}", style: const TextStyle(fontSize: 18)),
            Text("Company: ${widget.customer.company}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddNoteScreen(customer: widget.customer),
                  ),
                );
              },
              child: const Text("Add Note"),
            ),

            const SizedBox(height: 20),
            const Text("Notes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
            Expanded(
              child: noteProvider.notes.isEmpty
                  ? const Center(child: Text("No notes yet"))
                  : ListView.builder(
                      itemCount: noteProvider.notes.length,
                      itemBuilder: (context, index) {
                        final note = noteProvider.notes[index];
                        return ListTile(
                          title: Text(note.title),
                          subtitle: Text(note.description),
                          trailing: Text(note.date),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNoteScreen(customer: widget.customer), // FIXED
            ),
          );
        },
      ),
    );
  }
}
