import 'package:flutter/material.dart';
import '../calender screen/calender.dart';
import '../practice screen/practice.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _selectedIndex = 3; // user 탭이 선택된 상태
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController(text: '노경민');
  final TextEditingController _usernameController = TextEditingController(text: 'Roh');
  final TextEditingController _passwordController = TextEditingController(text: '********');
  final TextEditingController _emailController = TextEditingController(text: 'imsie1@dankook.ac.kr');

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('정보가 저장되었습니다!'),
        backgroundColor: Color(0xFF8FBC8F),
      ),
    );
  }

  void _uploadProfileImage() {
    // 프로필 이미지 업로드 로직
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('프로필 이미지 업로드 기능은 준비 중입니다.'),
        backgroundColor: Color(0xFF8FBC8F),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFFF6), // 동일한 배경색
      body: SafeArea(
        child: Column(
          children: [
            // 상단 여백
            const SizedBox(height: 40),
            
            // 프로필 이미지
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF5F5DC), // 베이지색 배경
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // + 버튼
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _uploadProfileImage,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8FBC8F),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // 입력 필드들
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    _buildInputField('Name', _nameController),
                    const SizedBox(height: 24),
                    _buildInputField('Username', _usernameController),
                    const SizedBox(height: 24),
                    _buildInputField('Password', _passwordController, isPassword: true),
                    const SizedBox(height: 24),
                    _buildInputField('E-mail', _emailController),
                    const SizedBox(height: 40),
                    
                    // Edit/Save 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isEditing ? _saveChanges : _toggleEditMode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8FBC8F), // 초록색
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          shadowColor: const Color(0xFF8FBC8F).withOpacity(0.3),
                        ),
                        child: Text(
                          _isEditing ? 'Save' : 'Edit',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // 커스텀 하단 네비게이션 바
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFFBFFF6), // 배경색과 동일
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 0, ''),
                  _buildNavItem(Icons.calendar_today, 1, ''),
                  _buildNavItem(Icons.bookmark, 2, ''),
                  _buildNavItem(Icons.person, 3, ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF8FBC8F), // 연한 초록색
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          enabled: _isEditing, // 편집 모드일 때만 수정 가능
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF8FBC8F),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF8FBC8F),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF8FBC8F),
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: _isEditing ? Colors.white : Colors.grey[100],
          ),
          style: TextStyle(
            fontSize: 16,
            color: _isEditing ? const Color(0xFF2E7D32) : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 1) { // 캘린더 버튼
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CalendarScreen(),
            ),
          );
        } else if (index == 2) { // 북마크 버튼
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PracticeScreen(),
            ),
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF2E7D32) : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}
