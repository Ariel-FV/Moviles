import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/settings/style_settings.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled=false;

  @override
  Widget build(BuildContext context) {

    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Social Tec'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            
            UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://guide-minecraft.com/wp-content/uploads/2021/03/mod-goblin-traders-1.jpg'),
            ),  
            accountName: Text('Pepe'), 
            accountEmail: Text('pepe@gmail.com')
            ),
            ListTile(
              title: Text('Practica 1'),
              subtitle: Text('Descripcion de la practica'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
             DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled,
              onStateChanged: (isDarkModeEnabled) {
                isDarkModeEnabled
                    ? theme.setthemeData(StylesSettings.darkTheme(context))
                    : theme.setthemeData(StylesSettings.lightTheme(context));
                this.isDarkModeEnabled = isDarkModeEnabled;
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}