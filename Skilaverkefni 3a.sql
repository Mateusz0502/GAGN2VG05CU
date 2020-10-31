use ProgressTracker_V6;
ALTER TABLE `Schools` ADD COLUMN `schoolInfo` JSON DEFAULT NULL;
INSERT INTO `Schools`(`schoolName`)
VALUES

('Framhaldsskólans í Mosfellsbæ'),
('Menntaskólinn í Reykjavík'),
('Fjölbrautaskóli Suðurlands'),
('Menntaskólinn við Sund');

SELECT * FROM `Schools`;

UPDATE `Schools`
SET schoolInfo = '{"heiti":Framhaldsskólans í Mossfellsbæ","stuttNafn":"FMOS","stadsetning":{"lat":64.165314,"lon":-21.703301},"starfsfolk":{"1":{"nafn":"Guðbjörg Aðalbergsdóttir","titill":"Skólastýra","kennitala":"480109-0310"}}}'
WHERE schoolID = 1;

UPDATE `Schools`
SET schoolInfo = '{"heiti":"Menntaskólinn í Reykjavík","stuttNafn":"MR","stadsetning":{"lat":64.1460669,"lon":-21.9368808},"starfsfolk":{"1":{"nafn":"Elísabet Siemsen","titill":"Skólastýra","kennitala":"460269-2109"}}}'
WHERE schoolID = 2;

UPDATE `Schools`
SET schoolInfo = '{"heiti":"Fjölbrautaskóli Suðurlands","stuttNafn":"FSu","stadsetning":{"lat":63.932300,"lon":-20.997611},"starfsfolk":{"1":{"nafn":"Olga Lísa Garðarsdóttir","titill":"Skólastýra","kennitala":"491181-0289"}}}'
WHERE schoolID = 3;

UPDATE `Schools`
SET schoolInfo = '{"heiti":"Menntaskólinn við Sund","stuttNafn":"MS","stadsetning":{"lat":64.131316,"lon":-21.859105},"starfsfolk":{"1":{"nafn":"Már Vilhjálmsson","titill":"Skólastýra","kennitala":"700670-0589"}}}'
WHERE schoolID = 4;

delimiter //
DROP PROCEDURE IF EXISTS `GetSchoolInfo` //
CREATE PROCEDURE `GetSchoolInfo` (
  `param_schoolID` INT
)
BEGIN
  SELECT schoolInfo FROM `Schools` WHERE `Schools`.schoolID = `param_schoolID`;
END //
delimiter ;

CALL `GetSchoolInfo`(3);