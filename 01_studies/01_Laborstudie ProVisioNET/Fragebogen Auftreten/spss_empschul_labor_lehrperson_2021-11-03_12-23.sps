* Um den Datensatz in SPSS zu laden, führen Sie diese Syntax bitte vollständig aus.
* - entweder (a) wählen Sie im Menü oben: "Ausführen", "Alles"
* - oder (b) markieren Sie die gesamte Syntax (Strg+A) und klicken Sie auf den Pfeil (Aktuellen Befehl ausführen)

DATA LIST FREE(TAB)
 /CASE (F8.0)
  SERIAL (A4)
  REF (A4)
  QUESTNNR (A4)
  MODE (A16)
  STARTED (DATETIME)
  LM01_01 (F3.0)
  LM01_02 (F3.0)
  LM01_03 (F3.0)
  LM01_04 (F3.0)
  LM01_05 (F3.0)
  LM01_06 (F3.0)
  LM01_07 (F3.0)
  LM01_08 (F3.0)
  LB01_01 (F3.0)
  LB01_02 (F3.0)
  LB01_03 (F3.0)
  LP01_01 (F3.0)
  LP01_02 (F3.0)
  LP01_03 (F3.0)
  LP01_04 (F3.0)
  LP01_05 (F3.0)
  LP01_06 (F3.0)
  LP01_07 (F3.0)
  LP01_08 (F3.0)
  LV01_01 (F3.0)
  LV01_02 (F3.0)
  LV01_03 (F3.0)
  LO01_01 (F8.0)
  LO01_02 (F8.0)
  LI02_01_CN (F3.0)
  LI02_01_1 (F1.0)
  LI02_01_2 (F1.0)
  LI02_01_3 (F1.0)
  LI02_01_4 (F1.0)
  LI03_01 (F8.0)
  LI04_01 (F8.0)
  LI05_01 (A16)
  LI05_02 (A16)
  LI05_03 (A16)
  LI06_05 (F8.0)
  LI10_05 (A16)
  LI07 (F3.0)
  LI11_01 (A4)
  LI12_01 (F8.0)
  LI13_01 (F8.0)
  LI14 (F3.0)
  LI14_01 (A128)
  TIME001 (F8.0)
  TIME002 (F8.0)
  TIME003 (F8.0)
  TIME_SUM (F8.0)
  MAILSENT (DATETIME)
  LASTDATA (DATETIME)
  FINISHED (F1.0)
  Q_VIEWER (F1.0)
  LASTPAGE (F8.0)
  MAXPAGE (F8.0)
  MISSING (F8.0)
  MISSREL (F8.0)
  TIME_RSI (F12.4)
  DEG_TIME (F8.0).
