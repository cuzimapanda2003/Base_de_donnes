-- VOTRE NOM: Marc-Antoine Blais
--

--
-- Serveur
--

-- Base de donnée airport 
create database if not exists airport;
use airport


-- Utilisateur alice, mot de passe, privilèges, localhost
create user if not exists "alice"@"localhost" identified by "pwd";
grant all on airport to "alice"@"localhost";


-- Utilisateur bob, mot de passe, privilèges, externe
create user if not exists "bob"@"%" identified by "pwd";




-- Table pilots, colonnes, types, attributs


create table if not exists pilots(
name varchar(300) not null,
age tinyint unsigned not null,
country varchar(20) not null,
experience tinyint unsigned not null default 0,
weekly_flight tinyint unsigned
);



-- Initialisation flights, insertions fournies

insert into `pilots`
    (`name`, `age`, `country`, `experience`, `weekly_flight`)
values
    ("dacey ward", 26, "uk", 0, null),
    ("timothy foley", 38, "spain", 15, 3),
    ("kyla bryan", 25, "spain", 0, null),
    ("celeste mcclain", 39, "uk", 24, 10),
    ("danielle luna", 50, "uk", 17, 7),
    ("odysseus gill", 51, "uk", 11, 1),
    ("vielka kelley", 28, "italy", 20, 5),
    ("tate bonner", 46, "mexico", 29, 1),
    ("carla drake", 54, "france", 23, 8),
    ("hyatt chandler", 60, "spain", 29, 5),
    ("marsden anderson", 51, "usa", 12, 5),
    ("phillip silva", 35, "usa", 30, 1),
    ("donovan walton", 33, "italy", 28, 5),
    ("keely maynard", 53, "usa", 21, 10),
    ("cadman sheppard", 34, "france", 29, 5),
    ("alyssa orr", 36, "usa", 20, 2),
    ("plato rhodes", 33, "usa", 22, 2),
    ("thor cortez", 55, "france", 29, 8),
    ("clinton carey", 58, "usa", 19, 5),
    ("jesse berg", 51, "spain", 19, 6),
    ("tanek wilder", 34, "france", 25, 9),
    ("karina schroeder", 44, "usa", 28, 6),
    ("gemma donovan", 38, "spain", 12, 4),
    ("thaddeus henson", 38, "france", 27, 2),
    ("igor frank", 34, "spain", 21, 5),
    ("charlotte warner", 26, "canada", 15, 8),
    ("travis merritt", 42, "canada", 16, 2),
    ("caryn dickson", 25, "france", 0, null),
    ("willow yates", 60, "spain", 24, 6),
    ("lesley jennings", 39, "france", 12, 2),
    ("jaquelyn munoz", 53, "italy", 10, 9),
    ("baxter pratt", 43, "canada", 17, 9),
    ("demetria browning", 40, "italy", 24, 3),
    ("azalia ramirez", 45, "italy", 20, 6),
    ("isabelle herrera", 57, "spain", 25, 8),
    ("felix sexton", 28, "uk", 12, 1),
    ("kieran shannon", 43, "mexico", 15, 9),
    ("yuli spencer", 59, "italy", 18, null),
    ("chancellor delacruz", 51, "canada", 27, 2),
    ("maggie boyle", 43, "usa", 10, 8),
    ("lois merrill", 27, "france", 25, 1),
    ("sophia casey", 60, "france", 29, 7),
    ("raven lamb", 49, "usa", 14, 2),
    ("thaddeus valenzuela", 51, "france", 17, 3),
    ("fitzgerald blackburn", 54, "spain", 23, 9),
    ("amity flowers", 44, "mexico", 22, 10),
    ("imelda york", 52, "france", 27, 8),
    ("deacon anderson", 25, "uk", 25, 6),
    ("geraldine castillo", 51, "canada", 23, 5),
    ("donna rodriguez", 48, "france", 12, 9),
    ("sylvester wise", 45, "canada", 14, 8),
    ("sydney summers", 29, "italy", 12, 1),
    ("elaine foley", 28, "france", 27, 10),
    ("isabelle glenn", 28, "usa", 23, 1),
    ("veda holden", 37, "usa", 17, 4),
    ("randall bishop", 44, "spain", 25, 1),
    ("sigourney donovan", 37, "usa", 14, 10),
    ("tyrone jacobs", 28, "mexico", 11, 8),
    ("shafira kent", 37, "france", 18, 6),
    ("cynthia dejesus", 35, "france", 10, 6),
    ("daniel ferguson", 28, "usa", 30, 3),
    ("mufutau bowman", 51, "mexico", 30, 9),
    ("sophia patton", 40, "uk", 22, 4),
    ("marvin craft", 27, "uk", 23, 4),
    ("mariko cole", 55, "usa", 30, 5),
    ("zachery cash", 55, "canada", 16, 6),
    ("reagan bass", 40, "italy", 13, 5),
    ("kirby stanton", 26, "uk", 18, 9),
    ("xander frank", 38, "mexico", 17, 5),
    ("jacob schultz", 58, "uk", 24, 7),
    ("kelly douglas", 46, "italy", 11, 6),
    ("alden snider", 49, "mexico", 13, 6),
    ("chanda santos", 26, "italy", 27, 5),
    ("upton gordon", 44, "italy", 23, 6),
    ("tashya wagner", 49, "mexico", 15, 5),
    ("todd zimmerman", 49, "canada", 14, 9),
    ("alan hebert", 34, "uk", 27, 3),
    ("vivien hickman", 38, "mexico", 19, 6),
    ("kennedy pena", 46, "usa", 24, 3),
    ("scott bond", 25, "france", 23, 2),
    ("justina nixon", 51, "france", 21, 1),
    ("wanda donovan", 37, "france", 18, 4),
    ("tasha smith", 26, "france", 21, 2),
    ("jackson patel", 43, "spain", 14, 5),
    ("wyatt mueller", 58, "mexico", 22, 6),
    ("halla romero", 34, "france", 29, 10),
    ("eugenia mullins", 60, "mexico", 13, null),
    ("ferris schultz", 56, "italy", 11, 2),
    ("ruby gilliam", 35, "uk", 26, 7),
    ("drake case", 46, "canada", 30, 10),
    ("basil estrada", 29, "uk", 21, 5),
    ("cara mccoy", 57, "canada", 14, 2),
    ("dane brooks", 48, "italy", 28, 10),
    ("ulric hooper", 46, "spain", 10, 3),
    ("belle hinton", 45, "mexico", 18, 10),
    ("zachary park", 37, "mexico", 13, 1),
    ("tucker watts", 42, "canada", 16, 8),
    ("roanna frost", 56, "france", 20, 5),
    ("amena howe", 54, "canada", 20, 3),
    ("sarah allen", 49, "mexico", 23, 3);

