import 'package:hive_flutter/hive_flutter.dart';
import 'package:vendorapp/models/vendor_models.dart';

// Service class for managing vendor data in Hive
class VendorService {
  static const String _boxName = 'vendorBox';

  static Box<VendorModel> get _vendorBox => Hive.box<VendorModel>(_boxName);

  // Get all vendors
  static List<VendorModel> getAllVendors() {
    return _vendorBox.values.toList();
  }

  // Get vendor by email
  static VendorModel? getVendorByEmail(String email) {
    try {
      for (var vendor in _vendorBox.values) {
        if (vendor.email.toLowerCase() == email.toLowerCase()) {
          return vendor;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Get vendor by key
  static VendorModel? getVendorByKey(int key) {
    try {
      return _vendorBox.get(key);
    } catch (e) {
      return null;
    }
  }

  // Add a new vendor
  static Future<void> addVendor(VendorModel vendor) async {
    await _vendorBox.add(vendor);
  }

  // Update an existing vendor
  static Future<void> updateVendor(int key, VendorModel vendor) async {
    await vendor.save();
  }

  // Delete a vendor
  static Future<void> deleteVendor(int key) async {
    await _vendorBox.delete(key);
  }

  // Check if email already exists
  static bool emailExists(String email) {
    return _vendorBox.values.any(
      (v) => v.email.toLowerCase() == email.toLowerCase(),
    );
  }

  // Get vendor count
  static int getVendorCount() {
    return _vendorBox.length;
  }

  // Clear all vendors
  static Future<void> clearAllVendors() async {
    await _vendorBox.clear();
  }
}








