import 'dart:io';
import 'package:ecofriendly/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecofriendly/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userEmail = 'yane@gmail.com';
  String? userName = 'Yane';
  String? userGrade = '6';
  String? userGroup = 'D';
  String? userPhoneNumber = '241 112 4498';
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      _showMessage("Imagen actualizada con éxito.", isError: false);
    } else {
      _showMessage("No se seleccionó ninguna imagen.", isError: true);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Perfil',
      selectedIndex: 2,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  selectedImage != null ? FileImage(selectedImage!) : null,
              child:
                  selectedImage == null
                      ? const Icon(
                        Icons.account_circle,
                        size: 80,
                        color: Colors.grey,
                      )
                      : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppTheme.buttonColor,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          userName ?? 'Usuario',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          userEmail ?? '',
          style: const TextStyle(color: AppTheme.textColor),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        children: [
          _buildProfileDetail('Grado:', userGrade ?? 'No disponible'),
          _buildProfileDetail('Grupo:', userGroup ?? 'No disponible'),
          _buildProfileDetail('Teléfono:', userPhoneNumber ?? 'No disponible'),
        ],
      ),
    );
  }

  Widget _buildProfileDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: AppTheme.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