create table if not exists `flights` (
  `id` int unsigned auto_increment key,
  `pilot` varchar(255) not null,
  `number` char(4) not null,
  `departure_hour` tinyint unsigned not null,
  `departure_minutes` tinyint unsigned not null,
  `origin` varchar(255) not null,
  `destination` varchar(255) not null,
  `duration_minutes` mediumint unsigned not null,
  `delay_minutes` mediumint unsigned not null default 0,
  `plane` varchar(255) not null
);

insert into `flights` 
    (`pilot`, `number`, `departure_hour`, `departure_minutes`, `origin`, `destination`, `duration_minutes`, `delay_minutes`, `plane`) 
values
    ("dave", "x553", 19, 57, "usa", "italy", 702, 1186, "a350"),
    ("charlie", "g683", 22, 37, "italy", "italy", 623, 438, "b747"),
    ("eve", "m031", 12, 37, "italy", "spain", 315, 135, "b737"),
    ("alice", "h479", 11, 42, "uk", "canada", 93, 844, "b737"),
    ("charlie", "y894", 19, 52, "italy", "usa", 753, 697, "b737"),
    ("eve", "z078", 16, 18, "usa", "canada", 531, 1284, "a380"),
    ("charlie", "t408", 3, 7, "usa", "mexico", 162, 1330, "a350"),
    ("franck", "d006", 12, 34, "canada", "uk", 887, 317, "b747"),
    ("bob", "x656", 15, 36, "france", "uk", 957, 899, "b747"),
    ("franck", "s204", 21, 3, "usa", "france", 578, 735, "a380"),
    ("charlie", "m381", 9, 22, "france", "italy", 842, 618, "b737"),
    ("alice", "a988", 11, 19, "france", "canada", 771, 829, "b747"),
    ("eve", "b773", 22, 46, "france", "mexico", 331, 752, "b737"),
    ("bob", "w888", 8, 47, "canada", "france", 832, 1112, "b737"),
    ("dave", "n354", 18, 3, "france", "spain", 835, 318, "a380"),
    ("bob", "s373", 20, 43, "spain", "uk", 665, 883, "a380"),
    ("bob", "l015", 15, 55, "france", "spain", 256, 404, "b747"),
    ("franck", "t110", 2, 8, "canada", "spain", 781, 975, "b747"),
    ("franck", "u642", 0, 15, "spain", "france", 520, 334, "b747"),
    ("charlie", "k771", 23, 46, "usa", "italy", 923, 959, "b737"),
    ("charlie", "a409", 1, 16, "italy", "uk", 980, 227, "a380"),
    ("charlie", "b859", 10, 3, "mexico", "italy", 557, 565, "a380"),
    ("franck", "u191", 3, 50, "italy", "italy", 585, 637, "a350"),
    ("alice", "h435", 19, 13, "spain", "france", 973, 1238, "b747"),
    ("charlie", "y288", 0, 33, "italy", "canada", 799, 658, "b737"),
    ("dave", "h976", 18, 6, "mexico", "uk", 540, 772, "a350"),
    ("eve", "q507", 19, 54, "france", "france", 107, 319, "a380"),
    ("bob", "q807", 0, 29, "mexico", "france", 971, 257, "b737"),
    ("franck", "q205", 23, 11, "mexico", "canada", 374, 1390, "b747"),
    ("dave", "s700", 20, 1, "mexico", "usa", 256, 593, "a380"),
    ("eve", "i250", 23, 29, "uk", "mexico", 696, 1377, "a350"),
    ("alice", "c877", 18, 7, "italy", "france", 900, 582, "a380"),
    ("eve", "e196", 17, 39, "italy", "canada", 845, 588, "b737"),
    ("bob", "d536", 2, 27, "italy", "usa", 931, 175, "a380"),
    ("franck", "j309", 17, 15, "spain", "spain", 228, 117, "a380"),
    ("eve", "u505", 7, 6, "mexico", "mexico", 828, 764, "a380"),
    ("eve", "c589", 11, 30, "canada", "mexico", 874, 1418, "a380"),
    ("eve", "h150", 0, 10, "uk", "uk", 253, 263, "b737"),
    ("eve", "v645", 2, 17, "canada", "spain", 905, 769, "a380"),
    ("franck", "p604", 23, 2, "usa", "mexico", 545, 1404, "a380"),
    ("eve", "k794", 14, 18, "canada", "spain", 144, 1329, "a350"),
    ("bob", "s374", 12, 13, "mexico", "spain", 366, 653, "a330"),
    ("alice", "p783", 6, 27, "spain", "usa", 442, 1372, "b747"),
    ("bob", "q714", 16, 16, "france", "spain", 676, 1399, "a380"),
    ("dave", "x469", 11, 7, "mexico", "mexico", 143, 263, "a380"),
    ("bob", "a521", 13, 48, "canada", "mexico", 899, 1073, "a330"),
    ("charlie", "n312", 1, 37, "canada", "italy", 238, 884, "b747"),
    ("bob", "w827", 14, 0, "uk", "uk", 778, 1170, "a380"),
    ("bob", "g232", 2, 39, "canada", "italy", 127, 550, "b747"),
    ("alice", "d785", 14, 44, "uk", "usa", 290, 888, "b737"),
    ("dave", "z934", 8, 57, "usa", "france", 315, 181, "a350"),
    ("alice", "d303", 9, 0, "usa", "uk", 200, 943, "b747"),
    ("eve", "t974", 20, 46, "france", "uk", 129, 79, "b737"),
    ("franck", "w450", 15, 56, "spain", "france", 693, 906, "a380"),
    ("alice", "t994", 10, 51, "usa", "usa", 628, 646, "a380"),
    ("bob", "r126", 1, 12, "spain", "uk", 287, 81, "a350"),
    ("alice", "m210", 7, 42, "spain", "france", 557, 1253, "a350"),
    ("eve", "b141", 15, 24, "italy", "mexico", 971, 1065, "a380"),
    ("franck", "z896", 22, 15, "usa", "uk", 258, 867, "a380"),
    ("dave", "c450", 12, 24, "uk", "france", 695, 457, "b747"),
    ("dave", "a203", 18, 58, "usa", "mexico", 210, 644, "a330"),
    ("franck", "r984", 15, 21, "usa", "spain", 568, 1125, "b747"),
    ("dave", "d914", 23, 0, "usa", "canada", 125, 1179, "a330"),
    ("alice", "d010", 17, 32, "mexico", "uk", 710, 352, "b737"),
    ("franck", "t559", 22, 7, "italy", "spain", 491, 637, "b747"),
    ("dave", "k678", 20, 16, "france", "mexico", 160, 197, "a330"),
    ("dave", "b111", 19, 51, "spain", "mexico", 536, 1041, "a330"),
    ("dave", "s085", 19, 13, "spain", "italy", 436, 481, "b747"),
    ("dave", "f715", 18, 52, "italy", "italy", 81, 726, "a350"),
    ("alice", "t295", 18, 41, "uk", "usa", 279, 958, "a380"),
    ("alice", "y117", 2, 36, "spain", "uk", 319, 17, "a380"),
    ("dave", "w419", 1, 10, "uk", "usa", 249, 84, "b747"),
    ("charlie", "l724", 23, 40, "spain", "uk", 880, 1208, "b747"),
    ("franck", "s898", 15, 54, "italy", "spain", 974, 1246, "a380"),
    ("eve", "j886", 13, 16, "mexico", "canada", 494, 1049, "b737"),
    ("dave", "o643", 7, 35, "italy", "usa", 961, 560, "b737"),
    ("eve", "n245", 2, 45, "italy", "spain", 426, 275, "a380"),
    ("alice", "t041", 3, 45, "usa", "france", 232, 258, "b747"),
    ("bob", "t842", 4, 26, "mexico", "usa", 115, 1330, "a380"),
    ("alice", "n935", 15, 4, "spain", "france", 862, 605, "a330"),
    ("franck", "i118", 23, 16, "spain", "spain", 593, 493, "b737"),
    ("alice", "x379", 2, 44, "usa", "italy", 306, 302, "b737"),
    ("charlie", "s599", 11, 47, "usa", "usa", 135, 1158, "a380"),
    ("eve", "i619", 18, 31, "spain", "mexico", 879, 307, "b747"),
    ("franck", "o837", 19, 44, "spain", "usa", 675, 360, "b737"),
    ("bob", "k407", 0, 50, "italy", "usa", 185, 653, "a330"),
    ("bob", "p551", 3, 2, "spain", "usa", 950, 1087, "a350"),
    ("alice", "c492", 7, 41, "spain", "france", 436, 8, "a380"),
    ("alice", "p073", 1, 59, "france", "france", 330, 1255, "b747"),
    ("bob", "x665", 4, 45, "usa", "italy", 924, 257, "a350"),
    ("bob", "i975", 20, 41, "italy", "uk", 770, 204, "b747"),
    ("bob", "c158", 6, 31, "italy", "italy", 246, 852, "a330"),
    ("alice", "k208", 22, 35, "canada", "uk", 991, 654, "b747"),
    ("alice", "x079", 4, 18, "italy", "uk", 191, 389, "a350"),
    ("franck", "h202", 20, 42, "spain", "spain", 570, 689, "a380"),
    ("charlie", "p397", 14, 38, "france", "uk", 901, 902, "a330"),
    ("bob", "e856", 1, 18, "mexico", "canada", 920, 101, "b747"),
    ("dave", "a054", 17, 18, "uk", "mexico", 71, 183, "b737"),
    ("eve", "o733", 18, 22, "uk", "spain", 495, 466, "b747"),
    ("franck", "l490", 2, 17, "mexico", "uk", 338, 874, "b737"),
    ("alice", "y680", 6, 7, "italy", "uk", 431, 231, "b737"),
    ("alice", "p757", 1, 7, "mexico", "spain", 411, 764, "b737"),
    ("eve", "g378", 9, 44, "mexico", "spain", 593, 913, "b737"),
    ("eve", "u297", 3, 14, "france", "france", 910, 608, "a330"),
    ("charlie", "n284", 10, 10, "usa", "italy", 50, 608, "a380"),
    ("alice", "a135", 3, 43, "spain", "usa", 980, 359, "a330"),
    ("alice", "y952", 19, 31, "usa", "italy", 852, 1135, "a350"),
    ("eve", "x250", 0, 40, "mexico", "usa", 395, 397, "a380"),
    ("bob", "o115", 12, 33, "spain", "usa", 622, 1233, "a350"),
    ("charlie", "y388", 4, 15, "spain", "usa", 792, 513, "b747"),
    ("bob", "g956", 23, 46, "canada", "canada", 544, 20, "b737"),
    ("bob", "m205", 9, 19, "mexico", "france", 64, 400, "a380"),
    ("alice", "s338", 11, 30, "france", "spain", 919, 320, "a350"),
    ("dave", "b378", 1, 17, "uk", "usa", 904, 796, "a350"),
    ("eve", "f861", 12, 29, "uk", "france", 597, 466, "a380"),
    ("dave", "d991", 12, 7, "uk", "italy", 30, 313, "b737"),
    ("alice", "i662", 0, 44, "mexico", "italy", 220, 983, "a350"),
    ("charlie", "h056", 12, 59, "italy", "italy", 244, 518, "a350"),
    ("dave", "h056", 22, 9, "canada", "canada", 100, 340, "b747"),
    ("charlie", "j826", 22, 32, "uk", "mexico", 895, 897, "a380"),
    ("dave", "e059", 8, 58, "uk", "france", 244, 105, "b747"),
    ("bob", "p296", 15, 17, "usa", "italy", 984, 163, "b737"),
    ("franck", "y306", 14, 44, "mexico", "mexico", 290, 217, "b747"),
    ("dave", "j412", 16, 21, "spain", "usa", 542, 735, "b737"),
    ("franck", "g505", 6, 7, "spain", "mexico", 760, 787, "a330"),
    ("dave", "g488", 14, 43, "italy", "spain", 82, 288, "a330"),
    ("alice", "z940", 3, 6, "italy", "france", 925, 1102, "a330"),
    ("alice", "k921", 9, 53, "usa", "usa", 734, 1384, "a350"),
    ("dave", "w499", 12, 37, "mexico", "usa", 784, 1119, "b737"),
    ("dave", "g194", 1, 9, "uk", "mexico", 44, 225, "b737"),
    ("eve", "q258", 14, 5, "spain", "usa", 52, 1008, "b747"),
    ("bob", "c543", 19, 15, "canada", "italy", 614, 142, "a330"),
    ("charlie", "v217", 7, 34, "usa", "italy", 542, 1171, "a330"),
    ("dave", "h740", 16, 47, "spain", "spain", 582, 361, "a330"),
    ("bob", "p972", 18, 34, "spain", "spain", 677, 351, "a350"),
    ("eve", "x569", 22, 6, "canada", "spain", 870, 64, "b747"),
    ("bob", "y322", 19, 44, "canada", "mexico", 961, 5, "a350"),
    ("franck", "h207", 16, 23, "france", "uk", 819, 662, "a380"),
    ("alice", "z733", 11, 9, "uk", "uk", 705, 171, "a380"),
    ("eve", "s836", 15, 31, "uk", "canada", 245, 540, "b747"),
    ("alice", "s168", 21, 56, "uk", "france", 442, 448, "a380"),
    ("alice", "x784", 1, 19, "france", "spain", 382, 746, "b737"),
    ("dave", "t304", 23, 2, "canada", "usa", 935, 1026, "a380"),
    ("alice", "h028", 13, 4, "italy", "mexico", 922, 1120, "a330"),
    ("eve", "i990", 2, 30, "canada", "usa", 332, 892, "b737"),
    ("alice", "c472", 12, 45, "usa", "mexico", 418, 1104, "a350"),
    ("dave", "k918", 3, 23, "france", "france", 118, 502, "b737"),
    ("alice", "w186", 4, 20, "canada", "uk", 148, 1363, "a330"),
    ("franck", "e315", 22, 51, "spain", "usa", 988, 664, "a330"),
    ("alice", "j890", 13, 48, "italy", "canada", 803, 261, "a380"),
    ("eve", "k640", 10, 11, "uk", "mexico", 196, 1365, "b737"),
    ("eve", "i099", 10, 3, "france", "canada", 542, 574, "a330"),
    ("charlie", "p475", 14, 24, "spain", "uk", 766, 833, "b737"),
    ("charlie", "q617", 5, 29, "france", "canada", 121, 833, "a330"),
    ("dave", "j269", 7, 49, "usa", "italy", 729, 626, "a350"),
    ("eve", "g150", 9, 36, "mexico", "uk", 811, 879, "a350"),
    ("eve", "b401", 16, 17, "uk", "italy", 342, 358, "b737"),
    ("franck", "o754", 5, 46, "france", "mexico", 145, 621, "b737"),
    ("alice", "h720", 19, 21, "italy", "usa", 241, 831, "b747"),
    ("charlie", "y465", 5, 1, "canada", "italy", 746, 739, "a330"),
    ("franck", "i797", 16, 45, "uk", "spain", 515, 622, "a330"),
    ("dave", "e958", 9, 42, "mexico", "canada", 101, 233, "a380"),
    ("bob", "a968", 8, 0, "spain", "italy", 937, 763, "a330"),
    ("eve", "x319", 6, 46, "usa", "mexico", 823, 1151, "b737"),
    ("franck", "s811", 10, 1, "mexico", "italy", 662, 572, "b737"),
    ("alice", "a310", 7, 19, "spain", "france", 878, 107, "a330"),
    ("dave", "f697", 10, 7, "mexico", "italy", 606, 21, "b747"),
    ("eve", "l187", 10, 41, "uk", "spain", 499, 931, "a350"),
    ("charlie", "h149", 4, 57, "spain", "uk", 793, 275, "b747"),
    ("bob", "d870", 15, 0, "italy", "spain", 204, 1135, "b747"),
    ("eve", "q842", 0, 12, "canada", "usa", 528, 1413, "a350"),
    ("eve", "d918", 14, 54, "canada", "mexico", 629, 894, "b737"),
    ("alice", "p792", 23, 58, "italy", "italy", 835, 1405, "b737"),
    ("eve", "s785", 14, 36, "italy", "france", 544, 621, "b737"),
    ("charlie", "l839", 4, 39, "france", "uk", 51, 609, "b737"),
    ("franck", "r020", 9, 58, "uk", "canada", 495, 980, "a380"),
    ("alice", "j300", 16, 21, "usa", "france", 363, 1352, "a330"),
    ("dave", "h894", 14, 59, "france", "mexico", 313, 253, "b747"),
    ("dave", "w724", 17, 42, "spain", "mexico", 793, 1099, "a350"),
    ("bob", "e549", 18, 32, "uk", "spain", 501, 899, "a350"),
    ("dave", "i667", 5, 41, "spain", "italy", 702, 996, "a350"),
    ("bob", "r547", 5, 41, "italy", "usa", 492, 656, "b737"),
    ("eve", "c388", 16, 11, "spain", "uk", 623, 478, "a380"),
    ("eve", "q816", 1, 18, "italy", "uk", 290, 1200, "a350"),
    ("bob", "p046", 14, 34, "uk", "canada", 402, 885, "b747"),
    ("charlie", "n751", 13, 27, "france", "uk", 987, 1202, "b737"),
    ("bob", "j518", 22, 56, "france", "usa", 182, 834, "a350"),
    ("bob", "f174", 15, 0, "usa", "uk", 181, 1257, "a350"),
    ("franck", "b096", 10, 18, "canada", "uk", 191, 1297, "a350"),
    ("dave", "l396", 10, 26, "uk", "france", 712, 549, "a330"),
    ("charlie", "j068", 9, 11, "italy", "usa", 354, 921, "a350"),
    ("charlie", "e496", 7, 48, "canada", "canada", 128, 173, "a380"),
    ("eve", "u628", 18, 36, "italy", "france", 247, 1219, "b737"),
    ("bob", "q481", 12, 0, "uk", "spain", 710, 625, "b737"),
    ("dave", "a229", 7, 29, "spain", "mexico", 917, 278, "a350"),
    ("franck", "l235", 3, 40, "usa", "france", 261, 838, "a350"),
    ("dave", "l624", 16, 35, "uk", "canada", 678, 214, "a330"),
    ("charlie", "s466", 18, 28, "uk", "usa", 824, 220, "a380"),
    ("charlie", "p151", 9, 49, "italy", "spain", 886, 1198, "b747"),
    ("dave", "k580", 15, 35, "mexico", "uk", 745, 436, "a350");



