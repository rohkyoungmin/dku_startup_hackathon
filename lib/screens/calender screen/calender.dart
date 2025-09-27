import 'package:flutter/material.dart';
import 'todo_list.dart';
import '../practice screen/practice.dart';
import '../user screen/user.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedIndex = 1; // 캘린더 탭이 선택된 상태
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getCurrentMonthName() {
    DateTime now = DateTime.now();
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[now.month - 1];
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 2) { // 북마크 버튼
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PracticeScreen(),
            ),
          );
        } else if (index == 3) { // user 버튼
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UserScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFFF6), // 동일한 배경색
      body: SafeArea(
        child: Column(
          children: [
            // 상단 여백
            const SizedBox(height: 20),
            
            // 상단 검색바
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search your challenge',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 챌린지 진행률 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // 캐릭터 아이콘
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        'assets/images/logo_pic.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 챌린지 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Growing with Me!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '60% about your Progress',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // 진행률 바
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.6,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8FBC8F),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 캘린더 섹션
            Container(
              height: 400, // 고정 높이로 설정
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E8), // 연한 초록색 배경
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // 현재 월 헤더
                  Text(
                    _getCurrentMonthName(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 요일 헤더
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _DayHeader(day: 'SUN'),
                      _DayHeader(day: 'MON'),
                      _DayHeader(day: 'TUE'),
                      _DayHeader(day: 'WED'),
                      _DayHeader(day: 'THU'),
                      _DayHeader(day: 'FRI'),
                      _DayHeader(day: 'SAT'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 캘린더 그리드
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1,
                      ),
                      itemCount: 35, // 5주 x 7일
                      itemBuilder: (context, index) {
                        DateTime now = DateTime.now();
                        int currentDay = now.day;
                        int currentMonth = now.month;
                        int currentYear = now.year;
                        
                        // 현재 월의 첫 번째 날
                        DateTime firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
                        int firstWeekday = firstDayOfMonth.weekday % 7; // 일요일을 0으로 변환
                        
                        int day = index - firstWeekday + 1;
                        bool isCurrentDay = day == currentDay;
                        bool isValidDay = day >= 1 && day <= DateTime(currentYear, currentMonth + 1, 0).day;

                        return Container(
                          margin: const EdgeInsets.all(2),
                          child: Center(
                            child: isValidDay
                                ? Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: isCurrentDay
                                          ? const Color(0xFF8FBC8F)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        day.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isCurrentDay
                                              ? Colors.white
                                              : const Color(0xFF2E7D32),
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Go to today's Practice 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TodoListScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8FBC8F), // 초록색
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF8FBC8F).withOpacity(0.3),
                  ),
                  child: const Text(
                    'Today\'s To-Do List',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Go to Practice! 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PracticeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8FBC8F), // 초록색
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF8FBC8F).withOpacity(0.3),
                  ),
                  child: const Text(
                    'Go to Practice!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(), // 남은 공간을 채워서 네비게이션바를 하단에 고정
            
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
}

class _DayHeader extends StatelessWidget {
  final String day;

  const _DayHeader({required this.day});

  @override
  Widget build(BuildContext context) {
    return Text(
      day,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2E7D32),
      ),
    );
  }
}
