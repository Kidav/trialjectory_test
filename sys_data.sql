-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.12 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2020-01-13 23:04:57
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
-- Dumping data for table trialjectory.biomarker: ~6 rows (approximately)
DELETE FROM `biomarker`;
/*!40000 ALTER TABLE `biomarker` DISABLE KEYS */;
INSERT INTO `biomarker` (`id`, `name`) VALUES
	(1, '1'),
	(2, '2'),
	(3, '3a'),
	(4, '3b'),
	(5, '3c'),
	(6, '4 (metastatic)');
/*!40000 ALTER TABLE `biomarker` ENABLE KEYS */;

-- Dumping data for table trialjectory.cancer: ~0 rows (approximately)
DELETE FROM `cancer`;
/*!40000 ALTER TABLE `cancer` DISABLE KEYS */;
INSERT INTO `cancer` (`id`, `name`) VALUES
	(1, 'Melanoma'),
	(2, 'CRC'),
	(3, 'Breast Cancer'),
	(4, 'MDS (Myelodysplastic Syndrome)'),
	(5, 'Bladder');
/*!40000 ALTER TABLE `cancer` ENABLE KEYS */;

-- Dumping data for table trialjectory.desease_stage: ~0 rows (approximately)
DELETE FROM `desease_stage`;
/*!40000 ALTER TABLE `desease_stage` DISABLE KEYS */;
INSERT INTO `desease_stage` (`id`, `name`) VALUES
	(1, '1'),
	(2, '2'),
	(3, '3a'),
	(4, '3b'),
	(5, '3c'),
	(6, '4 (metastatic)');
/*!40000 ALTER TABLE `desease_stage` ENABLE KEYS */;

-- Dumping data for table trialjectory.gender: ~0 rows (approximately)
DELETE FROM `gender`;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` (`id`, `name`) VALUES
	(1, 'male'),
	(2, 'female');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;

-- Dumping data for table trialjectory.model_property_path: ~5 rows (approximately)
DELETE FROM `model_property_path`;
/*!40000 ALTER TABLE `model_property_path` DISABLE KEYS */;
INSERT INTO `model_property_path` (`id`, `name`, `path`, `source_model_id`) VALUES
	(1, 'Patient birthday', 'profile.birthday', NULL),
	(2, 'Patient biomarkers', 'profile.profileBiomarker.biomarkerId', NULL),
	(3, 'Patient treatments', 'profile.profileTreatment.treatmentId', NULL),
	(4, 'Patient desease stage', 'profile.deseaseStageId', NULL),
	(5, 'Patient cancer', 'profile.cancerId', NULL),
	(6, 'Patient gender', 'profile.genderId', NULL);
/*!40000 ALTER TABLE `model_property_path` ENABLE KEYS */;

-- Dumping data for table trialjectory.source_model: ~0 rows (approximately)
DELETE FROM `source_model`;
/*!40000 ALTER TABLE `source_model` DISABLE KEYS */;
INSERT INTO `source_model` (`id`, `name`, `value`) VALUES
	(1, 'Cancer types', 'cancer'),
	(2, 'Desease stage', 'deseaseStage'),
	(3, 'Gender', 'gender'),
	(4, 'Biomarker types', 'biomarker'),
	(5, 'Treatments', 'treatment');
/*!40000 ALTER TABLE `source_model` ENABLE KEYS */;

-- Dumping data for table trialjectory.treatment: ~0 rows (approximately)
DELETE FROM `treatment`;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
INSERT INTO `treatment` (`id`, `name`) VALUES
	(1, 'Chemotherapy'),
	(2, 'Radiation'),
	(3, 'Surgery');
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
