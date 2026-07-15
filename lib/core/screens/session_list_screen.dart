import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/connection_manager.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';
import 'memory_screen.dart';
import 'cron_screen.dart';
import 'skills_screen.dart';

class SessionListScreen extends StatefulWidget {
  final SavedConnection connection;
  const SessionListScreen({required this.connection, super.key});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  late final ApiClient _client;
  List<Session> _sessions = [];
  bool _loading = true;
  String? _error;
  bool _healthOk = false;
  final Set<String> _deletingSessionIds = {};

  @override
  void initState() {
    super.initState();
    _client = ApiClient(
      baseUrl: widget.connection.baseUrl,
      apiKey: widget.connection.apiKey,
      pathPrefix: widget.connection.gatewayPrefix ?? '',
    );
    _checkHealth();
  }

  Future<void> _checkHealth() async {
    final ok = await _client.healthCheck();
    setState(() => _healthOk = ok);
    if (ok) _fetchSessions();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  Future<void> _fetchSessions() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final sessions = await _client.getSessions();
      if (!mounted) return;
      setState(() {
        _sessions = sessions;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _confirmDeleteSession(Session session) async {
    final title = session.title.trim().isEmpty
        ? '未命名会话'
        : session.title;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('删除会话？'),
        content: Text(
          '将 "$title" 从远程 Hermes 历史中删除？此操作不可撤销。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('取消'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _deleteSession(session);
    }
  }

  Future<void> _deleteSession(Session session) async {
    if (_deletingSessionIds.contains(session.id)) return;
    setState(() => _deletingSessionIds.add(session.id));

    try {
      await _client.deleteSession(session.id);
      if (!mounted) return;
      setState(() {
        _sessions.removeWhere((item) => item.id == session.id);
        _deletingSessionIds.remove(session.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已从远程 Hermes 删除会话。')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _deletingSessionIds.remove(session.id));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('无法删除会话：$e')));
    }
  }

  void _createNewSession() {
    final sessionId = GatewayChatClient.generateSessionId();
    final session = Session(
      id: sessionId,
      title: '新建会话',
      model: 'hermes-agent',
      source: 'mobile',
      messageCount: 0,
      isActive: true,
      preview: '',
      startedAt: DateTime.now().millisecondsSinceEpoch.toDouble() / 1000,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ChatScreen(connection: widget.connection, session: session),
      ),
    );
  }

  String _formatTime(double ts) {
    final dt = DateTime.fromMillisecondsSinceEpoch((ts * 1000).toInt());
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.day}/${dt.month}';
  }

  void _openScreen(Widget screen) {
    Navigator.pop(context); // close drawer
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HERMES',
          style: GoogleFonts.cinzel(
            fontWeight: FontWeight.w700,
            letterSpacing: 6,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          if (!_healthOk)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.warning_amber, color: Colors.orange, size: 20),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loading ? null : _fetchSessions,
          ),
        ],
      ),
      drawer: _buildDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: '新建会话',
        onPressed: _createNewSession,
        child: const Icon(Icons.chat, color: Colors.black),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Brand header in drawer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'HERMES',
                    style: GoogleFonts.cinzel(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFD4AF37),
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.connection.label,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.memory),
              title: const Text('记忆'),
              onTap: () =>
                  _openScreen(MemoryScreen(connection: widget.connection)),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('定时任务'),
              onTap: () =>
                  _openScreen(CronScreen(connection: widget.connection)),
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome),
              title: const Text('技能'),
              onTap: () =>
                  _openScreen(SkillsScreen(connection: widget.connection)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('设置'),
              onTap: () =>
                  _openScreen(SettingsScreen(connection: widget.connection)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (!_healthOk) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 16),
            Text(
              '正在连接 ${widget.connection.baseUrl}...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '请确保网关 API 服务正在运行\\n（执行 hermes gateway status 查看）',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _checkHealth, child: const Text('重试')),
          ],
        ),
      );
    }

    if (_loading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              '连接问题',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _error!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fetchSessions,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              '暂无会话',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '点击 + 按钮开始新会话',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchSessions,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sessions.length,
        itemBuilder: (context, index) {
          final session = _sessions[index];
          final isDeleting = _deletingSessionIds.contains(session.id);
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              enabled: !isDeleting,
              leading: Icon(
                session.isActive ? Icons.chat : Icons.chat_bubble_outline,
                color: session.isActive ? const Color(0xFFD4AF37) : Colors.grey,
              ),
              trailing: isDeleting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              title: Text(
                session.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${session.messageCount} msgs \u2022 ${session.model} \u2022 ${_formatTime(session.startedAt)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (session.preview.isNotEmpty)
                    Text(
                      session.preview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                    ),
                ],
              ),
              isThreeLine: session.preview.isNotEmpty,
              onLongPress: isDeleting
                  ? null
                  : () => _confirmDeleteSession(session),
              onTap: isDeleting
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            connection: widget.connection,
                            session: session,
                          ),
                        ),
                      );
                    },
            ),
          );
        },
      ),
    );
  }
}