BEGIN DATA
98			base	interview	21-07-2021 16:21:39	3	3	4	3	1	2	3	1	4	3	4	4	4	2	3	3	2	2	3	4	4	4	70	5	1	1	2	1	1	22	0	Sport	Spanisch		101	Spanisch	1	3	5	4	1	FSJ	42	54	215	311		21-07-2021 16:26:50	1	0	3	3	3	1	1.26	14	
100			base	interview	27-07-2021 16:21:49	4	3	3	2	2	2	3	3	3	2	3	3	3	2	4	3	3	4	3	2	2	3	65	6	1	1	2	1	1	24	6	Sport	Geschichte		102	Geschichte	1	10	23	36	1	Nachhilfe, Sporttrainer	72	113	147	332		27-07-2021 16:27:21	1	0	3	3	3	1	
0.95	6	
101			base	interview	28-07-2021 14:46:11	3	3	3	3	2	2	3	3	3	3	3	3	4	2	2	3	3	3	2	3	3	3	75	1	1	2	1	1	1	24	0	Englisch	Deutsch		103	Deutsch	1	8	28	8	1	Nachhilfe	43	63	176	282		28-07-2021 14:50:54	1	0	3	3	3	1	1.24	12	
102			base	interview	05-08-2021 14:54:24	4	4	4	2	2	2	2	3	1	1	3	2	3	3	4	4	4	3	2	2	1	2	85	5	1	2	1	1	1	23	0	Deutsch	Ethik		104	Ethik	1	8	14	24	1	FSJ Politik und jugendpolitische Bildungsarbeit (Klasse 5-10)	44	119	173	336		
05-08-2021 15:00:00	1	0	3	3	3	1	1.01	4	
104			base	interview	31-08-2021 13:00:51	4	3	3	2	2	3	3	2	3	3	2	3	3	2	3	3	2	2	2	3	4	4	45	5	1	2	1	1	1	55	29	Englisch	Sport		201	Englisch	2						57	38	193	288		31-08-2021 13:05:39	1	0	3	3	3	1	1.44	25	
106			base	interview	01-09-2021 15:56:19	4	4	2	3	3	1	3	4	4	4	4	4	4	3	4	4	2	2	3	3	4	4	75	5	1	2	1	1	1	23	0	Englisch	GRW		105	GRW	1	8	25	10	1	Nachhilfe für diverse Fächer / Altersgruppen	22	93	161	276		01-09-2021 16:00:55	1	0	
3	3	3	1	1.47	23	
107			base	interview	15-09-2021 11:06:26	2	4	4	3	2	2	2	2	3	3	3	4	3	2	4	4	3	3	2	4	4	2	90	4	1	1	2	1	1	25	0	Sport	ev. Religion		106	ev. Religion	1	6	20	4	1	AG an Schulen, Trainertätigkeit, Nachhilfe(einzel) 	41	93	94	228		
15-09-2021 11:10:14	1	0	3	3	3	1	1.44	22	
109			base	interview	27-09-2021 16:56:59	4	4	3	4	2	1	3	4	4	4	4	4	4	3	4	4	3	3	3	3	3	4	85	2	1	2	1	1	1	56	32	Geschichte	Deutsch	Gewi	202	Geschichte	2						66	28	330	424		27-09-2021 17:04:03	1	0	3	3	0	0	1.44	39	
110			base	interview	05-10-2021 15:46:46	4	3	4	4	1	2	4	4	4	3	3	3	4	3	4	3	4	3	3	3	3	3	85	4	1	2	1	1	1	27	3	Deutsch	Mathematik	Sachunterricht	203	Mathematik	2						64	30	256	350		05-10-2021 15:52:36	1	0	3	3	0	0	1.51	35	
111			base	interview	06-10-2021 11:53:09	3	3	3	3	2	2	3	3	4	3	3	3	3	3	4	4	4	3	3	4	4	4	80	8	1	2	1	1	1	23	0	Mathematik	Sport		107	Mathematik	1	9.	50	12	1	Nachhilfe Klasse 5-7 NNS Leipzig seit Februar 2020, LSGM Leipzig seit 2018	
61	177	220	458		06-10-2021 12:00:48	1	0	3	3	3	1	0.74	0	
112			base	interview	13-10-2021 11:50:46	4	4	4	4	2	2	3	3	3	3	4	3	3	2	4	4	3	3	3	2	2	2	80	10	1	2	1	1	1	24	0	Englisch	Spanisch		108	Englisch	1	9	30	14	1	Nachhilfe	28	132	241	401		13-10-2021 11:57:27	1	0	3	3	3	1	1.08	11	
113			base	interview	18-10-2021 15:55:44	2	3	4	2	2	3	2	3	3	3	3	3	2	3	4	3	3	3	3	3	3	3	75	8	1	1	2	1	1	23	0	Mathematik	Chemie	-	109	Chemie	1	9/7	60	12	1	Praktike, etwas Nachhilfe	50	143	252	445		18-10-2021 16:03:09	1	0	3	3	0	0	
0.8	0	
END DATA.