--
-- Modélisation
--

/*

NOM TABLE
-------------
col_a TYPE ATTR ATTR = DEFAULT
col_b TYPE ATTR ATTR = DEFAULT
...

*/


--
-- Insertions minimales
--

-- pilots

insert into `pilots`
(name, age, country)
values
("patrice", 18, "canada");


-- flights
insert into `flights`
(pilot, number, departure_hour, departure_minutes, origin, destination,duration_minutes, plane)
values
("patrice","z123",20,52,"montreal","japon", 840, "239");



--
-- Pilotes
--

-- Les pilotes, plus de 50 ans: nom, âge, nationalité, expérience, vols hebdomadaires
select 
    name,
    age,
    country,
    experience,
    weekly_flight
from pilots where age > 50;


-- Les pilotes, européens: `Nom`, `Nationalité`
select
    name as `Nom`,
    country as `Nationalité`
from pilots where country IN("france", "uk", "spain", "italy");

-- Les pilotes, pas États-Unis: `Nom`, `Nationalité`

select
    name as `Nom`,
    country as `Nationalité`
from pilots where country != "usa";


-- Les pilotes, en service: `Nom`, `Expérience`, `Vols hebdomadaires`, *Vols annuels*
select
    name as `Nom`,
    experience as `Expérience`,
    weekly_flight as `Vols hebdomadaires`,
    weekly_flight * 52 as `Vols annuelles`
