INSERT INTO `candidate` VALUES (1,'Jaguar_animal','Jaguar (Großkatze)','Beschreibung einer Großkatze'),(2,'Jaguar_car','Jaguar (Auto)','Beschreibung einer Automarke'),(3,'Golf_sport','Golf (Sport)','Beschreibung eines Sports'),(4,'Golf_car','Golf (Auto)','Beschreibung eines Autos'),(5,'Golf_geo','Golf (Gewässer)','Beschreibung einer Gewässerform');
INSERT INTO `haslabel` VALUES (1,1),(2,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14);
INSERT INTO `label` VALUES (2,'Golf'),(1,'Jaguar');
INSERT INTO `labelHasCandidate` VALUES (1,1),(1,2),(2,3),(2,4),(2,5);
INSERT INTO `text` VALUES (1,'Der neue Jaguar ist kein Golf.');
INSERT INTO `textHasLabel` VALUES (1,1,1,9,15),(2,1,2,25,29);