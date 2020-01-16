-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.12 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2020-01-16 12:18:08
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table trialjectory.biomarker
DROP TABLE IF EXISTS `biomarker`;
CREATE TABLE IF NOT EXISTS `biomarker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.cancer
DROP TABLE IF EXISTS `cancer`;
CREATE TABLE IF NOT EXISTS `cancer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.desease_stage
DROP TABLE IF EXISTS `desease_stage`;
CREATE TABLE IF NOT EXISTS `desease_stage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.gender
DROP TABLE IF EXISTS `gender`;
CREATE TABLE IF NOT EXISTS `gender` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.model_property_path
DROP TABLE IF EXISTS `model_property_path`;
CREATE TABLE IF NOT EXISTS `model_property_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL COMMENT 'Description of path',
  `path` varchar(1000) NOT NULL COMMENT 'Path to models field , can has two models in case hasMany relation (profile.profileBiomarker.biomarkerId)',
  `source_model_id` int(11) DEFAULT NULL COMMENT 'Describe lookup values for property',
  PRIMARY KEY (`id`),
  KEY `fk_model_property_path_r_source_model` (`source_model_id`),
  CONSTRAINT `fk_model_property_path_r_source_model` FOREIGN KEY (`source_model_id`) REFERENCES `source_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.profile
DROP TABLE IF EXISTS `profile`;
CREATE TABLE IF NOT EXISTS `profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT '0' COMMENT 'Has unique key so only one profile per user',
  `birthdate` date DEFAULT NULL,
  `cancer_id` int(11) DEFAULT NULL,
  `gender_id` int(11) DEFAULT NULL,
  `desease_stage_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `fk_profile_r_desease_stage` (`desease_stage_id`),
  KEY `fk_profile_r_gender` (`gender_id`),
  KEY `fk_profile_r_cancer` (`cancer_id`),
  CONSTRAINT `fk_profile_r_cancer` FOREIGN KEY (`cancer_id`) REFERENCES `cancer` (`id`),
  CONSTRAINT `fk_profile_r_desease_stage` FOREIGN KEY (`desease_stage_id`) REFERENCES `desease_stage` (`id`),
  CONSTRAINT `fk_profile_r_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`),
  CONSTRAINT `fk_profile_r_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.profile_biomarker
DROP TABLE IF EXISTS `profile_biomarker`;
CREATE TABLE IF NOT EXISTS `profile_biomarker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `biomarker_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_profile_user` (`profile_id`,`biomarker_id`),
  KEY `fk_profile_biomarker_r_biomarker` (`biomarker_id`),
  CONSTRAINT `fk_profile_biomarker_r_biomarker` FOREIGN KEY (`biomarker_id`) REFERENCES `biomarker` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_profile_biomarker_r_profile` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.profile_treatment
DROP TABLE IF EXISTS `profile_treatment`;
CREATE TABLE IF NOT EXISTS `profile_treatment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_profile_user` (`profile_id`,`treatment_id`),
  KEY `fk_profile_treatment_r_treatment` (`treatment_id`),
  CONSTRAINT `fk_profile_treatment_r_profile` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_profile_treatment_r_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.questionare
DROP TABLE IF EXISTS `questionare`;
CREATE TABLE IF NOT EXISTS `questionare` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL,
  `is_mandatory` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'for value "1" no need to check cancer of patient',
  `question` varchar(1000) NOT NULL,
  `controll` enum('date','text','radio','checkbox') NOT NULL COMMENT 'Name of component on frontend side',
  `model_property_path_id` int(11) NOT NULL COMMENT 'Model.Model.Field notation. For example  profile.profile_biomarker.biomarker_id',
  PRIMARY KEY (`id`),
  KEY `fk_questionare_r_save_path` (`model_property_path_id`),
  CONSTRAINT `fk_questionare_r_save_path` FOREIGN KEY (`model_property_path_id`) REFERENCES `model_property_path` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.questionare_cancer
DROP TABLE IF EXISTS `questionare_cancer`;
CREATE TABLE IF NOT EXISTS `questionare_cancer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionare_id` int(11) NOT NULL,
  `cancer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_questionare_id_cancer_id` (`questionare_id`,`cancer_id`),
  KEY `fk_questionare_cancer_r_cancer` (`cancer_id`),
  CONSTRAINT `fk_questionare_cancer_r_cancer` FOREIGN KEY (`cancer_id`) REFERENCES `cancer` (`id`),
  CONSTRAINT `fk_questionare_cancer_r_questionare` FOREIGN KEY (`questionare_id`) REFERENCES `questionare` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Describe for which cancers available this question';

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.source_model
DROP TABLE IF EXISTS `source_model`;
CREATE TABLE IF NOT EXISTS `source_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `value` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.treatment
DROP TABLE IF EXISTS `treatment`;
CREATE TABLE IF NOT EXISTS `treatment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.trial
DROP TABLE IF EXISTS `trial`;
CREATE TABLE IF NOT EXISTS `trial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.trial_allow_biomarker
DROP TABLE IF EXISTS `trial_allow_biomarker`;
CREATE TABLE IF NOT EXISTS `trial_allow_biomarker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trial_id` int(11) NOT NULL,
  `biomarker_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trial_allow_desease_stage_r_trial` (`trial_id`),
  KEY `fk_trial_allow_desease_stage_r_biomarker` (`biomarker_id`),
  CONSTRAINT `fk_trial_allow_desease_biomarker_r_biomarker` FOREIGN KEY (`biomarker_id`) REFERENCES `biomarker` (`id`),
  CONSTRAINT `fk_trial_allow_desease_biomarker_r_trial` FOREIGN KEY (`trial_id`) REFERENCES `trial` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.trial_allow_desease_stage
DROP TABLE IF EXISTS `trial_allow_desease_stage`;
CREATE TABLE IF NOT EXISTS `trial_allow_desease_stage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trial_id` int(11) NOT NULL,
  `desease_stage_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trial_allow_desease_stage_r_trial` (`trial_id`),
  KEY `fk_trial_allow_desease_stage_r_desease_stage` (`desease_stage_id`),
  CONSTRAINT `fk_trial_allow_desease_stage_r_stage` FOREIGN KEY (`desease_stage_id`) REFERENCES `desease_stage` (`id`),
  CONSTRAINT `fk_trial_allow_desease_stage_r_trial` FOREIGN KEY (`trial_id`) REFERENCES `trial` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.trial_requirement
DROP TABLE IF EXISTS `trial_requirement`;
CREATE TABLE IF NOT EXISTS `trial_requirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `trial_id` int(11) NOT NULL,
  `model_property_path_id` int(11) NOT NULL,
  `operation` enum('eq','containsAll','containsAny','notContainsAny','ageLess','ageGreater') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trial_requirement_r_trial` (`trial_id`),
  KEY `fk_trial_requirement_r_model_property_path` (`model_property_path_id`),
  CONSTRAINT `fk_trial_requirement_r_model_property_path` FOREIGN KEY (`model_property_path_id`) REFERENCES `model_property_path` (`id`),
  CONSTRAINT `fk_trial_requirement_r_trial` FOREIGN KEY (`trial_id`) REFERENCES `trial` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.trial_requirement_value
DROP TABLE IF EXISTS `trial_requirement_value`;
CREATE TABLE IF NOT EXISTS `trial_requirement_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trial_requirement_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trial_requirement_value_r_trial_requirement` (`trial_requirement_id`),
  CONSTRAINT `fk_trial_requirement_value_r_trial_requirement` FOREIGN KEY (`trial_requirement_id`) REFERENCES `trial_requirement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table trialjectory.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
