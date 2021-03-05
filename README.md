## Seadistamine
<b>Windowsile installeerimine</b>

1. Järgnevalt URL'ilt lae alla uusim Flutteri SDK
https://flutter.dev/docs/get-started/install/windows 
2. Paki lahti ZIP arhiiv kaustas, näiteks C:\flutter\
3. Uuenda süsteemi path'i, et kaasata Flutter bin directory'sse
4. Flutteriga tuleb kaasa tööriist flutter doctor, et kontrollida kõiki tööks vajalikke meetmeid
5. Käivita järgmine käsk: flutter doctor
6. Antud käsk analüüsib süsteemi ning näitab selle raportit
7. Installi uusim Android SDK, kui flutter doctor seda raporteeris
8. Installi uusim Android Studio, kui flutter doctor seda raporteeris
9. Installi Flutter ja Dart'i plugin Android Studiole. See tagab startup template, et luua uus Flutteri aplikatsioon, võimaluse käivitada ja debugida Flutteri aplikatsiooni Android Studios endas: 

9.1 Ava Android Studio.<br>
9.2 Vajuta File → Settings → Plugins.<br>
9.3 Vali Flutteri plugin and vajuta Install.<br>
9.4 Vajuta Yes, kui soovitakse installida Darti plugin.<br>
9.5 Restarti Android studio.

<b>Macile installeerimine</b>

1. Järgnevalt URL'ilt lae alla uusim Flutteri SDK
https://flutter.dev/docs/get-started/install/macos
2. Paki lahti ZIP arhiiv kaustas, näiteks /path/to/flutter
3. Uuenda süsteemi path'i, et kaasata Flutter bin directory'sse (in ~/.bashrc file)
Käivitades käsu: > export PATH = "$PATH:/path/to/flutter/bin"
4. Luba uuendatud pathi praeguses sessioonis kasutades järgmist käsku, seega kinnita see: 
source ~/.bashrc
source $HOME/.bash_profile
echo $PATH
5. Antud käsk analüüsib süsteemi ning näitab selle raportit
6. Installi uusim XCode, kui flutter doctor seda raporteeris
7. Installi uusim Android SDK, kui flutter doctor seda raporteeris
8. Installi uusim Android Studio, kui flutter doctor seda raporteeris
9. Ava Androidi emulaator 
10. Käivita IOS simulaator
11. Installi Flutter ja Dart'i plugin Android Studiole. See tagab startup template, et luua uus Flutteri aplikatsioon, võimaluse käivitada ja debugida Flutteri aplikatsiooni Android Studios endas: 

9.1 Ava Android Studio.<br>
9.2 Vajuta Preferences -> Plugins.<br>
9.3 Vali Flutteri plugin and vajuta Install.<br>
9.4 Vajuta Yes, kui soovitakse installida Darti plugin.<br>
9.5 Restarti Android studio.


## mis osutus kergeks
Ülesande 1:
Android Studio installimine, kõik hakkas ilusti tööle, ka emulaator

ÜLESANDE 3:
url'i kaudu videot mängivad


## mis osutus raskeks
Ülesande 1:
Oli mitu veateadet, kui proovisime füüsilist seadet ühendada. Oli vaja välja nuputada, mida vaja telefoni settingutes ümber muuta.
Gitiga olid probleemid, et ei leidnud path'i

ÜLESANDE 3:
lisatud video assets'ina ei mängi(siiamaani ei saa aru miks)
pubspec.yaml file'iga olid probleemid formateeringu pärast



