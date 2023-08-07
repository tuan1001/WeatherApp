// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ContainerShadow extends StatelessWidget {
  final Widget body;
  final void Function()? onTap;
  final double? raidus;
  const ContainerShadow({
    Key? key,
    required this.body,
    this.onTap,
    this.raidus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: BorderRadius.all(Radius.circular(raidus ?? 0)), boxShadow: const []),
          child: body),
    );
  }
}
