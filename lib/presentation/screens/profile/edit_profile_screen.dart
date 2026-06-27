import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../../data/models/content.dart';
import '../../widgets/shared_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile? profile;
  const EditProfileScreen({super.key, this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  File? _pickedImage;
  bool _isLoading = false;
  String? _selectedAvatar;

  final List<String> _defaultAvatars = [
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Felix',
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Luna',
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Max',
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Zoe',
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Sam',
    'https://api.dicebear.com/7.x/adventurer/svg?seed=Alex',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile?.name ?? '');
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _selectedAvatar = widget.profile?.avatarUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, maxWidth: 512, maxHeight: 512, imageQuality: 85);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
        _selectedAvatar = null;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileBloc>().add(ProfileUpdated(
      name: _nameController.text.trim(),
      avatarUrl: _selectedAvatar,
      profileId: widget.profile?.id ?? '',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          widget.profile == null ? 'Edit Profile' : 'Edit Profile',
          style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated!'), backgroundColor: Colors.green),
            );
            context.pop();
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          setState(() => _isLoading = state is ProfileLoading);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildAvatarSection(colors),
                const SizedBox(height: 32),
                _buildNameField(colors),
                const SizedBox(height: 16),
                _buildDefaultAvatarPicker(colors),
                const SizedBox(height: 40),
                GradientButton(
                  label: 'Save Changes',
                  isLoading: _isLoading,
                  onPressed: _submit,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(OttColors colors) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 56,
              backgroundColor: colors.primary.withOpacity(0.3),
              backgroundImage: _pickedImage != null
                  ? FileImage(_pickedImage!)
                  : (_selectedAvatar != null ? NetworkImage(_selectedAvatar!) as ImageProvider : null),
              child: _pickedImage == null && _selectedAvatar == null
                  ? Icon(Icons.person, size: 56, color: colors.primary)
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle,
                    border: Border.all(color: colors.background, width: 2)),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField(OttColors colors) {
    return TextFormField(
      controller: _nameController,
      style: TextStyle(color: colors.textPrimary),
      decoration: InputDecoration(
        labelText: 'Profile Name',
        labelStyle: TextStyle(color: colors.textSecondary),
        prefixIcon: Icon(Icons.person_outline, color: colors.textSecondary),
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colors.primary, width: 2)),
      ),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
    );
  }

  Widget _buildDefaultAvatarPicker(OttColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Avatar', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6, crossAxisSpacing: 10, mainAxisSpacing: 10,
          ),
          itemCount: _defaultAvatars.length,
          itemBuilder: (context, i) {
            final url = _defaultAvatars[i];
            final isSelected = _selectedAvatar == url && _pickedImage == null;
            return GestureDetector(
              onTap: () => setState(() { _selectedAvatar = url; _pickedImage = null; }),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? colors.primary : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(backgroundImage: NetworkImage(url), backgroundColor: colors.surface),
              ),
            );
          },
        ),
      ],
    );
  }
}