from pilots where weekly_flight is not null;



-- Les pilotes, pilotés plus de moitié de la vie: `Nom`, `Âge`, `Expérience`, *% Exp*
select 
    name as `Nom`,
    age as `Âge`,
    experience as `Expérience`,
    experience / age * 100 as `% Exp`
from pilots where experience > age / 2;


--
-- Vols
--

-- Les vols, de alice, dans un Airbus: numéro, *départ*, origine, destination, durée, retard, avion

select
    number as `numéro`,
    CONCAT(CAST(departure_hour AS CHAR), ':', CAST(departure_minutes AS CHAR)) AS `*départ*`,
    origin as `origine`,
    destination,
    duration_minutes as `durée`,
    delay_minutes as `retard`,
    plane as `avion`
    from flights where pilot = "alice" && plane LIKE "a%";




-- Les vols, intra-europe: Pilote, Numéro, Origine, Destination
select
    pilot as `Pilote`,
    number as `Numéro`,
    origin as `Origine`,
    destination as `Destination`
from flights where destination IN("france", "uk", "spain", "italy");


-- [BONUS] Les vols, en retard au moins 1h: `Pilote`, `Numéro`, `Origine`, `Destination`, `Avion`, *Départ*, *Durée*, *Arrivée prévue*, *Retard*, *Arrivée réelle*

select
    pilot as `Pilote`,
    number as `Numéro`,
    origin as `Origine`,
    destination as `Destination`,
    plane as `Avion`,
    CONCAT(CAST(departure_hour AS CHAR), ':', CAST(departure_minutes AS CHAR)) AS `*départ*`,
    CONCAT(FLOOR(duration_minutes / 60), 'h', duration_minutes % 60) AS TimeFormatted,
    CONCAT(FLOOR(duration_minutes / 60 + departure_hour), ':', duration_minutes % 60 + departure_minutes) AS '*Arrivé prévu*'
    
    
from flights where delay_minutes > 60;

