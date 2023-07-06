import 'package:api_fetch_bloc/users/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User List"), centerTitle: true, elevation: 1.0),
      body: BlocProvider(
        create: (context) => UserBloc()..add(GetUserEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.userList;
              final thm = Theme.of(context);
              return ListView.builder(
                itemCount: state.userList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user[index].name ?? '',
                            style: thm.textTheme.bodyLarge,
                          ),
                          ...[
                            {
                              "iconData": Icons.person_outline_rounded,
                              "text": "@${user[index].username ?? ''}",
                              "textStyle": thm.textTheme.bodySmall!.copyWith(color: Colors.blue)
                            },
                            {"iconData": Icons.email_outlined, "text": user[index].email ?? ''},
                            {"iconData": Icons.work_outline_rounded, "text": user[index].company?.name ?? ''},
                            {"iconData": Icons.pin_drop_outlined, "text": user[index].address?.city ?? ''},
                          ].map(
                            (e) => Row(
                              children: [
                                Icon(e["iconData"] as IconData, size: 16),
                                const SizedBox(width: 8.0),
                                Text(
                                  e["text"] as String,
                                  style: (e["textStyle"] ?? thm.textTheme.bodySmall) as TextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.error ?? "Something went wrong"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
