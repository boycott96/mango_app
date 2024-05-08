import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/api/file.dart';
import 'package:flutter_application_test/api/user.dart';
import 'package:flutter_application_test/components/toast_manager.dart';
import 'package:flutter_application_test/pages/main_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic> profile;
  const EditProfile({super.key, required this.profile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _nameController = TextEditingController();

  bool _editAvatar = false;
  bool _editName = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.profile['name'];
    });
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitEdit() async {
    Map<String, dynamic> params = {
      "avatarUrl": newAvatarUrl,
      "name": _nameController.text
    };
    Response response = await UserService(context).updateInfo(params);
    if (response.data['code'] == 0) {
      ToastManager.showToast("Update success!");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  final picker = ImagePicker();
  late String newAvatarUrl = '';

  Future<void> requestPermission() async {}

  Future getImage() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          MultipartFile.fromFile(pickedFile.path,
                  filename: pickedFile.path.split('/').last)
              .then((file) {
            FormData formData = FormData.fromMap({'file': file});
            FileService(context).uploadFile(formData).then((response) {
              if (response.data['code'] == 0) {
                setState(() {
                  newAvatarUrl = response.data['data'];
                });
              }
            });
          });
        }
      });
    } else {
      // 权限被拒绝
    }
  }

  final List<String> items = List.generate(5, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(249, 249, 249, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _editAvatar = !_editAvatar;
                      _editName = false;
                    });
                  },
                  child: Container(
                    margin: _editAvatar
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: _editAvatar || _editName
                          ? BorderRadius.circular(30)
                          : const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Avatar",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!_editAvatar)
                              SvgPicture.asset(
                                "assets/icon/arrow_right_thin.svg",
                                width: 20,
                                height: 20,
                                theme: const SvgTheme(
                                  currentColor:
                                      Color.fromRGBO(211, 215, 222, 1),
                                ),
                              ),
                          ],
                        ),
                        if (_editAvatar)
                          Container(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              children: [
                                const Text(
                                  "Upload photos with clear face.Include you(and your parther)only.",
                                  style: TextStyle(
                                    color: Color.fromRGBO(135, 141, 152, 1),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          widget.profile['avatarUrl'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          getImage();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromRGBO(
                                                      248, 249, 250, 1)),
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(80, 80)),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 40,
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                      ),
                                      if (newAvatarUrl == '')
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            "assets/none_avatar.png",
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      if (newAvatarUrl != '')
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            newAvatarUrl,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _editName = !_editName;
                      _editAvatar = false;
                    });
                  },
                  child: Container(
                    margin: _editName
                        ? const EdgeInsets.only(top: 20)
                        : EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: _editName
                          ? BorderRadius.circular(30)
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "My name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!_editName)
                              SvgPicture.asset(
                                "assets/icon/arrow_right_thin.svg",
                                width: 20,
                                height: 20,
                                theme: const SvgTheme(
                                  currentColor:
                                      Color.fromRGBO(211, 215, 222, 1),
                                ),
                              ),
                          ],
                        ),
                        if (_editName)
                          TextField(
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 20),
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(173, 181, 189, 1)),
                            ),
                            controller: _nameController,
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 12),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        const Color.fromRGBO(255, 93, 151, 1)),
                  ),
                  onPressed: () {
                    _submitEdit();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
