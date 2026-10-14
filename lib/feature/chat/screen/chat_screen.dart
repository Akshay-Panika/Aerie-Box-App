import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF5F259F);
    const Color primaryLight = Color(0xFF7C3AED);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // Modern Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.chat_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '12',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Chat List
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _buildSectionHeader('Today'),
                  _buildChatTile(
                    name: 'Rahul Sharma',
                    lastMessage: 'Is the room still available?',
                    time: '10:30 AM',
                    unreadCount: 2,
                    avatarColor: const Color(0xFF4F46E5),
                    isOnline: true,
                    isPinned: true,
                  ),
                  _buildChatTile(
                    name: 'Priya Patel',
                    lastMessage: 'Yes, you can visit tomorrow at 11 AM',
                    time: '9:15 AM',
                    unreadCount: 0,
                    avatarColor: const Color(0xFF059669),
                    isOnline: true,
                    isPinned: false,
                  ),
                  _buildSectionHeader('Yesterday'),
                  _buildChatTile(
                    name: 'Amit Kumar',
                    lastMessage: 'What\'s the monthly rent?',
                    time: '4:30 PM',
                    unreadCount: 1,
                    avatarColor: const Color(0xFFD97706),
                    isOnline: false,
                    isPinned: false,
                  ),
                  _buildChatTile(
                    name: 'Sneha Reddy',
                    lastMessage: 'I\'m interested in the room',
                    time: '2:00 PM',
                    unreadCount: 0,
                    avatarColor: const Color(0xFF7C3AED),
                    isOnline: false,
                    isPinned: false,
                  ),
                  _buildSectionHeader('This Week'),
                  _buildChatTile(
                    name: 'Vikram Singh',
                    lastMessage: 'Thank you for showing the room',
                    time: 'Wed',
                    unreadCount: 0,
                    avatarColor: const Color(0xFFDC2626),
                    isOnline: false,
                    isPinned: false,
                  ),
                  _buildChatTile(
                    name: 'Neha Gupta',
                    lastMessage: 'Can I bring my pet?',
                    time: 'Tue',
                    unreadCount: 0,
                    avatarColor: const Color(0xFF0D9488),
                    isOnline: false,
                    isPinned: false,
                  ),
                  _buildChatTile(
                    name: 'Arjun Mehta',
                    lastMessage: 'I\'ll send the documents today',
                    time: 'Mon',
                    unreadCount: 0,
                    avatarColor: const Color(0xFF2563EB),
                    isOnline: false,
                    isPinned: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildChatTile({
    required String name,
    required String lastMessage,
    required String time,
    required int unreadCount,
    required Color avatarColor,
    required bool isOnline,
    required bool isPinned,
  }) {
    const Color primaryColor = Color(0xFF5F259F);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isPinned ? primaryColor.withOpacity(0.15) : Colors.grey.shade100,
              width: isPinned ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [avatarColor, avatarColor.withOpacity(0.6)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: avatarColor.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (isOnline)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isPinned)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF59E0B),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.push_pin_rounded,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: isPinned ? primaryColor : const Color(0xFF1E293B),
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage,
                            style: TextStyle(
                              fontSize: 13,
                              color: unreadCount > 0 ? const Color(0xFF1E293B) : Colors.grey.shade600,
                              fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Row(
            children: [
              if (unreadCount > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, const Color(0xFF7C3AED)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              PopupMenuButton(
                color: Colors.white,
                elevation: 1,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black87,
                  size: 26,
                ),
                onSelected: (value) {},
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'pin',
                    child: Row(
                      children: [
                        Icon(Icons.push_pin_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Pin Chat'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'mute',
                    child: Row(
                      children: [
                        Icon(Icons.notifications_off_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Mute Notifications'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'archive',
                    child: Row(
                      children: [
                        Icon(Icons.archive_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Archive Chat'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_rounded, size: 18, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete Chat', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}