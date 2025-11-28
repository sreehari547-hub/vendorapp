import 'package:flutter/material.dart';
import 'package:vendorapp/models/vendor_models.dart';
import 'package:vendorapp/services/vendor_service.dart';
import 'package:vendorapp/session/session_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  VendorModel? _vendor;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadVendor();
  }

  Future<void> _loadVendor() async {
    final userId = await SessionManager.getLoggedInUserId();
    VendorModel? vendor;
    if (userId != null) {
      final key = int.tryParse(userId);
      if (key != null) {
        vendor = VendorService.getVendorByKey(key);
      }
    }
    setState(() {
      _vendor = vendor;
      _loading = false;
    });
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_vendor == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('No profile details found'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loadVendor,
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_vendor!.firstName} ${_vendor!.lastName}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email),
                title: Text(_vendor!.email),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.phone),
                title: Text(_vendor!.mobile),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _loadVendor,
                icon: const Icon(Icons.refresh),
                label: const Text('Reload details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = _buildBody();

    if (widget.embedded) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: body,
    );
  }
}