VARIABLE WIDTH  SERIAL REF QUESTNNR MODE LI05_01 LI05_02 LI05_03 LI10_05
 LI11_01 LI14_01 (8) STARTED MAILSENT LASTDATA (20)
.


**** Variable und Value Labels *********************************************************************************************


VARIABLE LABELS
 CASE 'Interview-Nummer (fortlaufend)'
 SERIAL 'Seriennummer (sofern verwendet)'
 REF 'Referenz (sofern im Link angegeben)'
 QUESTNNR 'Fragebogen, der im Interview verwendet wurde'
 MODE 'Interview-Modus'
 STARTED 'Zeitpunkt zu dem das Interview begonnen hat (Europe/Berlin)'
 LM01_01 'Klassenmanagement: Die gesamte Unterrichtslektion wurde für den Lernstoff verwendet.'
 LM01_02 'Klassenmanagement: Ich habe alles mitbekommen, was in der Klasse passiert ist.'
 LM01_03 'Klassenmanagement: Den Lernenden war jederzeit klar, was sie tun sollten.'
 LM01_04 'Klassenmanagement: Die Lernenden konnten ungestört arbeiten.'
 LM01_05 'Klassenmanagement: Die Lernenden waren die ganze Unterrichtslektion über aktiv bei der Sache.'
 LM01_06 'Klassenmanagement: Ich habe vieles mit kurzen Blicken und knappen Gesten geregelt.'
 LM01_07 'Klassenmanagement: Auf Störungen habe ich angemessen reagiert.'
 LM01_08 'Klassenmanagement: Bei Störungen gab ich den Lernenden ein klares STOP-Signal.'
 LB01_01 'Bilanz: Die Lernenden haben in dieser Unterrichtslektion etwas dazu gelernt.'
 LB01_02 'Bilanz: Die Lernenden haben sich in dieser Unterrichtslektion wohl gefühlt.'
 LB01_03 'Bilanz: Mediennutzung und Sozialformen waren dem Inhalt und der Situation der Unterrichtslektion angemessen.'
 LP01_01 'Präsenzindikatoren: Ich hatte eine aufrechte, der Klasse zugewandte Körperhaltung.'
 LP01_02 'Präsenzindikatoren: Ich habe den Lernenden direkt in die Augen geschaut.'
 LP01_03 'Präsenzindikatoren: Ich habe meine Position im Raum bewusst eingesetzt und variiert.'
 LP01_04 'Präsenzindikatoren: Ich habe alle oft angesehen.'
 LP01_05 'Präsenzindikatoren: Meine Artikulation, Lautstärke und Tonhöhe waren angemessen.'
 LP01_06 'Präsenzindikatoren: Meine Sprechgeschwindigkeit und Sprechpausen waren angemessen.'
 LP01_07 'Präsenzindikatoren: Mein Sprechanteil an der gesamten Sprechzeit der Unterrichtslektion war angemessen.'
 LP01_08 'Präsenzindikatoren: Meine Gestik und Mimik waren abwechslungsreich und ausdrucksstark.'
 LV01_01 'Natürliches Verhalten: Während der Unterrichtslektion habe ich mich sehr natürlich verhalten.'
 LV01_02 'Natürliches Verhalten: Es war für mich kein Problem, vor einer fiktiven Klasse zu unterrichten.'
 LV01_03 'Natürliches Verhalten: Beim Unterrichten vor einer fiktiven Klasse habe ich mich so verhalten, wie ich es auch in der...'
 LO01_01 'Redeanteil: Wieviel Prozent der gesamten Unterrichtslektion hat nach Ihrer Schätzung Ihr eigener Redeanteil eingenomm...'
 LO01_02 'Redeanteil: Wenn ich Fragen oder Aufgaben gestellt habe, habe ich den Lernenden folgende Zeit (in Sekunden) zum Nachd...'
 LI02_01_CN 'Geschlecht: Anzahl ausgewählter Optionen oder Code für Ausweichoption (falls &lt; 0) für: Geschlechtsidentität'
 LI02_01_1 'Geschlecht: Geschlechtsidentität/weiblich'
 LI02_01_2 'Geschlecht: Geschlechtsidentität/männlich'
 LI02_01_3 'Geschlecht: Geschlechtsidentität/divers'
 LI02_01_4 'Geschlecht: Geschlechtsidentität/keine Angabe'
 LI03_01 'Alter: Alter in Jahren'
 LI04_01 'Berufserfahrung: ... Jahre'
 LI05_01 'Fächer: 1. Fach ...'
 LI05_02 'Fächer: 2. Fach (optional) ...'
 LI05_03 'Fächer: 3. Fach (optional) ...'
 LI06_05 'ID: Meine persönliche ID'
 LI10_05 'Unterricht: In welchem Fach wurde die eben gehaltene Unterrichtslektion durchgeführt?'
 LI07 'Beruf'
 LI11_01 'Semester: ... Fachsemester'
 LI12_01 'Unterrichtserfahrung: ... Unterrichtseinheiten'
 LI13_01 'Praktikum: ... Wochen'
 LI14 'Außerschulische Lehrerfahrung'
 LI14_01 'Außerschulische Lehrerfahrung: ja und zwar'
 TIME001 'Verweildauer Seite 1'
 TIME002 'Verweildauer Seite 2'
 TIME003 'Verweildauer Seite 3'
 TIME_SUM 'Verweildauer gesamt (ohne Ausreißer)'
 MAILSENT 'Versandzeitpunkt der Einladungsmail (nur für nicht-anonyme Adressaten)'
 LASTDATA 'Zeitpunkt als der Datensatz das letzte mal geändert wurde'
 FINISHED 'Wurde die Befragung abgeschlossen (letzte Seite erreicht)?'
 Q_VIEWER 'Hat der Teilnehmer den Fragebogen nur angesehen, ohne die Pflichtfragen zu beantworten?'
 LASTPAGE 'Seite, die der Teilnehmer zuletzt bearbeitet hat'
 MAXPAGE 'Letzte Seite, die im Fragebogen bearbeitet wurde'
 MISSING 'Anteil fehlender Antworten in Prozent'
 MISSREL 'Anteil fehlender Antworten (gewichtet nach Relevanz)'
 TIME_RSI 'Maluspunkte für schnelles Ausfüllen'
 DEG_TIME 'Maluspunkte für schnelles Ausfüllen'
