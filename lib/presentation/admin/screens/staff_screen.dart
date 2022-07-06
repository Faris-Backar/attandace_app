import 'dart:developer';

import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/presentation/admin/screens/create_staff_screen.dart';
import 'package:attandance_app/presentation/bloc/staff/staff_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffScreen extends StatefulWidget {
  static const routeName = '/StaffScreen';
  const StaffScreen({Key? key}) : super(key: key);

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  List<Staff> staffList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StaffBloc>(context).add(GetStaffEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: StyleResources.primaryColor,
          title: const Text(
            'Staff',
            style: TextStyle(
              color: StyleResources.accentColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  CreateStaffScreen.routeName,
                );
              },
              icon: const Icon(Icons.person_add_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: Config.defaultPadding(),
          child: BlocBuilder<StaffBloc, StaffState>(
            builder: (context, state) {
              if (state is StaffLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: StyleResources.primaryColor,
                  ),
                );
              }
              if (state is GetStaffLoaded) {
                staffList = state.staffList;
                log(staffList.toString());
                if (staffList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Staff Found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: staffList.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.grey[200],
                    elevation: 5.0,
                    child: ListTile(
                      onTap: () => Navigator.of(context).pushNamed(
                          CreateStaffScreen.routeName,
                          arguments: [staffList[index], index]),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: StyleResources.primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          staffList[index].name[0].toUpperCase(),
                          style: const TextStyle(
                              color: StyleResources.accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      title: Text(
                        staffList[index].name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(staffList[index].branch),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
