import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> todoItems = [
    TodoItem(
      text: "라디오, 라면, 라일락 10번씩 발음하기",
      isCompleted: false,
    ),
    TodoItem(
      text: "국, 책, 밖 10번씩 발음하기",
      isCompleted: true,
    ),
    TodoItem(
      text: "라면은 노란 라면 봉지 안에 있다. 5번씩 읽어보기",
      isCompleted: false,
    ),
    TodoItem(
      text: "책상 위에 책이 두 권 있다. 5번씩 읽어보기",
      isCompleted: true,
    ),
    TodoItem(
      text: "놀이터에 라일락이 폈다. 5번씩 읽어보기",
      isCompleted: false,
    ),
  ];
  final TextEditingController _addTodoController = TextEditingController();

  @override
  void dispose() {
    _addTodoController.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_addTodoController.text.trim().isNotEmpty) {
      setState(() {
        todoItems.add(TodoItem(
          text: _addTodoController.text.trim(),
          isCompleted: false,
        ));
      });
      _addTodoController.clear();
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String monthName = _getMonthName(now.month);
    int day = now.day;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFFF6), // 동일한 배경색
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 여백
              const SizedBox(height: 20),
              
              // 헤더 섹션 (날짜와 로고)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 로고 이미지 (왼쪽 정렬)
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/logo_pic.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  // 날짜 표시 (오른쪽 정렬)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        monthName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      Text(
                        day.toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // 할 일 추가 섹션
              Container(
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
                    Expanded(
                      child: TextField(
                        controller: _addTodoController,
                        decoration: const InputDecoration(
                          hintText: '새로운 할 일을 입력하세요',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        onSubmitted: (_) => _addTodo(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _addTodo,
                      child: Container(
                        padding: const EdgeInsets.all(8),
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
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // 체크리스트
              Expanded(
                child: ListView.builder(
                  itemCount: todoItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                          // 체크박스
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                todoItems[index].isCompleted = !todoItems[index].isCompleted;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: todoItems[index].isCompleted 
                                    ? const Color(0xFF8FBC8F)
                                    : Colors.white,
                                border: Border.all(
                                  color: todoItems[index].isCompleted 
                                      ? const Color(0xFF8FBC8F)
                                      : Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: todoItems[index].isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // 할 일 텍스트
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Text(
                                todoItems[index].text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: todoItems[index].isCompleted 
                                      ? Colors.grey
                                      : const Color(0xFF2E7D32),
                                  decoration: todoItems[index].isCompleted 
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          // 삭제 버튼
                          GestureDetector(
                            onTap: () => _deleteTodo(index),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 20),
              
              // 뒤로가기 버튼
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
                    '뒤로가기',
                    style: TextStyle(
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
    );
  }


  String _getMonthName(int month) {
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}

class TodoItem {
  final String text;
  bool isCompleted;

  TodoItem({
    required this.text,
    required this.isCompleted,
  });
}
