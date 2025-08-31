import 'package:flutter/material.dart';
import '../db/customer_service.dart';
import '../models/customer.dart';

class CustomerProvider with ChangeNotifier {
  final CustomerService _service = CustomerService();

  List<Customer> _customers = [];

  List<Customer> get customers => _customers;

  Future<void> loadCustomers() async {
    _customers = await _service.getCustomers();
    notifyListeners();
  }

  Future<void> addCustomer(Customer customer) async {
    await _service.addCustomer(customer);
    await loadCustomers();
  }

  Future<void> updateCustomer(Customer customer) async {
    await _service.updateCustomer(customer);
    await loadCustomers();
  }

  Future<void> deleteCustomer(int id) async {
    await _service.deleteCustomer(id);
    await loadCustomers();
  }
}
