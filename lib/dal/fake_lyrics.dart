import 'package:lipl_bloc/dal/dal.dart';
import 'package:lipl_bloc/model/model.dart';

List<Lyric> fakeLyricsSortedByTitle() {
  final List<Lyric> lyrics = fakeLyrics();
  lyrics.sort(
    (Lyric a, Lyric b) => a.title.compareTo(b.title),
  );
  return lyrics;
}

List<Playlist> fakePlaylistsSortedByTitle() {
  final List<Playlist> playlists = fakePlaylists();
  playlists.sort(
    (Playlist a, Playlist b) => a.title.compareTo(b.title),
  );
  return playlists;
}

List<Lyric> fakeLyrics() => <Lyric>[
      const Lyric(
          id: 'juUgRTiUHpktJBNZxLYG5',
          title: 'Patsy',
          parts: <List<String>>[
            <String>[
              'Vlak bij de haven staan heel oude huizen',
              'Somber en donker, bouwvallig en koud',
              'Daar woont een meisje, ze noemen haar Patsy',
              'Zij is het meisje, dat veel van me houdt.'
            ],
            <String>[
              'Kaal en versleten zijn Patsy haar kleren',
              'Ondanks die kleren hoort Patsy bij mij',
              'Thuis wil geen mens van mijn meisje iets weten',
              'Toch gaat mijn liefde voor haar nooit voorbij'
            ],
            <String>[
              'Patsy, ik hoor toch bij jou',
              'Nooit wil ’k een ander als vrouw',
              'Ook al woon je in een krot',
              'Met de huisdeur kapot',
              'Je weet toch hoeveel ’k van je hou.'
            ],
            <String>[
              'Iedere nacht lig ik rust’loos te dromen',
              '’k zie hoe je wacht in die sombere straat',
              'Denkend dat ik niet meer bij je zal komen',
              'Maar als ik kom is ’t misschien al te laat.'
            ],
            <String>[
              'Laatst vroeg een buurman heel zachtjes aan vader:',
              'Ken jij die Patsy, ze kwam wel eens hier',
              '’t Meisje is vroeg aan haar einde gekomen',
              'Gisteren vond men haar in de rivier'
            ],
            <String>[
              'Patsy, ik hoor toch bij jou',
              'Nooit wil ’k een ander als vrouw',
              'M’n geluk is voorbij',
              'Jij bent niet meer bij mij',
              'Patsy straks kom ik bij jou'
            ]
          ]),
      const Lyric(
          id: 'DrCZCmVwxEgKG6Qqfe9WsZ',
          title: 'Twee ogen zo blauw',
          parts: <List<String>>[
            <String>[
              'Als de lente de bomen en struiken',
              'weer met geuren en kleuren bestrooid',
              'dan begint ook het hart te ontluiken',
              'want de liefde verandert toch nooit',
              'elke jongen kiest zich dan een meisje',
              'en hij fluistert haar zachtjes in \'t oor',
              'het sinds eeuwen geliefkoosde wijsje',
              'en dat vind in haar hartje gehoor'
            ],
            <String>[
              'Twee ogen zo blauw',
              'zo innig en trouw',
              'al mijn geluk zijn die kijkers van jouw',
              'Twee ogen zo blauw'
            ],
            <String>[
              'Heeft hij haar tot zijn vrouwtje gekozen',
              'Blij het oog op de toekomst gericht',
              'gaat hun pad ook niet steeds over rozen',
              'iets toch maakt dan hun levensstrijd licht',
              'want bij vreugde en leed hen beschoren',
              'verschijnt dra wat voor immer hen bindt',
              'als de eersteling hen wordt geboren',
              'moeders zingt bij de wieg van haar kind'
            ],
            <String>[
              'Twee ogen zo blauw',
              'zo innig en trouw',
              'al mijn geluk zijn die kijkers van jouw',
              'Twee ogen zo blauw'
            ],
            <String>[
              'Als de grijsaard vermoeid en versleten',
              'Niets in \'t leven van waarde meer acht',
              'Als door allen verlaten vergeten',
              'Hij alleen op \'t einde maar wacht',
              'Is hem toch de herinnering gebleven',
              'die hem koestert in \'t eenzaamste uur',
              '\'t is zijn laatste sprank warmte in \'t leven',
              'en hij neuriet bij \'t knappende vuur'
            ],
            <String>[
              'Twee ogen zo blauw',
              'zo innig en trouw',
              'al mijn geluk zijn die kijkers van jouw',
              'Twee ogen zo blauw'
            ]
          ]),
      const Lyric(
          id: 'BPQ2pSbpEapUnxA8dBSRAh',
          title: 'Eer zij god in onze dagen',
          parts: <List<String>>[
            <String>[
              'Eer zij God in onze dagen',
              'eer zij God in deze tijd',
              'mensen van het welbehagen',
              'roept op aarde vrede uit',
              'Gloria in excelsis Deo',
              'Gloria in excelsis Deo'
            ],
            <String>[
              'Eer zij God die onze Vader',
              'en die onze Koning is',
              'Eer zij God die op de aarde',
              'naar ons toe gekomen is',
              'Gloria in excelsis Deo',
              'Gloria in excelsis Deo'
            ],
            <String>[
              'Lam van God, Gij hebt gedragen',
              'alle schuld tot elke prijs',
              'geef in onze levensdagen',
              'peis en vree, kyrieleis',
              'Gloria in excelsis Deo',
              'Gloria in excelsis Deo'
            ]
          ]),
      const Lyric(
          id: 'HvBRBoaHh4rNsWVJgZNRvY',
          title: 'Catootje',
          parts: <List<String>>[
            <String>[
              'Ik ben met Catootje naar de botermarkt gegaan,',
              'Ze kon maken wat ze wou (4x)',
              'En ze maakte van boter een dominee,',
              'een dominee pardoes.',
              'In de kark, in de kark zei de dominee. (2x)',
              'Een domi-domi-nee, een domi-domi-nee',
              'en mijn zuster die heet Kee (2x)'
            ],
            <String>[
              'Dominee: In de kark, in de kark',
              'Wafelvrouw: Kom maar binnen, kom maar binnen',
              'Toverheks: \'k Zal je pakken, \'k zal je pakken',
              'Kastelein: Eerst betalen, eerst betalen',
              'Barones: In de suite, in de suite',
              'Lichtmatroos: Mooie bene, mooie bene,',
              'Dikke meid: Lekker zoenen, lekker zoenen',
              'Ouwe heer: Heel voorzichtig, heel voorzichtig'
            ]
          ]),
      const Lyric(
          id: 'CvJphEtLHUak3BrD8cYcTD',
          title: 'De herdertjes lagen bij nachte',
          parts: <List<String>>[
            <String>[
              'De herdertjes lagen bij nachte',
              'Zij lagen bij nacht in het veld',
              'Zij hielden vol trouwe de wachte',
              'Zij hadden hun schaapjes geteld',
              'Daar hoorden zij d\'engelen zingen',
              'Hun liederen vloeiend en klaar',
              'De herders naar Bethlehem gingen',
              '\'t liep tegen het nieuwe jaar'
            ],
            <String>[
              'Toen zij er te Bethlehem kwamen',
              'Daar schoten drie stralen dooreen',
              'Een straal van omhoog zij vernamen',
              'Een straal uit het kribje benee',
              'Daar vlamd\' er een straal uit hun ogen',
              'En viel op het Kindeke teer',
              'Zij stonden tot schreiens bewogen',
              'En knielden bij Jesus neer'
            ],
            <String>[
              'Maria die bloosde van weelde',
              'Van ootmoed en lieflijke vreugd',
              'De goede Sint Jozef hij streelde',
              'Het Kindje der mensen geneugt',
              'De herders bevalen te weiden',
              'Hun schaapkens aan d\'engelenschaar',
              'Wij kunnen van \'t kribje niet scheiden',
              'Wij wachten het nieuwe jaar'
            ],
            <String>[
              'Ach kindje, ach kindje, dat heden',
              'In \'t nederig stalletje kwaamt',
              'Ach, laat ons uw paden betreden',
              'Want gij hebt de wereld beschaamd',
              'Gij kwaamt om de wereld te winnen',
              'De machtigste vijand te slaan',
              'De kracht uwer liefde van binnen',
              'Kan wereld noch hel weerstaan'
            ]
          ]),
      const Lyric(
          id: 'YZYNGuBbi2GAcndpBqNeDk',
          title: 'Tulpen uit Amsterdam',
          parts: <List<String>>[
            <String>[
              'Als de lente komt dan stuur ik jou',
              'tulpen uit Amsterdam.',
              'Als de lente komt pluk ik voor jou',
              'tulpen uit Amsterdam.',
              'Als ik wederkom dan breng ik jou',
              'tulpen uit Amsterdam.',
              'Duizend gele, duizend rooie,',
              'wensen jou het allermooiste.',
              'Wat m\'n mond niet zeggen kan',
              'zeggen tulpen uit Amsterdam.'
            ]
          ]),
      const Lyric(
          id: '5nvzTdbkAJuEHGNEdiuK2J',
          title: 'Breng eens een zonnetje',
          parts: <List<String>>[
            <String>[
              'Het leven dat is geen pretje',
              'Ik weet er alles van',
              'Ben je bedrukt, verzet je',
              'Maak er van wat je kan',
              'Als je het geluk wilt zoeken',
              'Hangt aan een zijde draad',
              'En je succes wilt boeken',
              'Luister dan naar mijn raad'
            ],
            <String>[
              'Breng eens een zonnetje onder de mensen',
              'Een blij gezicht te zien doet je toch goed',
              'Vervul zo nu en dan hun liefste wensen',
              'Een beetje levensvreugd schenkt nieuwe moed',
              'Breng eens een zonnetje onder de mensen',
              'Een blij gezicht te zien doet je toch goed',
              'Vervul zo nu en dan de liefste wensen',
              'Het spreekwoord zegt "wie goed doet goed ontmoet"'
            ],
            <String>[
              'Kun je wat over sparen',
              'Gaat het je zakelijk goed',
              'Blijf dan niet aan het vergaren',
              'Maar geef wat uit, dat moet',
              'Leven en laten leven',
              'Daar komt het hier op aan',
              'Kun je aan anderen geven',
              'Het duet gewent spontaan'
            ],
            <String>[
              'Breng eens een zonnetje onder de mensen',
              'Een blij gezicht te zien doet je toch goed',
              'Vervul zo nu en dan hun liefste wensen',
              'Een beetje levensvreugd schenkt nieuwe moed',
              'Breng eens een zonnetje onder de mensen',
              'Een blij gezicht te zien doet je toch goed',
              'Vervul zo nu en dan de liefste wensen',
              'Het spreekwoord zegt "wie goed doet goed ontmoet"'
            ],
            <String>[
              'En heb je niets te schenken,',
              'Heb je noch geld noch goed,',
              'Kan je, wil je dat bedenken,',
              'Troost brengen waar het moet;',
              'Mooie gedacht\' en daden',
              'Brengen ook zonneschijn',
              'Maak dat op doornen paden',
              'Ook nog wat rozen zijn.'
            ],
            <String>[
              'Breng eens een zonnetje onder de mensen',
              'Een blij gezicht te zien doet je toch goed',
              'Vervul zo nu en dan hun liefste wensen',
              'Een beetje levensvreugd schenkt nieuwe moed',
              'Breng eens een zonnetje onder de mensen',
              'Een blij gezicht te zien doet je toch goed',
              'Vervul zo nu en dan de liefste wensen',
              'Het spreekwoord zegt \'wie goed doet goed ontmoet\''
            ]
          ]),
      const Lyric(
          id: 'PmcBWkdavNtBR8aJTKmAow',
          title: 'Suiker in de erwtensoep',
          parts: <List<String>>[
            <String>[
              'Er was in \'t militaire kamp',
              'een grote consternatie!',
              'Niet meer of minder dan een ramp',
              'bedreigde onze Natie!',
              'De erwtensoep was zwaar mislukt',
              'en ied\'reen zong bedrukt:'
            ],
            <String>[
              'Wie! Wie! Wie!',
              'Wie! Wie! Wie!',
              'Wie heeft er suiker in de erwtensoep gedaan?',
              'Wie heeft dat gedaan?',
              'Wie heeft dat gedaan?',
              'De hele Compagnie die heeft het eten laten staan!',
              'Wie heeft er suiker in de erwtensoep gedaan?'
            ],
            <String>[
              'De korporaal zei: Eerst proef ik!',
              '\'k Geloof dat jullie dazen!',
              'Hij kreeg de hik en liet van schrik',
              'toen voor den dokter blazen.',
              'Tot de sergeant kwam van de week,',
              'die vroeg als krijt zoo bleek:'
            ],
            <String>[
              'Wie! Wie! Wie!',
              'Wie! Wie! Wie!',
              'Wie heeft er suiker in de erwtensoep gedaan?',
              'Wie heeft dat gedaan?',
              'Wie heeft dat gedaan?',
              'De hele Compagnie die heeft het eten laten staan!',
              'Wie heeft er suiker in de erwtensoep gedaan?'
            ],
            <String>[
              'De luitenant, geaffecteerd,',
              'zei: "Wie maakt hier nu mopjes?"',
              'Ik heb de soep geïnspecteerd,',
              'ze smaakt naar Haagsche Hopjes.',
              'Geeft acht, rechts richten..,',
              'kom nou lui, wie tapte deze ui?'
            ],
            <String>[
              'Wie! Wie! Wie!',
              'Wie! Wie! Wie!',
              'Wie heeft er suiker in de erwtensoep gedaan?',
              'Wie heeft dat gedaan?',
              'Wie heeft dat gedaan?',
              'De hele Compagnie die heeft het eten laten staan!',
              'Wie heeft er suiker in de erwtensoep gedaan?'
            ],
            <String>[
              'Ten slotte kwam de kolonel,',
              'correct en afgemeten.',
              'Zei: Strafmarcheren, \'t hele stel!',
              'Ik ga in "t Zwaantje" eten!',
              'En sjokkende de heide door,',
              'zong de Compie in koor:'
            ],
            <String>[
              'Wie! Wie! Wie!',
              'Wie! Wie! Wie!',
              'Wie heeft er suiker in de erwtensoep gedaan?',
              'Wie heeft dat gedaan?',
              'Wie heeft dat gedaan?',
              'De hele Compagnie die heeft het eten laten staan!',
              'Wie heeft er suiker in de erwtensoep gedaan?'
            ]
          ]),
      const Lyric(
          id: 'GF5kHMvngVyALVcj7imopi',
          title: 'Hoe leit dit kindeke',
          parts: <List<String>>[
            <String>[
              'Hoe leit dit Kindeken hier in de kou',
              'Ziet eens hoe alle zijn ledekens beven',
              'Ziet eens hoe dat het weent en krijt van rouw',
              'Na, na, na, na, na, na, Kindeken teer',
              'Ei, zwijgt toch stil, sus, sus, en krijt niet meer'
            ],
            <String>[
              'Sa, ras dan, herderkens, komt naar de stal',
              'Speelt een zoet liedeken voor dit teer lammeken',
              'Mij dunkt dat het nu wel haast slapen zal',
              'Na, na, na, na, na, na, Kindeken teer',
              'Ei, zwijgt toch stil, sus, sus, en krijt niet meer'
            ],
            <String>[
              'En gij, o engeltjes, komt hier ook bij',
              'Zingt een motetteken voor uwen Koning',
              'Wilt Hem vermaken door uw melodij',
              'Na, na, na, na, na, na, Kindeken teer',
              'Ei, zwijgt toch stil, sus, sus, en krijt niet meer'
            ]
          ]),
      const Lyric(
          id: 'CzGXK6kp71eSgLGWz51NjG',
          title: 'Aan de Amsterdamse grachten',
          parts: <List<String>>[
            <String>[
              'Aan de Amsterdamse grachten',
              'heb ik heel mijn hart voor altijd verpand',
              'Amsterdam vult mijn gedachten',
              'als de mooiste stad in ons land',
              'Al die Amsterdamse mensen',
              'al die lichtjes \'s avonds laat op het plein',
              'Niemand kan zich beter wensen',
              'dan een Amsterdammer te zijn'
            ],
            <String>[
              'Er staat een huis aan de gracht in Amsterdam',
              'Waar ik als jochie van acht bij grootmoeder kwam',
              'Nu zit er een vreemde meneer in het kamertje voor',
              'en ook die heerlijke zolder werd een kantoor',
              'Alleen de bomen dromen hoog boven \'t verkeer',
              'en over \'t water gaat er een bootje net als weleer'
            ],
            <String>[
              'Aan de Amsterdamse grachten',
              'heb ik heel mijn hart voor altijd verpand',
              'Amsterdam vult mijn gedachten',
              'als de mooiste stad in ons land',
              'Al die Amsterdamse mensen',
              'al die lichtjes \'s avonds laat op het plein',
              'Niemand kan zich beter wensen',
              'dan een Amsterdammer te zijn'
            ]
          ]),
      const Lyric(
          id: '2WA38bVxVg76B9HxdY1po1',
          title: 'De glimlach van een kind',
          parts: <List<String>>[
            <String>[
              '"jij bent zo wijs", dat zegt een kind',
              '"jij bent zo grijs", dat zegt een kind',
              '"jij bent getrouwd", dat zegt een kind',
              '"jij bent al oud", dat zegt een kind'
            ],
            <String>[
              'Dan denk je "ja, een rimpel meer"',
              'Je wordt al echt een ouwe heer',
              'Maar voor je denkt "hoe moet dat nou"',
              'Pakt ze je hand en lacht naar jou'
            ],
            <String>[
              'De glimlach van een kind',
              'doet je beseffen dat je leeft',
              'De glimlach van een kind',
              'dat nog een leven voor zich heeft',
              'Dat leven is de moeite waard',
              'Met soms wel wat verdriet',
              'Maar met liefde, geluk en plezier in het verschiet'
            ],
            <String>[
              'De glimlach van een kind',
              'dat met een trein speelt of een pop',
              'Zo\'n glimlach maakt je blij',
              'daar kan geen feest meer tegen op',
              'Wat geeft het of je ouder wordt',
              'dat maakt toch niets meer uit',
              'Want je voelt je gelukkig al heb je geen duit'
            ],
            <String>[
              'De glimlach van een kind',
              'doet je beseffen dat je leeft',
              'De glimlach van een kind',
              'dat nog een leven voor zich heeft',
              'Dat leven is de moeite waard',
              'Met soms wel wat verdriet',
              'Maar met liefde, geluk en plezier in het verschiet'
            ]
          ]),
      const Lyric(
          id: 'NoizgecL2ZDgREFkwurPqd',
          title: 'Daar bij de waterkant',
          parts: <List<String>>[
            <String>[
              'Ik heb je voor het eerst ontmoet',
              'daar bij de waterkant,',
              'daar bij waterkant,',
              'daar bij de waterkant.',
              'Ik heb je voor het eerst ontmoet.',
              'daar bij de waterkant,',
              'daar bij de waterkant,'
            ],
            <String>[
              'Ik vroeg of jij me kussen wou',
              'daar bij de waterkant,',
              'daar bij waterkant,',
              'daar bij de waterkant.',
              'Ik vroeg of jij me kussen wou',
              'daar bij de waterkant,',
              'daar bij de waterkant.'
            ],
            <String>[
              'Je kreeg een kleurtje en zei nee.',
              'Hoe komt u op \'t idee.',
              'U bent beslist abuis.',
              'Maar na verloop van nog geen jaar',
              'werden wij een paar,',
              'stonden wij samen op de stoep van het stadhuis'
            ],
            <String>[
              'Ik heb je voor het eerst ontmoet',
              'daar bij de waterkant,',
              'daar bij waterkant.',
              'Ik heb je voor het eerst ontmoet',
              'daar bij de waterkant,',
              'daar bij waterkant.'
            ]
          ]),
      const Lyric(
          id: 'LHX6t5JHVzmakGMknBrpzb',
          title: 'Foxy Foxtrot',
          parts: <List<String>>[
            <String>[
              'En ze noemen me Foxie Foxtrot',
              'Wrijf de dansvloer effe op',
              'Want als de band begint te spelen',
              'Nou dan hou ik nooit meer op',
              'Dan begint mijn bloed te kriebelen',
              'En mijn benen staan niet stil',
              'Is hier soms een mooi meisje',
              'Dat effe dansen met me wil'
            ],
            <String>[
              'Oh Foxie Foxtrot met je elastieke benen',
              'Die wil elke avond naar een dancing toe',
              'Zeg jongeman mag ik je meisie effe lenen',
              'Wil met haar swingen',
              'want ik ben nog lang niet moe',
              'En wil je vrijer dan niet even met je dansen',
              'Dan roep ik quick, quick, slow',
              'want foxie grijpt z´n kansen',
              'Oh Foxy Foxtrot met je elastieke benen',
              'Die wil elke avond naar een dancing toe'
            ],
            <String>[
              'Ja zo dans ik heel m´n leven',
              'In elke discotheek en zaal',
              'Ik hoop nog een ding te beleven',
              'Dat ik de 100 nog eens haal',
              'Dan zal het dansen van zo\'n foxtrot',
              'Wel niet zo 1-2-3 meer gaan',
              'Maar dan dans ik wel een engels walsje',
              'met mijn eigen Sjaan'
            ],
            <String>[
              'Oh Foxie Foxtrot met je elastieke benen',
              'Die wil elke avond naar een dancing toe',
              'Zeg jongeman mag ik je meisie effe lenen',
              'Wil met haar swingen',
              'want ik ben nog lang niet moe',
              'En wil je vrijer dan niet even met je dansen',
              'Dan roep ik quick, quick, slow',
              'want foxie grijpt z´n kansen',
              'Oh Foxy Foxtrot met je elastieke benen',
              'Die wil elke avond naar een dancing toe'
            ]
          ]),
      const Lyric(
          id: 'UfrYsrS4mW3aCRHERMWNy',
          title: 'Sinterklaas medley',
          parts: <List<String>>[
            <String>[
              'Zie ginds komt de stoomboot uit Spanje weer aan',
              'Hij brengt ons Sint Nikolaas ik zie hem al staan',
              'Hoe huppelt zijn paardje het dek op en neer',
              'Hoe waaien de wimpels al heen en al weer'
            ],
            <String>[
              'Zijn knecht staat te lachten en roept ons reeds toe',
              'Wie zoet is krijgt lekkers wie stout is de roe',
              'Oh, lieve Sint Nikolaas, komt ook eens bij mij',
              'en rijdt toch niet stilletjes ons huisje voorbij'
            ],
            <String>[
              'Sinterklaas Kapoentje,',
              'gooi wat in m’n schoentje,',
              'gooi wat in m’n laarsje.',
              'Dank u, Sinterklaasje.'
            ],
            <String>[
              'Sinterklaas Kapoentje,',
              'gooi wat in m’n schoentje,',
              'gooi wat in m’n laarsje.',
              'Dank u, Sinterklaasje.'
            ],
            <String>[
              'Zie de maan schijnt door de bomen.',
              'Makkers staakt uw wild geraas.',
              '‘t Heerlijk avondje is gekomen,',
              '‘t avondje van Sinterklaas.'
            ],
            <String>[
              'Vol verwachting klopt ons hart,',
              'wie de koek krijgt, wie de gard.',
              'Vol verwachting klopt ons hart,',
              'wie de koek krijgt, wie de gard.'
            ],
            <String>[
              'Hoor wie klopt daar kind’ren,',
              'hoor wie klopt daar kind’ren,',
              'hoor wie tikt daar zachtjes tegen ‘t raam.',
              '‘t Is een vreemd’ling zeker,',
              'die verdwaald is zeker,',
              'ik zal eens even vragen naar zijn naam.'
            ],
            <String>[
              'Sint Nicolaas, Sint Nicolaas,',
              'breng ons vanavond een bezoek',
              'en strooi dan wat lekkers,',
              'in de één of andere hoek.',
              'Stoute kind’ren, zegt hij,',
              'krijgen knorren, zegt hij,',
              'of een zakje, zegt hij, met wat zout.',
              'Want je weet wel, zegt hij,',
              'dat Sint Nicolaas, zegt hij,',
              'van die stoute kind’ren heel niet houdt.'
            ],
            <String>[
              'Sint Nicolaas, Sint Nicolaas,',
              'breng ons vanavond een bezoek,',
              'en strooi dan wat lekkers,',
              'in de één of andere hoek. (Koekoek!)'
            ],
            <String>[
              'Sinterklaasje, bonne, bonne, bonne.',
              'Gooi wat in mijn lege, lege tonne.',
              'Gooi wat in mijn laarsje!',
              'Dank u, Sinterklaasje!'
            ],
            <String>[
              'Sinterklaasje, bonne, bonne, bonne.',
              'Gooi wat in mijn lege, lege tonne.',
              'Gooi wat in mijn laarsje!',
              'Dank u, Sinterklaasje!'
            ],
            <String>[
              'Sinterklaasje, bonne, bonne, bonne.',
              'Gooi wat in mijn lege, lege tonne.',
              'Gooi wat in mijn laarsje!',
              'Dank u, Sinterklaasje!'
            ],
            <String>[
              'Hoor de wind waait door de bomen,',
              'hier in huis zelfs waait de wind.',
              'Zou de goede Sint wel komen,',
              'als hij ’t weer zo lelijk vindt.',
              'Als hij ’t weer zo lelijk vindt.'
            ],
            <String>[
              'Ja, hij komt in donkere nachten,',
              'op z’n paardje oh zo snel.',
              'Als hij wist hoe we hem verwachten,',
              'oh dan kwam hij zeker wel.',
              'Oh dan kwam hij zeker wel.'
            ]
          ]),
      const Lyric(
          id: 'XkMQt94aUgAYa47qCvmVFK',
          title: 'Kling klokje klingelingeling',
          parts: <List<String>>[
            <String>[
              'Kling, klokje klingelingeling',
              'kling, klokje kling',
              'Kerstmis is gekomen',
              'kaarsjes aan de bomen',
              'kaarsje hier en overal',
              'die ik strakjes branden zal',
              'kling, klokje klingelingeling',
              'kling, klokje kling!'
            ]
          ]),
      const Lyric(
          id: 'Gx1dZeoikQKRyyDy1aru6f',
          title: 'Hertog Jan',
          parts: <List<String>>[
            <String>[
              'Toen den hertog Jan kwam varen',
              'Te peerd parmant, al triumfant',
              'Na zevenhonderd jaren',
              'Hoe zong men \'t allen kant',
              'Harba lorifa, zong den Hertog, harba lorifa,',
              'Na zevenhonderd jaren',
              'In dit edel Brabants land'
            ],
            <String>[
              'Hij kwam van over \'t water',
              'Den Scheldevloed, aan wal te voet',
              '\'t Antwerpen op de straten',
              'Zilv\'ren veren op zijn hoed',
              'Harba lorifa, zong den Hertog, harba lorifa',
              '\'t Antwerpen op de straten',
              'Lere leerzen aan zijn voet'
            ],
            <String>[
              'Och Turnhout, stedeke schone',
              'Zijn uw ruitjes groen, maar uw hertjes koen',
              'Laat den Hertog binnen komen',
              'In dit zomers vrolijk seizoen',
              'Harba lorifa, zong den Hertog, harba lorifa',
              'Laat den Hertog binnen komen',
              'Hij heeft een peerd van doen'
            ],
            <String>[
              'Hij heeft een peerd gekregen',
              'Een schoon wit peerd, een schimmelpeerd',
              'Daar is hij opgestegen',
              'Dien ridder onverveerd',
              'Harba lorifa, zong den Hertog, harba lorifa',
              'Daar is hij opgestegen',
              'En hij reed naar Valkensweerd'
            ],
            <String>[
              'In Valkensweerd daar zaten',
              'Al in de kast, de zilverkast',
              'De guldenkoning zijn platen',
              'Die wierd\' aaneen gelast',
              'Harba lorifa, zong den Hertog, harba lorifa',
              'De guldenkoning zijn platen',
              'Toen had hij een harnas'
            ],
            <String>[
              'Rooise boeren, komt naar buiten',
              'Met de grote trom, met de kleine trom',
              'Trompetten en cornetten en de fluiten',
              'Want den Hertog komt weerom',
              'Harba lorifa, zong den Hertog, harba lorifa',
              'Trompetten en cornetten en de fluiten',
              'In dit Brabants Hertogdom'
            ],
            <String>[
              'Wij reden allemaal samen',
              'Op Oirschot aan, door een Kanidasselaan',
              'En Jan riep: "In Geus name!"',
              'Hier heb ik meer gestaan.\'',
              'Harba lorifa, zong den Hertog, harba lorifa',
              'En Jan riep: "In Geus name!"',
              'Reikt mij mijn standaard aan!\''
            ],
            <String>[
              'De standaard was de gouwe',
              'Die waaide dan, die draaide dan',
              'Die droeg de leeuw met klauwen',
              'Wij zongen alleman',
              'Harba lorifa, zong den Hertog, harba lorifa',
              'Die droeg de leeuw met klauwen',
              'Ja, de Leeuw van Hertog Jan'
            ],
            <String>[
              'Hij is in Den Bosch gekomen',
              'Al in de nacht, niemand die \'t zag',
              'En op Sint Jan geklommen',
              'Daar ging hij staan op wacht',
              'Harba lorifa, zong den Hertog, harba lorifa',
              'En op Sint Jan geklommen',
              'Daar staat hij dag en nacht'
            ]
          ]),
      const Lyric(
          id: 'EvozjUPua8GYXU2Ec7T8LG',
          title: 'Advocaatje ging op reis',
          parts: <List<String>>[
            <String>[
              'Advocaatje ging op reis, tiereliereliere.',
              'Advocaatje ging op reis, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ],
            <String>[
              'Bij een herberg bleef hij staan, tiereliereliere.',
              'Bij een herberg bleef hij staan, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ],
            <String>[
              'Stokvis kreeg hij bij \'t ontbijt, tiereliereliere.',
              'Stokvis kreeg hij bij \'t ontbijt, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ],
            <String>[
              '\'t Graatje schoot hem in zijn keel, tiereliereliere.',
              '\'t Graatje schoot hem in zijn keel, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ],
            <String>[
              'Dokter werd er bij gehaald, tiereliereliere.',
              'Dokter werd er bij gehaald, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ],
            <String>[
              'Maar de dokter was te laat, tiereliereliere.',
              'Maar de dokter was te laat, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ],
            <String>[
              'Zo ging advocaatje dood, tiereliereliere.',
              'Zo ging advocaatje dood, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ],
            <String>[
              '\'t Gras dat groeit nu op zijn buik, tiereliereliere.',
              '\'t Gras dat groeit nu op zijn buik, tierelierelom.',
              'Met zijn hoedje op zijn arm, tiereliereliere.',
              'Met zijn hoedje op zijn arm, tierelierelom.'
            ]
          ]),
      const Lyric(
          id: 'GGpN7DhTVhwR4a9dHDjULG',
          title: 'Daar bij die molen',
          parts: <List<String>>[
            <String>[
              'Ik weet een heerlijk plekje grond',
              'Daar waar die molen staat',
              'Waar ik mijn allerliefste vond',
              'Waarvoor mijn harte slaat',
              'Ik sprak haar voor den eerste keer',
              'aan d\'oever van den vliet',
              'en sinds die tijd kom ik daar weer',
              'die plek vergeet ik niet'
            ],
            <String>[
              'Daar bij die molen, die mooie molen',
              'Daar woont het meisje waar ik zoveel van hou',
              'Daar bij die molen,',
              'Daar wil ik wonen als zij eens wordt mijn vrouw'
            ],
            <String>[
              'Als in den stillen avondstond',
              'De zon ten onder ging',
              'En ik haar bij den molen vond',
              'in zoete mijmering',
              'Fluisterde ze mij in het oor',
              '"Oh heerlijk saam te zijn"',
              'De molen draaide lustig door',
              'en ik zei "liefste mijn"'
            ],
            <String>[
              'Daar bij die molen, die mooie molen',
              'Daar woont het meisje waar ik zoveel van hou',
              'Daar bij die molen,',
              'Daar wil ik wonen als zij eens wordt mijn vrouw'
            ],
            <String>[
              'Ik zie de molen al versierd',
              'ter ere van \'t jonge paar',
              'Het hele dorp dat juicht en tiert',
              '"Zij leve menig jaar"',
              'En zie ik trots de molen staan',
              'dan zweer ik in dien stond',
              'Nooit ga ik van die plek vandaan',
              'Waar ik mijn vrouwtje vond'
            ],
            <String>[
              'Daar bij die molen, die mooie molen',
              'Daar woont het meisje waar ik zoveel van hou',
              'Daar bij die molen,',
              'Daar wil ik wonen als zij eens wordt mijn vrouw'
            ]
          ]),
      const Lyric(
          id: '3cmPpSL1yviiV66AvtUv7P',
          title: 'In \'t groene dal',
          parts: <List<String>>[
            <String>[
              'In \'t groene dal, in \'t stille dal',
              'Waar kleine bloempjes groeien',
              'Daar ruist een blanke waterval',
              'En druppels spatten overal',
              'Om ieder bloempje te besproeien, ook \'t kleinste',
              'Om ieder bloempje te besproeien, ook \'t kleinste'
            ],
            <String>[
              'En boven op der heuv\'len spits',
              'Waar forse bomen groeien',
              'Daar zweept de stormvlaag fel en bits',
              'Daar treft de rosse bliksemflits',
              'En splijt bij \'t dav\'rend onweer loeien, de grootste',
              'En splijt bij \'t dav\'rend onweer loeien, de grootste'
            ],
            <String>[
              'Omhoog, omlaag, op berg en dal',
              'Ben \'k in de hand des Heren!',
              'Toch kies ik, als ik kiezen zal',
              'Mijn stille plek mijn waterval',
              'Toch blijf ik steeds, naar mijn begeren, de kleinste!',
              'Toch blijf ik steeds, naar mijn begeren, de kleinste!'
            ]
          ]),
      const Lyric(
          id: '2SQ3bh2LfXfcTbbHqyRjF5',
          title: 'Twee emmertjes water halen',
          parts: <List<String>>[
            <String>[
              'Twee emmertjes water halen',
              'Twee emmertjes pompen',
              'De meisjes op de klompen',
              'De jongens op hun houten been',
              'Rij maar door mijn poortje heen'
            ],
            <String>[
              'Van je ras ras ras',
              'Rijdt de koning door de plas',
              'Van je voort voort voort',
              'Rijdt de koning door de poort',
              'Van je erk erk erk',
              'Rijdt de koning naar de kerk',
              'Van je één....twee....drie'
            ]
          ]),
      const Lyric(
          id: 'NUZZMP6ooevfPMgahoLNPB',
          title: 'Als de grote klokke luidt',
          parts: <List<String>>[
            <String>[
              'Als de grote klokke luidt, de klokke luidt,',
              'de reuze komt uit.',
              'Kere weerom, reuze, reuze,',
              'kere weerom, reuzegom.'
            ],
            <String>[
              'Moeder, hang de pot op \'t vier, de pot op \'t vier,',
              'de reuze komt hier.',
              'Kere weerom, reuze, reuze,',
              'kere weerom, reuzegom.'
            ],
            <String>[
              'Moeder, snijd een boterham, een boterham,',
              'de reuze is gram.',
              'Kere weerom, reuze, reuze,',
              'kere weerom, reuzegom.'
            ],
            <String>[
              'Moeder, tap het beste bier, het beste bier,',
              'de reuze is gier.',
              'Kere weerom, reuze, reuze,',
              'kere weerom, reuzegom.'
            ],
            <String>[
              'Moeder, stop al ras het vat, al ras het vat,',
              'de reuze is zat.',
              'Kere weerom, reuze, reuze,',
              'kere weerom, reuzegom.'
            ],
            <String>[
              'Moeder, geef maar kaas en brood, maar kaas en brood,',
              'de reuze is dood.',
              'Kere weerom, reuze, reuze,',
              'kere weerom, reuzegom.'
            ],
            <String>[
              'Die daar zegt die reus die kom, die reus die kom,',
              'die liegen erom.',
              'Kere weerom, reuze, reuze,',
              'kere weerom, reuzegom.'
            ]
          ]),
      const Lyric(
          id: 'UHV2EhZeThe1JVeHkZhcg8',
          title: 'Daar was laatst een meisje loos',
          parts: <List<String>>[
            <String>[
              'Daar was laatst een meisje loos',
              'Die wou gaan varen, die wou gaan varen',
              'Daar was laatst een meisje loos',
              'Die wou gaan varen als lichtmatroos'
            ],
            <String>[
              'Zij moest klimmen in de mast',
              'Maken de zeilen, maken de zeilen',
              'Zij moest klimmen in de mast',
              'Maken de zeilen met touwtjes vast'
            ],
            <String>[
              'Maar door storm en tegenweer',
              'Sloegen de zeilen, sloegen de zeilen',
              'Maar door storm en tegenweer',
              'Sloegen de zeilen van boven neer'
            ],
            <String>[
              'Och kap\'teintje, sla me niet',
              'Ik ben uw liefje, ik ben uw liefje',
              'Och kap\'teintje, sla me niet',
              'Ik ben uw liefje zoals gij ziet'
            ],
            <String>[
              'Zij moest komen in de kajuit',
              'Kreeg een pak ransel, kreeg een pak ransel',
              'Zij moest komen in de kajuit',
              'Kreeg een pak ransel',
              'En toen was het uit'
            ]
          ]),
      const Lyric(
          id: '7yyNirdwBpAh3BdoGxvJ25',
          title: 'Op de grote, stille heide',
          parts: <List<String>>[
            <String>[
              'Op de grote, stille heide',
              'Dwaalt de herder eenzaam rond',
              'Wijl de witgewolde kudde',
              'Trouw bewaakt wordt door de hond',
              'En al dwalend ginds en her',
              'Denkt de herder: Och, hoe ver',
              'Hoe ver is mijn heide!',
              'Hoe ver is mijn heide, mijn heide!'
            ],
            <String>[
              'Op de grote, stille heide',
              'Bloeien bloempjes lief en teer',
              'Pralend in de zonnestralen',
              'Als een bloemhof heinde en veer',
              'En, tevree met karig loon',
              'Roept de herder: O, hoe schoon',
              'Hoe schoon is mijn heide!',
              'Hoe schoon is mijn heide, mijn heide!'
            ],
            <String>[
              'Op de grote, stille heide',
              'Rust het al bij maneschijn',
              'Als de schaapjes en de bloemen',
              'Vredig ingesluimerd zijn',
              'En, terugziend op zijn pad',
              'Juicht de herder: Welk een schat!',
              'Hoe rijk is mijn heide!',
              'Hoe rijk is mijn heide, mijn heide!'
            ]
          ]),
      const Lyric(
          id: '8WbiRfUuKSgNdH5uGiMmrp',
          title: 'Nu zijt wellekome',
          parts: <List<String>>[
            <String>[
              'Nu zijt wellekome, Jesu lieve Heer',
              'Gij komt van alzo hoge, van al zo veer',
              'Nu zijt wellekome uit de hoge hemel neer',
              'Hier al op dit aardrijk zijt gij gezien nooit meer',
              'Kyrieleis'
            ],
            <String>[
              'Herders op den velde, hoorden een nieuw lied',
              'Dat Jezus was geboren, zij wisten \'t niet',
              'Gaat aan gene strate, en gij zult het vinden klaar',
              'Beth\'lem is de stede, daar is \'t geschied voorwaar',
              'Kyrieleis'
            ],
            <String>[
              'Heilige drie koon\'gen, uit zo verre land',
              'Zij zochten onze Here, met offerand',
              'Z\' offerden ootmoediglijk myrrh\', wierook ende goud',
              '\'t Eren van dat kindje, dat alle ding behoudt',
              'Kyrieleis'
            ]
          ]),
      const Lyric(
          id: 'AESzkRC2Xe3cSYo74oFLSe',
          title: 'Faria',
          parts: <List<String>>[
            <String>[
              'Zingend trekken wij nu naar buiten, faria',
              'Wie niet zingen wil moet maar fluiten, faria',
              'Want zo lang je maar vrolijk bent',
              'Ben je rijk ook al heb je geen cent',
              'Faria, faria, faria, faria, faria'
            ],
            <String>[
              'Heerlijk is het trekkersleven, faria',
              'Waar we lopen is ons om \'t even, faria',
              'Als de dageraad nauwelijks gloort',
              'Staan we op en de reis gaat voort',
              'Faria, faria, faria, faria, faria'
            ],
            <String>[
              'Nimmer worden we moe te dwalen, faria',
              'Over bergen en door de dalen, faria',
              'Langs de velden en door de wei',
              'Door de bossen en op de hei',
              'Faria, faria, faria, faria, faria'
            ],
            <String>[
              'Maar we willen het heus wel weten, faria',
              'Nooit ontbreekt ons de lust tot eten, faria',
              'Als de pot op het kampvuur staat',
              'Vallen we letterlijk van de graat',
              'Faria, faria, faria, faria, faria'
            ],
            <String>[
              'Na het eten wat musiceren, faria',
              'En we zingen dan heel wat keren, faria',
              'Samen een vrolijk trekkerslied',
              'Boze mensen die zingen niet',
              'Faria, faria, faria, faria, faria'
            ]
          ]),
      const Lyric(
          id: 'EqCnuUKcSkoWPyvaRK8Jbh',
          title: 'Hoe je heette',
          parts: <List<String>>[
            <String>[
              'Hoe je heette dat ben ik vergeten',
              'maar je ogen vergeet ik nooit meer',
              '\'k Droom nog altijd, dat wil ik wel weten',
              'op een avond, dan zie ik je weer'
            ],
            <String>[
              'Want geen ander is er daarna nog geweest voor mij',
              'Toen ik afscheid nam van jou ging het geluk voorbij',
              'Hoe je heette dat ben ik vergeten',
              'maar je kussen vergeet ik nooit meer'
            ],
            <String>[
              '\'t was in een kleine badplaats, de zee was er blauw',
              'Daar danste ik die avond een tango met jou'
            ],
            <String>[
              'Hoe je heette dat ben ik vergeten',
              'maar je ogen vergeet ik nooit meer',
              '\'k Droom nog altijd, dat wil ik wel weten',
              'op een avond, dan zie ik je weer'
            ],
            <String>[
              'Want geen ander is er daarna nog geweest voor mij',
              'Toen ik afscheid nam van jou ging het geluk voorbij',
              'Hoe je heette dat ben ik vergeten',
              'maar je kussen vergeet ik nooit meer'
            ]
          ]),
      const Lyric(
          id: 'KGxasqUC1Uojk1viLGbMZK',
          title: 'O denneboom',
          parts: <List<String>>[
            <String>[
              'O denneboom, o denneboom,',
              'Wat zijn uw takken wonderschoon',
              'Ik heb u laatst in \'t bos zien staan,',
              'Toen zaten er geen kaarsjes aan.',
              'O denneboom, o denneboom,',
              'Wat zijn uw takken wonderschoon.'
            ]
          ]),
      const Lyric(
          id: 'Xj6KarR31BiE43MS25k8Aj',
          title: 'Klok van Arnemuiden',
          parts: <List<String>>[
            <String>[
              'Als de klok van Arnemuiden',
              'welkom thuis voor ons zal luiden,',
              'wordt de vreugde soms vermengd met droefenis',
              'als een schip op zee gebleven is.'
            ],
            <String>[
              'Wend het roer, we komen thuis gevaren,',
              'rijk was de buit, maar lang en zwaar de nacht.',
              'Land in zicht en onze ogen staren',
              'naar de kust, die lokkend op ons wacht.'
            ],
            <String>[
              'Als de klok van Arnemuiden',
              'welkom thuis voor ons zal luiden,',
              'wordt de vreudge soms vermengd met droefenis,',
              'als een schip op zee gebleven is.'
            ],
            <String>[
              'Rijke zee, waarvan de vissers dromen,',
              'want jij geeft brood aan man en vrouw en kind.',
              'Wrede zee, jij hebt zoveel genomen,',
              'in jouw schoot rust menig trouwe vrind.'
            ],
            <String>[
              'Als de klok van Arnemuiden',
              'welkom thuis voor ons zal luiden,',
              'wordt de vreugde soms vermengd met droefenis',
              'als een schip op zee gebleven is.'
            ]
          ]),
      const Lyric(
          id: 'Czf1prigfwHLdxE7Cxomgm',
          title: 'De uil zat in de olmen',
          parts: <List<String>>[
            <String>[
              'De uil zat in de olmen',
              'bij \'t vallen van de nacht',
              'En achter gindse heuvels',
              'Antwoordt de koekoek zacht',
              'Koekoek, koekoek, koekoek koekoek koekoek (2x)'
            ]
          ]),
      const Lyric(
          id: 'Q7ooSPd4vdcaeGRDUvoLgK',
          title: 'Karretje op de zandweg',
          parts: <List<String>>[
            <String>[
              'Een karretje op de zandweg reed.',
              'De maan scheen helder, de weg was breed.',
              'Het paardje liep met lusten.',
              '\'k Wed dat het zelluf zijn weg wel vindt.',
              'De voerman lei te rusten.',
              'Ik wens je wel thuis m\'n vrind, m\'n vrind.',
              'Ik wens je wel thuis m\'n vrind.'
            ],
            <String>[
              'Een karretje reed langs berg en dal.',
              'De nacht was donker, de weg was smal.',
              'Het paard liep als met vleugels.',
              'De sneeuwjacht zweept z\'n ogen blind.',
              'De voerman houdt de teugels.',
              'Ik wens je wel thuis m\'n vrind, m\'n vrind.',
              'Ik wens je wel thuis m\'n vrind.'
            ],
            <String>[
              'Één karretje keert behouden weer.',
              'Het andere heeft er geen voerman meer.',
              'Waar mag hij zijn gebleven?',
              '\'k Wed dat je \'m op de zandweg vindt.',
              'Of moog\'lijk wel daarneven.',
              'Hij komt niet weer thuis die vrind, die vrind.',
              'Hij komt niet weer thuis die vrind.'
            ]
          ]),
      const Lyric(
          id: 'A59Ps7FmpsJmuywy3jsGqK',
          title: 'Ketelbinkie',
          parts: <List<String>>[
            <String>[
              'Toen wij van Rotterdam vertrokken',
              'Met de "Edam", een ouwe schuit',
              'Met kakkerlakke in de midscheeps',
              'En rattennesten in het vooruit',
              'Toen hadde wij een kleine jonge',
              'Als ketelbink bij ons an boord',
              'Die voor de eerste keer naar zee ging',
              'En nooit van haaien had gehoord'
            ],
            <String>[
              'Die van z\'n moeder an de kade',
              'Wat schuchter lachend afscheid nam',
              'Omdat ie haar niet durfde zoene',
              'Die straatjongen uit Rotterdam'
            ],
            <String>[
              'Hij werd gescholden door de stokers',
              'Omdat ie van den eerste dag',
              'Toen we maar net de pier uit waren',
              'al zeeziek in het Voxhol lag',
              'En met jenever en citroenen',
              'Werd hij weer op de been gebracht',
              'Want zieke zeelui zijn nadelig',
              'En brengen schade aan de vracht'
            ],
            <String>[
              'Als \'ie dan sjouwend met ze ketels',
              'Van de kombuis naar voren kwam',
              'Dan was het net een brokkie wanhoop',
              'Die straatjongen uit Rotterdam'
            ],
            <String>[
              'Wanneer ie \'s avonds in ze kooi lag',
              'En na z\'n sjouwen eindelijk sliep',
              'Dan schold de man die wacht te kooi had',
              'Omdat ie om z\'n moeder riep',
              'Toen is ie op een mooie morgen',
              '\'t Was in den Stille Oceaan',
              'Terwijl ze brulden om hun koffie',
              'Niet van z\'n kooigoed opgestaan'
            ],
            <String>[
              'En toen de stuurman met kinine',
              'En wonderolie bij hem kwam',
              'Vroegt \'ie een voorschot op ze gage',
              'Voor \'t ouwe mens in Rotterdam'
            ],
            <String>[
              'In zeildoek en met roosterbaren',
              'Werd hij dien dag op het luik gezet',
              'De kapitein lichtte z\'n petje',
              'En sprak met grogstem een gebed',
              'En met een een, twee, drie in Godsnaam',
              'ging \'t ketelbinkie overboord',
              'Die het ouwetje niet dorst te zoenen',
              'Omdat dat niet bij zeelui hoort'
            ],
            <String>[
              'De man een extra mokkie schoot an',
              'En het ouwe mens een tellegram',
              'Dat was het einde van een zeeman',
              'Die straatjongen uit Rotterdam'
            ]
          ]),
      const Lyric(
          id: 'RfRFL5jWeKFmG1hFn3i3TP',
          title: 'De wielewaal',
          parts: <List<String>>[
            <String>[
              'Kom mee naar buiten allemaal',
              'dan zoeken wij de wielewaal',
              'en horen wij die muzikant',
              'dan is zomer weer in \'t land.'
            ],
            <String>[
              'Dudeljo klinkt zijn lied',
              'Dudeljo klinkt zijn lied',
              'Dudeljo en anders niet.',
              'Dudeljo klinkt zijn lied',
              'Dudeljo klinkt zijn lied',
              'Dudeljo en anders niet.'
            ],
            <String>[
              'Hij woont in \'t dichte eikenbos',
              'gekleed in gouden vederdos.',
              'Daar jodelt hij op zijn schalmei',
              'tovert onze harten blij!'
            ],
            <String>[
              'Dudeljo klinkt zijn lied',
              'Dudeljo klinkt zijn lied',
              'Dudeljo en anders niet.',
              'Dudeljo klinkt zijn lied',
              'Dudeljo klinkt zijn lied',
              'Dudeljo en anders niet'
            ]
          ]),
      const Lyric(
          id: '4zGmF15QsYJ8vCq3Whg7Js',
          title: 'Mijn opa',
          parts: <List<String>>[
            <String>[
              'Elke zondagmiddag bracht ie toffees voor me mee.',
              'Ik weet nog de spelletjes die opa met me dee,',
              'restaurantje spelen en m\'n opa was de kok,',
              'bokkewagen spelen en m\'n opa was de bok'
            ],
            <String>[
              'M\'n opa, m\'n opa, m\'n opa',
              'in heel Europa was er niemand zo als hij.',
              'M\'n opa, m\'n opa, m\'n opa,',
              'en niemand was zo aardig voor mij.',
              'In heel Europa m\'n oude opa.',
              'Nergens zo iemand als hij',
              'in heel Europa m\'n ouwe opa.',
              'nergens zo iemand als hij',
              'niemand zo aardig voor mij',
              'M\'n ouwe opa.'
            ],
            <String>[
              'Als ik me verveelde ging ik altijd naar \'em toe.',
              'Hij verzon een spelletje en nooit was ie te moe.',
              'Van de dijk afrollen en m\'n opa was de dijk,',
              'detectiefie spelen en m\'n opa was het lijk.'
            ],
            <String>[
              'M\'n opa, m\'n opa, m\'n opa',
              'in heel Europa was er niemand zo als hij.',
              'M\'n opa, m\'n opa, m\'n opa,',
              'en niemand was zo aardig voor mij.',
              'In heel Europa m\'n oude opa.',
              'Nergens zo iemand als hij',
              'in heel Europa m\'n ouwe opa.',
              'nergens zo iemand als hij',
              'niemand zo aardig voor mij',
              'M\'n ouwe opa.'
            ],
            <String>[
              'Samen naar de apies kijken, samen naar het strand.',
              'En als je geluk had ging je samen naar de brand.',
              'Samen op het ijs en met een sleetje in de sneeuw,',
              'leeuwentemmer spelen en m\'n opa was de leeuw.',
              'Altijd als we samen waren hadden we veel plezier.',
              'stierenvechter spelen en m\'n opa was de stier.'
            ],
            <String>[
              'M\'n opa, m\'n opa, m\'n opa',
              'in heel Europa was er niemand zo als hij.',
              'M\'n opa, m\'n opa, m\'n opa,',
              'en niemand was zo aardig voor mij.',
              'In heel Europa m\'n oude opa.',
              'Nergens zo iemand als hij',
              'in heel Europa m\'n ouwe opa.',
              'nergens zo iemand als hij',
              'niemand zo aardig, niemand zo aardig,',
              'niemand zo aardig als hij',
              'M\'n ouwe opa.'
            ]
          ]),
      const Lyric(
          id: 'JQxkudn73YcGMCFizLUEHc',
          title: 'Daar in dat kleine café',
          parts: <List<String>>[
            <String>[
              'De avondzon valt over straten en pleinen,',
              'de gouden zon zakt in de stad.',
              'En mensen die moe in hun huizen verdwijnen,',
              'ze hebben de dag weer gehad',
              'De neon-reclame die knipoogt langs ramen,',
              'het motregent zachtjes op straat.',
              'De stad lijkt gestorven toch klinkt er muziek',
              'uit een deur die nog wijd open staat.'
            ],
            <String>[
              'Daar in dat kleine café aan de haven,',
              'daar zijn de mensen gelijk en tevree,',
              'daar in dat kleine café aan de haven,',
              'daar telt je geld of wie je bent niet meer mee.'
            ],
            <String>[
              'De toog is van koper toch ligt er geen loper,',
              'de voetbalclub hangt aan de muur.',
              'De trekkast die maakt meer lawaai dan de jukebox,',
              'een pilsje dat is er niet duur',
              'Een mens is daar mens rijk of arm, \'t is daar warm,',
              'geen monsieur of madame, maar wc.',
              'Maar \'t glas is gespoeld in het helderste water,',
              'ja, \'t is daar een heel goed café.'
            ],
            <String>[
              'Daar in dat kleine café aan de haven,',
              'daar zijn de mensen gelijk en tevree,',
              'daar in dat kleine café aan de haven,',
              'daar telt je geld of wie je bent niet meer mee.'
            ],
            <String>[
              'De wereldproblemen die zijn tussen twee glazen bier',
              'opgelost voor altijd.',
              'Op de rand van een bierviltje staat daar je rekening',
              'of je staat in het krijt.',
              'Het enige dat je aan eten kunt krijgen,',
              'dat is daar een hard gekookt ei.',
              'De mensen die zijn daar gelukkig gewoon,',
              'ja, de mensen die zijn daar nog blij.'
            ],
            <String>[
              'Daar in dat kleine café aan de haven,',
              'daar zijn de mensen gelijk en tevree,',
              'daar in dat kleine café aan de haven,',
              'daar telt je geld of wie je bent niet meer mee.'
            ]
          ]),
      const Lyric(
          id: 'CHbtehmiLVF2Gihpnu2UMz',
          title: 'Er is een kindeke geboren op d\' aard',
          parts: <List<String>>[
            <String>[
              'Er is een kindeke geboren op aard',
              'Er is een kindeke geboren op aard',
              '\'t Kwam op de aarde voor ons allemaal',
              '\'t Kwam op de aarde voor ons allemaal'
            ],
            <String>[
              'Er is een kindeke geboren in \'t strooi',
              'Er is een kindeke geboren in \'t strooi',
              '\'t Lag in een kribje gedekt met wat hooi',
              '\'t Lag in een kribje gedekt met wat hooi'
            ],
            <String>[
              '\'t Kwam op de aarde voor ons allegaar',
              '\'t Kwam op de aarde voor ons allegaar',
              '\'t Wenst ons een zalig nieuwjaar',
              '\'t Wenst ons een zalig nieuwjaar'
            ]
          ]),
      const Lyric(
          id: 'FyAvpSWaLQmcDaYZxwXe44',
          title: 'Stille nacht',
          parts: <List<String>>[
            <String>[
              'Stille nacht, heilige nacht,',
              'Alles slaapt, sluimer zacht.',
              'Eenzaam waakt het hoogheilige paar,',
              'Lieflijk Kindje met goud in het haar,',
              'Sluimert in hemelse rust',
              'Sluimert in hemelse rust.'
            ],
            <String>[
              'Stille nacht, heilige nacht',
              'Zoon van God, liefde lacht',
              'Vriend\'lijk om Uwe God\'lijke mond,',
              'Nu ons slaat de reddende stond,',
              'Jezus van Uwe geboort\',',
              'Jezus van Uwe geboort\'.'
            ],
            <String>[
              'Stille nacht, heilige nacht,',
              'Herders zien \'t eerst Uw pracht;',
              'Door der eng\'len alleluja',
              'Galmt het luide van verre en na:',
              'Jezus de redder ligt daar,',
              'Jezus de redder ligt daar.'
            ]
          ]),
      const Lyric(
          id: 'Ux6dZ7sf2G4BBtPw2byGqh',
          title: 'Kortjakje',
          parts: <List<String>>[
            <String>[
              'Altijd is Kortjakje ziek',
              'Midden in de week, maar \'s zondags niet',
              '\'s Zondags gaat ze naar de kerk',
              'Met haar boek vol zilverwerk',
              'Altijd is Kortjakje ziek',
              'Midden in de week, maar \'s zondags niet'
            ],
            <String>[
              'Altijd is Kortjakje ziek',
              'Midden in de week, maar \'s zondags niet',
              'Door de week wil zij niet wassen',
              'Zondags strikt zij de heren hun dassen.',
              'Altijd is Kortjakje ziek',
              'Midden in de week, maar \'s zondags niet'
            ]
          ]),
      const Lyric(
          id: '3JZkVBhCXXgsUAfD12pk5b',
          title: 'Sofietje',
          parts: <List<String>>[
            <String>[
              'Zij dronk ranja met een rietje, mijn Sophietje',
              'Op een Amsterdams terras',
              'Zij was Hollands als het gras',
              'Als een molen aan een plas',
              'Ik wist niet wat ik moest zeggen, uit moest leggen',
              'Iets wat Cupido wel weet',
              'Dat ze mij meteen iets deed',
              'Meteen iets deed'
            ],
            <String>[
              'Ik zag meisjes in Parijs en in Turijn',
              'In Helsinki, in Londen en Berlijn',
              'Waar ik op de wijde wereld was',
              'Zij mochten er wel zijn',
              'Maar de mooiste van de mooiste is Sophie',
              'In de liefde is ze zeker een genie',
              'Want een meisje als Sophietje is een lentesymfonie'
            ],
            <String>[
              'In haar stem hoor ik een liedje, melodietje',
              '\'t Is een liedje met een lach',
              'Dat ik hoor sinds ik haar zag',
              'Sinds ik haar zag'
            ],
            <String>[
              'Ik zag meisjes in Parijs en in Turijn',
              'In Helsinki, in Londen en Berlijn',
              'Waar ik op de wijde wereld was',
              'Zij mochten er wel zijn',
              'Maar de mooiste van de mooiste is Sophie',
              'In de liefde is ze zeker een genie',
              'Want een meisje als Sophietje is een lentesymfonie'
            ],
            <String>[
              'Zij dronk ranja met een rietje, mijn Sophietje',
              'Op een Amsterdams terras',
              'Toen wist ik dat mijn Sophie de liefste was'
            ]
          ]),
      const Lyric(
          id: 'CgJdQhFdDb5f5tHZBQM1Vt',
          title: 'Twee reebruine ogen',
          parts: <List<String>>[
            <String>[
              'Een blond gelokte jonge jager',
              'Kwam \'s morgens van de jacht terug.',
              'Een lieve meid, naar schatting achttien lentes,',
              'Ontmoette hij daar bij de brug.'
            ],
            <String>[
              'Twee reebruine ogen',
              'die keken de jager an',
              'Twee reebruine ogen',
              'die hij niet vergeten kan'
            ],
            <String>[
              'Ze zouden over 2 jaar trouwen',
              'Doch nauw\'lijks waren zij vereend.',
              'Toen moest hij weg naar een andere betrekking',
              'Ver weg, en zij heeft zo geweend.'
            ],
            <String>[
              'Twee reebruine ogen',
              'die keken de jager an',
              'Twee reebruine ogen',
              'die hij niet vergeten kan'
            ],
            <String>[
              'En weder ging ter jacht de jager',
              'Ontmoette toen een schuwe ree.',
              'Hij wilde op dat ed\'le dier gaan schieten,',
              'Legde an, maar schudde toen van nee.'
            ],
            <String>[
              'Twee reebruine ogen',
              'die keken de jager an',
              'Twee reebruine ogen',
              'die hij niet vergeten kan'
            ],
            <String>[
              'Twee reebruine ogen',
              'die keken de jager an',
              'Twee reebruine ogen',
              'die hij niet vergeten kan'
            ]
          ]),
      const Lyric(
          id: 'LdJrve7VqgFSjZ6kzmyxxX',
          title: 'Drie schuintamboers',
          parts: <List<String>>[
            <String>[
              'Drie schuintamboers die kwamen uit het oosten,',
              'drie schuintamboers die kwamen uit het oosten.',
              'Van je rom-bom, wat maal ik daar om?',
              'Die kwamen uit het oosten, rombom.'
            ],
            <String>[
              'Eén van de drie zag daar een aardig meisje,',
              'één van de drie zag daar een aardig meisje.',
              'Van je rom-bom, wat maal ik daar om?',
              'Zag daar een aardig meisje, rombom.'
            ],
            <String>[
              'Zeg, meisje lief, wil jij met mij verkeren?',
              'Zeg, meisje lief, wil jij met mij gaan vrijen?',
              'Van je rom-bom, wat maal ik daar om?',
              'Wil jij met mij verkeren, rombom?'
            ],
            <String>[
              'Neen, jongeman, dat moet jij vader vragen.',
              'Neen, jongeman, dat moet jij vader vragen.',
              'Van je rombom, wat maal ik daar om?',
              'Dat moet je vader vragen, rombom.'
            ],
            <String>[
              'Zeg, ouwe heer, mag ik jouw dochter trouwen?',
              'Zeg, oude heer, mag ik jouw dochter trouwen?',
              'Van je rom-bom, wat maal ik daarom?',
              'Mag ik jouw dochter trouwen, rombom?'
            ],
            <String>[
              'Nee, jongeman, zeg mij: wat is jouw rijkdom?',
              'Zeg, jongeman, zeg mij: wat is jouw rijkdom?',
              'Van je rom-bom, wat maal ik daarom?',
              'Zeg mij: wat is jouw rijkdom, rombom.'
            ],
            <String>[
              'Mijn rijkdom is, daar wil ik niet om jokken,',
              'mijn rijkdom is die trommel met twee stokken.',
              'Van je rom-bom, wat maal ik daarom?',
              'Die trommel met twee stokken, rombom.'
            ],
            <String>[
              'Neen, jongeman, jij kunt mijn kind niet krijgen!',
              'Neen, jongeman, jij kunt mijn kind niet krijgen.',
              'Van je rom-bom, donder maar op!',
              'Jij kunt mijn kind niet krijgen, rombom.'
            ],
            <String>[
              'Zeg, ouwe heer, ik heb nog wat vergeten.',
              'Zeg, ouwe heer, ik heb nog iets vergeten.',
              'Van je rom-bom, wat maal ik daarom?',
              'Ik heb nog wat vergeten, rombom.'
            ],
            <String>[
              'Mijn vader is Groothertog van Bretagne.',
              'Mijn moeder is de Koningin van Spanje.',
              'Van je rom-bom, wat maal ik daarom?',
              'De Koningin van Spanje, rombom.\''
            ],
            <String>[
              'Zeg, jongeman, jij kunt mijn dochter krijgen!',
              'Zeg, jongeman, jij kunt mijn dochter krijgen!',
              'Van je rom-bom, neem haar maar mee.',
              'Je kunt mijn dochter krijgen, joechee!'
            ],
            <String>[
              'Nee, ouwe heer, jij mag je dochter houden!',
              'Nee, ouwe heer, jij mag je dochter houden',
              'want ik hoef haar niet meer, ik hoef haar niet meer.',
              'Jij mag je dochter houden, rombom.'
            ]
          ]),
      const Lyric(
          id: 'Tj8MtXEaAQxgRef5yufBZt',
          title: 'Roodkapje',
          parts: <List<String>>[
            <String>[
              'Zeg roodkapje waar ga je heen,',
              'zo alleen, zo alleen.',
              'Zeg roodkapje waar ga je heen,',
              'zo alleen.'
            ],
            <String>[
              '\'k Ga naar grootmoeder koekjes brengen,',
              'in het bos, in het bos.',
              '\'k Ga naar grootmoeder koekjes brengen,',
              'in het bos.'
            ],
            <String>[
              'In het bos wonen wilde dieren,',
              'in het bos, in het bos.',
              'In het bos wonen wilde dieren,',
              'in het bos.'
            ],
            <String>[
              'Ben niet bang voor de wilde dieren,',
              'ben niet bang, ben niet bang.',
              'Ben niet bang voor de wilde dieren,',
              'ben niet bang.'
            ],
            <String>[
              'Zal wel zien of jij niet bang bent,',
              'zal wel zien, zal wel zien.',
              'Zal wel zien of jij niet bang bent,',
              'zal wel zien.'
            ],
            <String>[
              'Pas maar op daar komt de wolf,',
              'pas maar op, pas maar op.',
              'Pas maar op daar komt de wolf,',
              'pas maar op.'
            ]
          ]),
      const Lyric(
          id: 'X4SDyqce1sM9RBXvk96BSv',
          title: 'Schaapje witte wol',
          parts: <List<String>>[
            <String>[
              'Schaapje, schaapje, heb je witte wol',
              'Ja baas, ja baas, drie zakken vol',
              'Één voor de meester en één voor zijn vrouw',
              'Één voor het kindje, dat bibbert van de kou',
              'Schaapje, schaapje, heb je witte wol.'
            ]
          ]),
      const Lyric(
          id: '3qNz1SD7mXvKTtycwuqJtw',
          title: 'Heidewietska',
          parts: <List<String>>[
            <String>[
              'Vroeger ging alles even kalm en bedaard',
              'Wagen en paard, matige vaart',
              'Of in de trekschuit bij een pijpje tabak',
              'Zat men op zijn gemak.',
              '\'t Ging maar niet fijn, zo aan de lijn',
              'Kwam je heel netjes waar je moest zijn.',
              'Nu komt het leven als een stormwind geraasd',
              'En heeft men altijd maar weer haast.'
            ],
            <String>[
              'Heidewitska vooruit geef gas',
              'Dat oude getreuzel komt niet meer te pas.',
              'Geen afstand is vandaag een hindernis,',
              'Als \'r maar benzine in het tankie is.',
              'Heidewitska vooruit geef gas',
              'Dat oude getreuzel komt niet meer te pas.'
            ],
            <String>[
              'Toen deed men alles meer met kalm overleg',
              'Ook op een weg, had men geen pech.',
              'Men reed elkaar nog niet bij voorkeur tot gruis',
              'Maar kwam nog heelhuids thuis.',
              'Duurde \'t wat lang, men was niet bang',
              'Want alles ging zijn rustige gang.',
              'Nu hoort bij \'t kruipende gedierte het paard',
              'En wordt als zeldzaamheid bewaard.'
            ],
            <String>[
              'Heidewitska vooruit geef gas',
              'Dat oude getreuzel komt niet meer te pas.',
              'Geen afstand is vandaag een hindernis,',
              'Als \'r maar benzine in het tankie is.',
              'Heidewitska vooruit geef gas',
              'Dat oude getreuzel komt niet meer te pas.'
            ],
            <String>[
              'En als een motor draait het leven van thans',
              'Geen diligence krijgt meer een kans.',
              'Hij die de tijd heeft nou die is zeker ziek',
              'Dat is een stuk antiek.',
              'Op hoed of pet, wordt niet gelet',
              'Maar heb je wel een cabriolet.',
              'Ook in de liefde is de motor een vraag',
              'Hoor maar het meisje van vandaag.'
            ],
            <String>[
              'Heidewitska vooruit geef gas',
              'Dat oude getreuzel komt niet meer te pas.',
              'Geen afstand is vandaag een hindernis,',
              'Als \'r maar benzine in het tankie is.',
              'Heidewitska vooruit geef gas',
              'Dat oude getreuzel komt niet meer te pas.'
            ]
          ]),
      const Lyric(
          id: 'DWHFb94grm1cwb7Q378ygS',
          title: 'In een groen knollenland',
          parts: <List<String>>[
            <String>[
              'In een groen, groen, groen, groen knolle-knollen-land',
              'Daar zaten twee haasje heel parmant',
              'En de een die blies de fluite-fluite-fluit',
              'En de ander sloeg de trommel',
              'Er kwam opeens een jager-jager aan',
              'En die heeft er één geschoten',
              'En dat heeft naar men denke-denken kan',
              'De andere zeer verdroten'
            ]
          ]),
      const Lyric(
          id: 'SdbM6j9uCtNiGRUW1hiTz5',
          title: 'O kindeke klein',
          parts: <List<String>>[
            <String>[
              'O Kindeke klein, O Kindeke teer,',
              'Uit hoge hemel daalt Gij neer.',
              'Verlaat uw Vaders heerlijk huis,',
              'Wordt arm en hulploos,',
              'Draagt een kruis,',
              'O kindeke klein, O kindeke teer.'
            ],
            <String>[
              'O Kindeke klein, O Kindeke teer,',
              'Gij zijt onz’ uitverkoren Heer.',
              'Ik geef U heel het harte mijn.',
              'Ach, laat mij eeuwig bij u zijn.',
              'O Kindeke klein, O Kindeke teer.'
            ]
          ]),
      const Lyric(
          id: 'LEt7kAx8sAjPmrAKuwkH8S',
          title: 'Knaapje zag een roosje staan',
          parts: <List<String>>[
            <String>[
              '\'t Knaapje zag een roosje staan',
              '\'t Roosje op de heide',
              '\'t Had zo\'n keurig kleedje aan,',
              'Snel is hij er heen gegaan,',
              '\'t Was of het hem beidde.',
              'Roosje, roosje, roosje rood,',
              'Roosje op de heide.'
            ],
            <String>[
              '\'t Knaapje zei: Ik pluk u af,',
              'Roosje op de heide.',
              '\'t Roosje zei: Ik weer u af,',
              'En ik prik u voor uw straf',
              'Wilt gij dat ik lijde?',
              'Roosje, roosje, roosje rood,',
              'Roosje op de heide.'
            ],
            <String>[
              'En het wilde knaapje brak',
              '\'t Roosje op de heide.',
              '\'t Roosje weerde zich en stak;',
              'Maar de knaap rukt van de tak',
              '\'t Roosje op de heide',
              'Roosje, roosje, roosje rood,',
              'Roosje op de heide.'
            ]
          ]),
      const Lyric(
          id: 'CYKsWc12s3YcUwRBMCFZRu',
          title: 'Peter is mijn ideaal',
          parts: <List<String>>[
            <String>[
              'Wie maakt dat ik niets meer lust',
              'Wie verstoort mijn rust?',
              'Ja, dat is Peter, ja, dat is Peter',
              'Waarom doe ik alles fout',
              'Ben ik warm of koud',
              'Dat komt door Peter, dat komt door Peter.'
            ],
            <String>[
              'Peter is mijn ideaal',
              'Grijze trui en rode sjaal',
              'Blauwe ogen, donker haar',
              'Groot en knap en achttien jaar',
              'Peter vindt de meisjes dom',
              'Kijkt niet naar ze om',
              'Want zo is Peter, want zo is Peter',
              'Peter, Peter, zie je niet',
              'Dat ik ziek ben van verdriet',
              'Peter, ik ben verliefd'
            ],
            <String>[
              'Peter zit in de hoogste klas',
              'Ik wou dat ik zover al was',
              'Maar als hij dan eens naar mij keek',
              'Was ik totaal van streek'
            ],
            <String>[
              'Wie maakt dat ik niets meer lust',
              'Wie verstoort mijn rust?',
              'Ja, dat is Peter, ja, dat is Peter',
              'Waarom doe ik alles fout',
              'Ben ik warm of koud',
              'Dat komt door Peter, dat komt door Peter'
            ],
            <String>[
              'Peter is mijn ideaal',
              'Grijze trui en rode sjaal',
              'Blauwe ogen, donker haar',
              'Groot en knap en achttien jaar',
              'Peter vindt de meisjes dom',
              'Kijkt niet naar ze om',
              'Want zo is Peter, want zo is Peter',
              'Peter, Peter, zie je niet',
              'Dat ik ziek ben van verdriet',
              'Peter, ik ben verliefd'
            ]
          ])
    ];
