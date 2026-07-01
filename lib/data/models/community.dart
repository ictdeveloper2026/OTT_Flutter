// Community feature models: content suggestions and polls.

class Suggestion {
  final String id;
  final String title;
  final String? description;
  final String status; // open | planned | added | rejected | promoted
  final int upvoteCount;
  final bool hasVoted;
  final String? linkedContentId;
  final DateTime? createdAt;

  const Suggestion({
    required this.id,
    required this.title,
    this.description,
    this.status = 'open',
    this.upvoteCount = 0,
    this.hasVoted = false,
    this.linkedContentId,
    this.createdAt,
  });

  factory Suggestion.fromJson(Map<String, dynamic> j) => Suggestion(
        id: (j['id'] ?? '').toString(),
        title: (j['title'] ?? '').toString(),
        description: j['description'] as String?,
        status: (j['status'] ?? 'open').toString(),
        upvoteCount: (j['upvoteCount'] ?? 0) as int,
        hasVoted: (j['hasVoted'] ?? false) as bool,
        linkedContentId: j['linkedContentId'] as String?,
        createdAt: DateTime.tryParse((j['createdAt'] ?? '').toString()),
      );
}

class PollOption {
  final String id;
  final String text;
  final int voteCount;
  final String? linkedContentId;

  const PollOption({required this.id, required this.text, this.voteCount = 0, this.linkedContentId});

  factory PollOption.fromJson(Map<String, dynamic> j) => PollOption(
        id: (j['id'] ?? '').toString(),
        text: (j['text'] ?? '').toString(),
        voteCount: (j['voteCount'] ?? 0) as int,
        linkedContentId: j['linkedContentId'] as String?,
      );
}

class Poll {
  final String id;
  final String question;
  final String? description;
  final String status; // open | closed
  final DateTime? endsAt;
  final DateTime? createdAt;
  final int totalVotes;
  final String? myOptionId;
  final List<PollOption> options;

  const Poll({
    required this.id,
    required this.question,
    this.description,
    this.status = 'open',
    this.endsAt,
    this.createdAt,
    this.totalVotes = 0,
    this.myOptionId,
    this.options = const [],
  });

  bool get isClosed => status == 'closed';
  bool get hasVoted => myOptionId != null;

  factory Poll.fromJson(Map<String, dynamic> j) => Poll(
        id: (j['id'] ?? '').toString(),
        question: (j['question'] ?? '').toString(),
        description: j['description'] as String?,
        status: (j['status'] ?? 'open').toString(),
        endsAt: DateTime.tryParse((j['endsAt'] ?? '').toString()),
        createdAt: DateTime.tryParse((j['createdAt'] ?? '').toString()),
        totalVotes: (j['totalVotes'] ?? 0) as int,
        myOptionId: j['myOptionId'] as String?,
        options: ((j['options'] ?? const []) as List)
            .map((e) => PollOption.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
}
