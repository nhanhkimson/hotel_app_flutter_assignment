import 'package:flutter/material.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/core/services/user_service.dart';

/// My Profile - Basic Detail View
class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final LanguageService _languageService = LanguageService();
  final AppLocalizations _localizations = AppLocalizations();
  final UserService _userService = UserService();
  late TextEditingController _fullNameController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _emailController;
  String _selectedGender = 'Male';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLanguageChanged);
    _userService.addListener(_onUserChanged);
    
    // Initialize with user data
    final userInfo = _userService.getUserInfo();
    _fullNameController = TextEditingController(text: userInfo['fullName'] ?? '');
    _dateOfBirthController = TextEditingController(text: userInfo['dateOfBirth'] ?? '');
    _emailController = TextEditingController(text: userInfo['email'] ?? '');
    _selectedGender = userInfo['gender'] ?? 'Male';
  }

  void _onUserChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLanguageChanged);
    _userService.removeListener(_onUserChanged);
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            '${picked.day} ${_getMonthName(picked.month)} ${picked.year}';
      });
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Future<void> _handleSaveProfile() async {
    setState(() {
      _isLoading = true;
    });

    final success = await _userService.updateProfile(
      fullName: _fullNameController.text.trim(),
      dateOfBirth: _dateOfBirthController.text.trim(),
      gender: _selectedGender,
    );

    setState(() {
      _isLoading = false;
    });

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _localizations.isEnglish
                ? 'Profile updated successfully'
                : 'បានធ្វើបច្ចុប្បន្នភាពប្រូហ្វាលដោយជោគជ័យ',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _localizations.myProfile,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _localizations.basicDetail,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: _localizations.fullName,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(
                    labelText: _localizations.dateOfBirth,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _localizations.gender,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text(_localizations.male),
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text(_localizations.female),
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: _localizations.email,
                border: const OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSaveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _localizations.save,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