.


VALUE LABELS
 /LM01_01 LM01_02 LM01_03 LM01_04 LM01_05 LM01_06 LM01_07 LM01_08 LB01_01
 LB01_02 LB01_03 LP01_01 LP01_02 LP01_03 LP01_04 LP01_05 LP01_06 LP01_07
 LP01_08 LV01_01 LV01_02 LV01_03
 1 'stimme nicht zu' 4 'stimme zu' -9 'nicht beantwortet'
 /LI02_01_CN 0 'nicht beantwortet'
 /LI02_01_1 LI02_01_2 LI02_01_3 LI02_01_4 1 'nicht gewählt' 2 'ausgewählt'
 /LI07 1 'Lehramtsstudent:in' 2 'Lehrer:in' 3 'Sonstiges' -9 'nicht beantwortet'
 /LI14 1 'ja und zwar:' 2 'nein' -9 'nicht beantwortet'
 /FINISHED 0 'abgebrochen' 1 'ausgefüllt'
 /Q_VIEWER 0 'Teilnehmer' 1 'Durchklicker'
.

MISSING VALUES
 LM01_01 LM01_02 LM01_03 LM01_04 LM01_05 LM01_06 LM01_07 LM01_08 LB01_01
 LB01_02 LB01_03 LP01_01 LP01_02 LP01_03 LP01_04 LP01_05 LP01_06 LP01_07
 LP01_08 LV01_01 LV01_02 LV01_03 LI02_01_CN LI07 LI14 (-8,-9)
.

