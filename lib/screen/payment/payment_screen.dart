import 'package:flutter/material.dart';
import 'package:notifiction/screen/login/common/common.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Razorpay _razorpay = Razorpay();
  final _formPaymentKey = GlobalKey<FormState>();

  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Screen"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formPaymentKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                commonTxtField(
                  labelText: "Name",
                  icon: Icons.person,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                commonTxtField(
                  labelText: "Email",
                  icon: Icons.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                commonTxtField(
                  labelText: "Phone Number",
                  icon: Icons.phone,
                  controller: contactController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                commonTxtField(
                  labelText: "Amount",
                  icon: Icons.attach_money_outlined,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                commonTxtField(
                  labelText: "description",
                  icon: Icons.description,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Center(
                  child: MaterialButton(
                    color: Colors.black,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      disposeKeyboard(context);
                      if (_formPaymentKey.currentState!.validate()) {
                        var options = {
                          'key': 'rzp_live_ILgsfZCZoFIKMb',
                          'amount':
                              int.parse(amountController.text.toString()) * 100,
                          'name': nameController.text.toString(),
                          'description': descriptionController.text.toString(),
                          'prefill': {
                            'contact': contactController.text.toString(),
                            'email': emailController.text.toString(),
                          },
                        };
                        _razorpay.open(options);
                        print("amount ===> ${amountController.text}");
                        print("name ===> ${nameController.text}");
                        print("description ===> ${descriptionController.text}");
                        print("contact ===> ${contactController.text}");
                        print("email ===> ${emailController.text}");
                      }
                    },
                    child: const Text(
                      "Pay Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    /// Do something when payment succeeds
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Success: ${response.paymentId}"),
        backgroundColor: Colors.green,
        // duration: const Duration(seconds: 2),
      ),
    );
    nameController.clear();
    emailController.clear();
    contactController.clear();
    amountController.clear();
    descriptionController.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    /// Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Payment faild"),
        backgroundColor: Colors.red,
        // duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    /// Do something when an external wallet was selected
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Payment Success"),
      backgroundColor: Colors.green,
    ));
  }
}
