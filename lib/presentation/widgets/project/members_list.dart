import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collab/domain/entities/user.dart';

class MembersList extends StatelessWidget {
  final List<User> members;
  final User? currentUser;
  final Function(String userId)? onRemoveMember;

  const MembersList({
    super.key,
    required this.members,
    this.currentUser,
    this.onRemoveMember,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        final isCurrentUser = currentUser?.id == member.id;

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: member.photoUrl != null
                ? NetworkImage(member.photoUrl!)
                : null,
            child: member.photoUrl == null
                ? Text(member.name?[0].toUpperCase() ?? member.email[0].toUpperCase())
                : null,
          ),
          title: Text(
            member.name ?? member.email,
            style: TextStyle(
              fontWeight: isCurrentUser ? FontWeight.bold : null,
            ),
          ),
          subtitle: isCurrentUser ? const Text('You') : null,
          trailing: onRemoveMember != null && !isCurrentUser
              ? IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => onRemoveMember!(member.id),
                )
              : null,
        );
      },
    );
  }
} 