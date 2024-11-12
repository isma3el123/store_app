import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';
import 'package:store_app/core/widgets/custom_textfaild.dart';

class UserUpdateBody extends StatefulWidget {
  const UserUpdateBody({super.key});

  @override
  _UserUpdateBodyState createState() => _UserUpdateBodyState();
}

class _UserUpdateBodyState extends State<UserUpdateBody> {
  String email = '';
  String password = '';
  String phone = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 205, 141),
        title: const Text("Personal"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFaild(
              obscureText: false,
              onchange: (value) {
                setState(() {
                  email = value;
                });
              },
              hintText: "Email",
            ),
            SizedBox(height: 15),
            CustomTextFaild(
              obscureText: false,
              onchange: (value) {
                setState(() {
                  password = value;
                });
              },
              hintText: "Password",
            ),
            SizedBox(height: 15),
            CustomTextFaild(
              obscureText: false,
              onchange: (value) {
                setState(() {
                  name = value;
                });
              },
              hintText: "Name",
            ),
            SizedBox(height: 15),
            CustomTextFaild(
              obscureText: false,
              onchange: (value) {
                setState(() {
                  phone = value;
                });
              },
              hintText: "Phone",
            ),
            SizedBox(height: 15),
            InkWell(
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 7, 30, 133)),
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                print("object");
                cubit.updateDataUser(
                    email: email, phone: phone, name: name, password: password);
              },
            )
          ],
        ),
      ),
    );
  }
}
