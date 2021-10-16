import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/pages/home/home-page.dart';
import 'package:flutter/material.dart';

import 'login-bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();

  String imagemFundo = 'https://ufsj.edu.br/portal2-repositorio/File/dce/ufsj_ctan_site.jpg';
  String logo = 'https://ufsj.edu.br/portal2-images/menu-logo_menor.png';

  AnimationController animation;

  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    bloc.outLogado.listen((data) {
      if(data)
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => HomePage())
        );
    });
    animation = AnimationController(vsync: this, duration: Duration(seconds: 10),);
    animation.forward();
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) animation.reverse();
      else if(status == AnimationStatus.dismissed) animation.forward();
    });
    // animation.addListener(() => print(animation.value));
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Material(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Opacity(
              opacity: 0.38,
              child: AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Image.network(
                    imagemFundo,
                    fit: BoxFit.cover,
                    alignment: Alignment.lerp(
                      Alignment.centerLeft,
                      Alignment.centerRight,
                      animation.value
                    )
                  );
                },
              ),
            )
          ),
          Center(
            child: Container(
              width: 270,
              height: 300,
              decoration: BoxDecoration(
                // border: Border.all()
                color: Colors.white.withOpacity(0.92),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26.0,
                  vertical: 6
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.network(logo, width: 70,),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Cpf'
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: FlatButton(
                        color: Color.fromRGBO(192, 38, 46, 1),
                        onPressed: () => bloc.logar(_username, _password),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30.0),
                          child: Text('Entrar', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}