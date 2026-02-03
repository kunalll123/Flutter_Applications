import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wroom_application/features/auth/pages/dashboard_page.dart';
import 'package:wroom_application/features/auth/pages/otp_page.dart';
import 'package:wroom_application/features/auth/pages/presentation/widgets/custom_text_field.dart';
import 'package:wroom_application/features/auth/pages/signin_screen.dart';
import '../../../../core/theme/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isAcceptingTerms = false;
  bool _isLoading = false;

  void _navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
      (route) => false,
    );
  }

  Future<void> _initiateRegistration() async {
    if (!_isAcceptingTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Accept terms and conditions")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
          setState(() => _isLoading = false);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() => _isLoading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(
                verificationId: verificationId,
                name: _nameController.text.trim(),
                email: _emailController.text.trim(),
                phone: _phoneController.text.trim(),
                password: _passwordController.text.trim(),
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error sending SMS")));
    }
  }

  // FIXED: Corrected Google Sign-In Method for modern google_sign_in versions
  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      // 1. Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() => _isLoading = false);
        return; // User canceled the sign-in
      }

      // 2. Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with the Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // 5. Save data to Firestore if this is a new user
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'uid': userCredential.user!.uid,
          'name': userCredential.user!.displayName ?? "New User",
          'email': userCredential.user!.email,
          'phone': userCredential.user!.phoneNumber ?? "",
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      _navigateToDashboard();
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Sign-In failed: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF01C09A)))
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                child: Column(
                  children: [
                    // const SizedBox(height: 20),
                    // Image.asset(
                    //   'assets/images/wroom_logo.png',
                    //   height: 80,
                    // ),
                    // const SizedBox(height: 30),
                    Text(
                      "Welcome to WROOM",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                        controller: _nameController,
                        hintText: "Name",
                        icon: Icons.person_outline),
                    AuthTextField(
                        controller: _phoneController,
                        hintText: "Mobile Number",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone),
                    AuthTextField(
                        controller: _emailController,
                        hintText: "Email",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress),
                    AuthTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        icon: Icons.lock_outline,
                        obscureText: true),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _initiateRegistration,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brandTeal,
                            shape: const StadiumBorder()),
                        child: const Text(
                          "REGISTER NOW",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Skip for Now >>",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF01C09A),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isAcceptingTerms,
                          onChanged: (val) =>
                              setState(() => _isAcceptingTerms = val ?? false),
                          activeColor: AppColors.brandTeal,
                        ),
                        const Expanded(
                          child: Text(
                            "Accept all the requirements that we have provided.",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or continue with",
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: _signInWithGoogle,
                            child: _socialIcon('assets/images/google.png')),
                        const SizedBox(width: 15),
                        _socialIcon('assets/images/apple.png'),
                        const SizedBox(width: 15),
                        _socialIcon('assets/images/facebook.png'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already registered? ",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF01C09A),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF003229),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Container(
      width: 80,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Image.asset(assetPath, height: 25, width: 25),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
