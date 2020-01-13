-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.12 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2020-01-13 23:05:54
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
-- Dumping data for table trialjectory.profile: ~1 rows (approximately)
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` (`id`, `user_id`, `birthdate`, `cancer_id`, `gender_id`, `desease_stage_id`) VALUES
	(2, 1, '1980-01-01', 1, 2, 2);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;

-- Dumping data for table trialjectory.profile_biomarker: ~2 rows (approximately)
/*!40000 ALTER TABLE `profile_biomarker` DISABLE KEYS */;
INSERT INTO `profile_biomarker` (`id`, `profile_id`, `biomarker_id`) VALUES
	(1, 2, 2),
	(2, 2, 3);
/*!40000 ALTER TABLE `profile_biomarker` ENABLE KEYS */;

-- Dumping data for table trialjectory.profile_treatment: ~2 rows (approximately)
/*!40000 ALTER TABLE `profile_treatment` DISABLE KEYS */;
INSERT INTO `profile_treatment` (`id`, `profile_id`, `treatment_id`) VALUES
	(1, 2, 1),
	(2, 2, 2);
/*!40000 ALTER TABLE `profile_treatment` ENABLE KEYS */;

-- Dumping data for table trialjectory.questionare: ~4 rows (approximately)
/*!40000 ALTER TABLE `questionare` DISABLE KEYS */;
INSERT INTO `questionare` (`id`, `order`, `is_mandatory`, `question`, `controll`, `source_model_id`, `model_property_path_id`) VALUES
	(1, 0, 1, 'What kind of cancer do you have?', 'radio', 1, 5),
	(2, 1, 1, 'Date of birth', 'date', NULL, 1),
	(3, 2, 1, 'Gender', 'radio', 3, 6),
	(4, 3, 0, 'What is your current stage?', 'radio', 2, 4);
/*!40000 ALTER TABLE `questionare` ENABLE KEYS */;

-- Dumping data for table trialjectory.questionare_cancer: ~2 rows (approximately)
/*!40000 ALTER TABLE `questionare_cancer` DISABLE KEYS */;
INSERT INTO `questionare_cancer` (`id`, `questionare_id`, `cancer_id`) VALUES
	(1, 4, 1),
	(2, 4, 2);
/*!40000 ALTER TABLE `questionare_cancer` ENABLE KEYS */;

-- Dumping data for table trialjectory.trial: ~2 rows (approximately)
/*!40000 ALTER TABLE `trial` DISABLE KEYS */;
INSERT INTO `trial` (`id`, `name`) VALUES
	(1, 'Trial A'),
	(2, 'Trial B');
/*!40000 ALTER TABLE `trial` ENABLE KEYS */;

-- Dumping data for table trialjectory.trial_requirement: ~7 rows (approximately)
/*!40000 ALTER TABLE `trial_requirement` DISABLE KEYS */;
INSERT INTO `trial_requirement` (`id`, `name`, `trial_id`, `model_property_path_id`, `operation`) VALUES
	(1, 'a patient is male', 1, 6, 'eq'),
	(2, 'in stage 2 of the disease', 1, 4, 'eq'),
	(3, 'has not biomarker "1"', 1, 2, 'notContainsAny'),
	(4, 'did not get a chemo treatment', 1, 3, 'notContainsAny'),
	(5, 'a patient is in stage less than 4', 2, 4, 'notContainsAny'),
	(6, 'has biomarker "2"', 2, 2, 'containsAny'),
	(7, ' less than 50 years old', 2, 1, 'ageLess');
/*!40000 ALTER TABLE `trial_requirement` ENABLE KEYS */;

-- Dumping data for table trialjectory.trial_requirement_value: ~7 rows (approximately)
/*!40000 ALTER TABLE `trial_requirement_value` DISABLE KEYS */;
INSERT INTO `trial_requirement_value` (`id`, `trial_requirement_id`, `value`) VALUES
	(1, 1, '1'),
	(2, 2, '2'),
	(3, 3, '1'),
	(4, 4, '1'),
	(5, 5, '6'),
	(6, 6, '2'),
	(7, 7, '50');
/*!40000 ALTER TABLE `trial_requirement_value` ENABLE KEYS */;

-- Dumping data for table trialjectory.user: ~1 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `name`, `password`) VALUES
	(1, 'John', '1');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
