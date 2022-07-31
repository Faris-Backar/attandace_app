import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableActionWidget extends StatelessWidget {
  final int index;
  final Widget child;
  final Function()? ontap;

  const SlidableActionWidget({
    Key? key,
    required this.index,
    required this.child,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: ValueKey(index),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: .3,
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    actions: [
                      MaterialButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: ontap,
                        child: const Text('Delete'),
                      ),
                    ],
                    content: const Text(
                      'Press Delete button to confirm your action',
                    ),
                  ),
                );
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: child);
  }
}
