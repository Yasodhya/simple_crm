import 'package:flutter/material.dart';
import 'add_edit_customer_screen.dart';
import 'customer_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_provider.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);

    // Load customers when screen builds
    customerProvider.loadCustomers();

    return Scaffold(
      body: customerProvider.customers.isEmpty
          ? const Center(child: Text("No customers yet"))
          : ListView.builder(
              itemCount: customerProvider.customers.length,
              itemBuilder: (context, index) {
                final customer = customerProvider.customers[index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.company),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      customerProvider.deleteCustomer(customer.id!);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerDetailScreen(customer: customer),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditCustomerScreen()),
          );
        },
      ),
    );
  }
}