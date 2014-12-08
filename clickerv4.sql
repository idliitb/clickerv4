CREATE DATABASE  IF NOT EXISTS `aakashclicker` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `aakashclicker`;
-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: aakashclicker
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autotestresponse`
--

DROP TABLE IF EXISTS `autotestresponse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autotestresponse` (
  `ParticipantID` varchar(25) NOT NULL,
  `IQuestionID` int(5) NOT NULL,
  `Response` char(8) DEFAULT NULL,
  `QTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IQuizID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autotestresponse`
--

LOCK TABLES `autotestresponse` WRITE;
/*!40000 ALTER TABLE `autotestresponse` DISABLE KEYS */;
/*!40000 ALTER TABLE `autotestresponse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instantquizresponsenew`
--

DROP TABLE IF EXISTS `instantquizresponsenew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instantquizresponsenew` (
  `StudentID` varchar(25) NOT NULL,
  `IQuestionID` int(5) NOT NULL,
  `Response` char(8) NOT NULL,
  `QTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IQuizID` int(5) NOT NULL,
  PRIMARY KEY (`IQuizID`,`StudentID`,`IQuestionID`,`Response`),
  KEY `fk_instantquizresponsenew_1` (`StudentID`),
  KEY `fk_instantquizresponsenew_2` (`IQuizID`),
  KEY `fk_instantquizresponsenew_3` (`IQuestionID`),
  CONSTRAINT `fk_instantquizresponsenew_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `fk_instantquizresponsenew_2` FOREIGN KEY (`IQuizID`) REFERENCES `instantquiznew` (`IQuizID`),
  CONSTRAINT `fk_instantquizresponsenew_3` FOREIGN KEY (`IQuestionID`) REFERENCES `instantquestion` (`IQuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instantquizresponsenew`
--

LOCK TABLES `instantquizresponsenew` WRITE;
/*!40000 ALTER TABLE `instantquizresponsenew` DISABLE KEYS */;
/*!40000 ALTER TABLE `instantquizresponsenew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionshistory`
--

DROP TABLE IF EXISTS `questionshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionshistory` (
  `QuestionID` int(11) NOT NULL,
  `Question` blob NOT NULL,
  `SerialNo` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime NOT NULL,
  `Instructor` varchar(500) NOT NULL,
  `OptionValue` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`SerialNo`),
  KEY `fk_questionshistory_1` (`QuestionID`),
  CONSTRAINT `fk_questionshistory_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionshistory`
--

LOCK TABLES `questionshistory` WRITE;
/*!40000 ALTER TABLE `questionshistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution`
--

DROP TABLE IF EXISTS `institution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `institution` (
  `InstiID` varchar(20) NOT NULL,
  `InstiName` varchar(100) NOT NULL,
  `Address` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`InstiID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution`
--

LOCK TABLES `institution` WRITE;
/*!40000 ALTER TABLE `institution` DISABLE KEYS */;
INSERT INTO `institution` VALUES ('xyz01','IIT Bombay','Mumbai');
/*!40000 ALTER TABLE `institution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizrecord`
--

DROP TABLE IF EXISTS `quizrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizrecord` (
  `QuizRecordID` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `QuizID` int(4) unsigned NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Note` varchar(500) NOT NULL DEFAULT 'notsend',
  `NegativeMarking` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`QuizRecordID`),
  KEY `QuizID` (`QuizID`),
  CONSTRAINT `FK_quizrecord_1` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`QuizID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizrecord`
--

LOCK TABLES `quizrecord` WRITE;
/*!40000 ALTER TABLE `quizrecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `CourseID` varchar(20) NOT NULL,
  `CourseName` varchar(100) DEFAULT NULL,
  `CourseDesc` varchar(100) DEFAULT NULL,
  `DeptID` varchar(20) DEFAULT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('temp','temporary course','temporary course','temp001',0);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instantquestion`
--

DROP TABLE IF EXISTS `instantquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instantquestion` (
  `IQuestionID` int(5) NOT NULL AUTO_INCREMENT,
  `IQuestionType` int(2) NOT NULL,
  `NoofOptions` int(2) NOT NULL,
  `CorrectAns` char(6) NOT NULL,
  `IQuizID` int(5) NOT NULL,
  PRIMARY KEY (`IQuestionID`),
  KEY `fk_instantquestion_1` (`IQuizID`),
  CONSTRAINT `fk_instantquestion_1` FOREIGN KEY (`IQuizID`) REFERENCES `instantquiznew` (`IQuizID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Instant question with different questin type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instantquestion`
--

LOCK TABLES `instantquestion` WRITE;
/*!40000 ALTER TABLE `instantquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `instantquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `StudentID` varchar(20) NOT NULL,
  `StudentRollNo` varchar(20) DEFAULT NULL,
  `StudentName` varchar(50) DEFAULT NULL,
  `YearofJoining` int(4) DEFAULT NULL,
  `Privileges` int(4) DEFAULT NULL,
  `DeptID` varchar(20) DEFAULT NULL,
  `Password` varchar(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `EmailID` varchar(200) DEFAULT NULL,
  `MacAddress` varchar(25) NOT NULL,
  PRIMARY KEY (`StudentID`),
  KEY `FK_student_1` (`DeptID`),
  CONSTRAINT `FK_student_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor` (
  `InstrID` varchar(20) NOT NULL,
  `InstrName` varchar(36) NOT NULL,
  `DOJ` date DEFAULT NULL,
  `DeptID` varchar(20) DEFAULT NULL,
  `Password` char(32) NOT NULL,
  `Designation` varchar(30) DEFAULT NULL,
  `EmailID` varchar(40) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `AdminPriviledges` tinyint(1) NOT NULL,
  PRIMARY KEY (`InstrID`),
  KEY `DeptID` (`DeptID`),
  CONSTRAINT `FK_instructor_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES ('admin','admin','2001-09-12','temp001','admin','admin','clicker@cse.iitb.ac.in','02225764932',4);
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll`
--

DROP TABLE IF EXISTS `poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll` (
  `StudentID` varchar(20) NOT NULL,
  `Response` tinyint(4) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PollID` int(11) NOT NULL,
  PRIMARY KEY (`StudentID`,`Response`,`PollID`),
  KEY `fk_poll_1` (`StudentID`),
  KEY `fk_poll_2` (`PollID`),
  CONSTRAINT `fk_poll_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `fk_poll_2` FOREIGN KEY (`PollID`) REFERENCES `pollquestion` (`PollID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll`
--

LOCK TABLES `poll` WRITE;
/*!40000 ALTER TABLE `poll` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailsetup`
--

DROP TABLE IF EXISTS `emailsetup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailsetup` (
  `EmailAddress` varchar(100) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`EmailAddress`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailsetup`
--

LOCK TABLES `emailsetup` WRITE;
/*!40000 ALTER TABLE `emailsetup` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailsetup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizquestion`
--

DROP TABLE IF EXISTS `quizquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizquestion` (
  `QuizID` int(4) unsigned NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `questionCredit` float DEFAULT NULL,
  KEY `QuizID` (`QuizID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `FK_quizquestion_1` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`QuizID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quizquestion_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizquestion`
--

LOCK TABLES `quizquestion` WRITE;
/*!40000 ALTER TABLE `quizquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raisehand`
--

DROP TABLE IF EXISTS `raisehand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raisehand` (
  `CourseID` varchar(20) NOT NULL,
  `StudentID` varchar(20) NOT NULL,
  `RaiseTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Comments` varchar(1000) NOT NULL,
  `RepliedDoubt` int(11) NOT NULL DEFAULT '0',
  `RepliedAnswer` text NOT NULL,
  KEY `new_fk1_constraint` (`CourseID`),
  KEY `new_fk3_constraint` (`StudentID`),
  CONSTRAINT `new_fk1_constraint` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`),
  CONSTRAINT `new_fk3_constraint` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raisehand`
--

LOCK TABLES `raisehand` WRITE;
/*!40000 ALTER TABLE `raisehand` DISABLE KEYS */;
/*!40000 ALTER TABLE `raisehand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `StudentID` varchar(20) NOT NULL,
  `CourseID` varchar(20) NOT NULL,
  `AttendanceTS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Attendance_Count` int(3) NOT NULL DEFAULT '0',
  `Session` varchar(15) NOT NULL,
  KEY `new_fk_constraint` (`StudentID`),
  CONSTRAINT `new_fk_constraint` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `QuestionID` int(11) NOT NULL AUTO_INCREMENT,
  `Question` blob NOT NULL,
  `LevelofDifficulty` int(11) DEFAULT NULL,
  `Archived` tinyint(1) DEFAULT NULL,
  `Credit` float DEFAULT NULL,
  `Duration` int(11) DEFAULT NULL,
  `ImageName` varchar(20) DEFAULT NULL,
  `QuestionType` tinyint(4) DEFAULT NULL,
  `AnswerOrder` varchar(6) DEFAULT NULL,
  `InstrID` varchar(20) NOT NULL,
  `Shuffle` tinyint(4) NOT NULL DEFAULT '1',
  `CourseID` varchar(20) NOT NULL,
  `NegativeMark` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`QuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (0,'null',0,0,0,0,'null',0,'0','0',0,'0',0);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentcourse`
--

DROP TABLE IF EXISTS `studentcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentcourse` (
  `Year` int(4) NOT NULL,
  `Semester` varchar(10) NOT NULL,
  `CourseID` varchar(20) NOT NULL,
  `StudentID` varchar(20) NOT NULL,
  PRIMARY KEY (`CourseID`,`StudentID`),
  KEY `CourseID` (`CourseID`),
  KEY `StudentID` (`StudentID`),
  CONSTRAINT `FK_studentcourse_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`),
  CONSTRAINT `FK_studentcourse_2` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentcourse`
--

LOCK TABLES `studentcourse` WRITE;
/*!40000 ALTER TABLE `studentcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz` (
  `QuizID` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `Version` float NOT NULL,
  `Duration` int(11) NOT NULL,
  `QuizName` varchar(20) NOT NULL,
  `CourseID` varchar(20) NOT NULL,
  `QuizType` int(11) NOT NULL,
  `Archived` tinyint(4) DEFAULT '0',
  `InstrID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`QuizID`),
  KEY `CourseID` (`CourseID`),
  CONSTRAINT `FK_quiz_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructorcourse`
--

DROP TABLE IF EXISTS `instructorcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructorcourse` (
  `Year` int(4) NOT NULL,
  `Semester` int(2) DEFAULT NULL,
  `CourseID` varchar(20) NOT NULL,
  `InstrID` varchar(20) NOT NULL,
  KEY `CourseID` (`CourseID`),
  KEY `InstrID` (`InstrID`),
  CONSTRAINT `FK_instructorcourse_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_instructorcourse_2` FOREIGN KEY (`InstrID`) REFERENCES `instructor` (`InstrID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructorcourse`
--

LOCK TABLES `instructorcourse` WRITE;
/*!40000 ALTER TABLE `instructorcourse` DISABLE KEYS */;
INSERT INTO `instructorcourse` VALUES (2014,0,'temp','admin');
/*!40000 ALTER TABLE `instructorcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pollquestion`
--

DROP TABLE IF EXISTS `pollquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pollquestion` (
  `PollID` int(11) NOT NULL AUTO_INCREMENT,
  `Question` varchar(500) NOT NULL,
  `CourseId` varchar(20) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PollID`),
  KEY `fk_pollquestion_1` (`CourseId`),
  CONSTRAINT `fk_pollquestion_1` FOREIGN KEY (`CourseId`) REFERENCES `course` (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pollquestion`
--

LOCK TABLES `pollquestion` WRITE;
/*!40000 ALTER TABLE `pollquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `pollquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizrecordquestion`
--

DROP TABLE IF EXISTS `quizrecordquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizrecordquestion` (
  `QuizRecordID` int(4) unsigned NOT NULL DEFAULT '0',
  `QuestionID` int(11) NOT NULL,
  `OptionID` int(11) NOT NULL,
  `StudentID` varchar(20) NOT NULL,
  `Response` varchar(6) NOT NULL,
  `QRIndex` int(2) DEFAULT NULL,
  `QRTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InvalidQuiz` tinyint(1) DEFAULT NULL,
  `TimeTaken` int(11) DEFAULT NULL,
  `ResponseIndex` tinyint(4) NOT NULL,
  `ResponseIndexCorrect` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`QuizRecordID`,`QuestionID`,`OptionID`,`StudentID`,`ResponseIndex`) USING BTREE,
  KEY `QuestionID` (`QuestionID`),
  KEY `StudentID` (`StudentID`),
  KEY `OptionID` (`OptionID`),
  KEY `ResponseIndex` (`ResponseIndex`),
  KEY `fk_quizrecordquestion_1` (`StudentID`),
  KEY `fk_quizrecordquestion_2` (`QuizRecordID`),
  KEY `fk_quizrecordquestion_3` (`OptionID`),
  KEY `fk_quizrecordquestion_4` (`QuestionID`),
  CONSTRAINT `fk_quizrecordquestion_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `fk_quizrecordquestion_2` FOREIGN KEY (`QuizRecordID`) REFERENCES `quizrecord` (`QuizRecordID`),
  CONSTRAINT `fk_quizrecordquestion_3` FOREIGN KEY (`OptionID`) REFERENCES `options` (`OptionID`),
  CONSTRAINT `fk_quizrecordquestion_4` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizrecordquestion`
--

LOCK TABLES `quizrecordquestion` WRITE;
/*!40000 ALTER TABLE `quizrecordquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizrecordquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `DeptID` varchar(20) NOT NULL,
  `DeptName` varchar(100) NOT NULL,
  `HOD` varchar(20) DEFAULT NULL,
  `InstiID` varchar(20) NOT NULL,
  PRIMARY KEY (`DeptID`),
  KEY `InstiID` (`InstiID`),
  KEY `HOD` (`HOD`),
  CONSTRAINT `FK_department_1` FOREIGN KEY (`InstiID`) REFERENCES `institution` (`InstiID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('temp001','temporary Dept','Clicker Team','xyz01');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instantquiznew`
--

DROP TABLE IF EXISTS `instantquiznew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instantquiznew` (
  `IQuizID` int(5) NOT NULL AUTO_INCREMENT,
  `DurationSec` int(5) NOT NULL,
  `QuizDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CourseID` varchar(20) NOT NULL,
  `InstrID` varchar(20) NOT NULL,
  `IsSent` varchar(15) NOT NULL DEFAULT 'notsend',
  PRIMARY KEY (`IQuizID`),
  KEY `fk_instantquiznew_1` (`InstrID`),
  KEY `fk_instantquiznew_2` (`CourseID`),
  CONSTRAINT `fk_instantquiznew_2` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`),
  CONSTRAINT `fk_instantquiznew_1` FOREIGN KEY (`InstrID`) REFERENCES `instructor` (`InstrID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Instant quiz with more question and different question type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instantquiznew`
--

LOCK TABLES `instantquiznew` WRITE;
/*!40000 ALTER TABLE `instantquiznew` DISABLE KEYS */;
/*!40000 ALTER TABLE `instantquiznew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizquestionoption`
--

DROP TABLE IF EXISTS `quizquestionoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizquestionoption` (
  `QuizID` int(4) unsigned NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `OptionID` int(11) NOT NULL,
  KEY `QuizID` (`QuizID`),
  KEY `QuestionID` (`QuestionID`),
  KEY `OptionID` (`OptionID`),
  CONSTRAINT `FK_quizquestionoption_1` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`QuizID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quizquestionoption_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quizquestionoption_ibfk_2` FOREIGN KEY (`OptionID`) REFERENCES `options` (`OptionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizquestionoption`
--

LOCK TABLES `quizquestionoption` WRITE;
/*!40000 ALTER TABLE `quizquestionoption` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizquestionoption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `OptionID` int(11) NOT NULL AUTO_INCREMENT,
  `OptionValue` varchar(500) DEFAULT NULL,
  `OptionDesc` varchar(500) DEFAULT NULL,
  `OptionCorrectness` tinyint(1) NOT NULL,
  `LevelofDifficulty` int(11) DEFAULT NULL,
  `Archived` tinyint(1) DEFAULT NULL,
  `Credit` float DEFAULT NULL,
  `QuestionID` int(11) NOT NULL,
  PRIMARY KEY (`OptionID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `options_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (0,'Z','No Response',0,0,0,0,0);
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-01 13:09:38
CREATE DATABASE  IF NOT EXISTS `remoteaakashclicker` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `remoteaakashclicker`;
-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: remoteaakashclicker
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autotestresponse`
--

DROP TABLE IF EXISTS `autotestresponse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autotestresponse` (
  `ParticipantID` varchar(25) NOT NULL,
  `IQuestionID` int(5) NOT NULL,
  `Response` char(8) NOT NULL,
  `QTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IQuizID` int(5) NOT NULL,
  KEY `fk_autotestresponse_1` (`ParticipantID`),
  CONSTRAINT `fk_autotestresponse_1` FOREIGN KEY (`ParticipantID`) REFERENCES `participant` (`ParticipantID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autotestresponse`
--

LOCK TABLES `autotestresponse` WRITE;
/*!40000 ALTER TABLE `autotestresponse` DISABLE KEYS */;
/*!40000 ALTER TABLE `autotestresponse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instantquizresponsenew`
--

DROP TABLE IF EXISTS `instantquizresponsenew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instantquizresponsenew` (
  `ParticipantID` varchar(25) NOT NULL,
  `IQuestionID` int(5) NOT NULL,
  `Response` char(8) NOT NULL,
  `QTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IQuizID` int(5) NOT NULL,
  `ResponseSend` int(11) NOT NULL,
  PRIMARY KEY (`ParticipantID`,`IQuestionID`,`Response`,`IQuizID`),
  KEY `fk_instantquizresponsenew_1` (`ParticipantID`),
  KEY `fk_instantquizresponsenew_2` (`IQuestionID`),
  KEY `fk_instantquizresponsenew_3` (`IQuizID`),
  CONSTRAINT `fk_instantquizresponsenew_2` FOREIGN KEY (`IQuestionID`) REFERENCES `instantquestion` (`IQuestionID`),
  CONSTRAINT `fk_instantquizresponsenew_3` FOREIGN KEY (`IQuizID`) REFERENCES `instantquiznew` (`IQuizID`),
  CONSTRAINT `fk_instantquizresponsenew_1` FOREIGN KEY (`ParticipantID`) REFERENCES `participant` (`ParticipantID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instantquizresponsenew`
--

LOCK TABLES `instantquizresponsenew` WRITE;
/*!40000 ALTER TABLE `instantquizresponsenew` DISABLE KEYS */;
/*!40000 ALTER TABLE `instantquizresponsenew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remotecenter`
--

DROP TABLE IF EXISTS `remotecenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remotecenter` (
  `CenterID` int(11) NOT NULL,
  `CenterName` varchar(100) NOT NULL,
  `State` varchar(30) NOT NULL,
  `City` varchar(30) NOT NULL,
  PRIMARY KEY (`CenterID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remotecenter`
--

LOCK TABLES `remotecenter` WRITE;
/*!40000 ALTER TABLE `remotecenter` DISABLE KEYS */;
/*!40000 ALTER TABLE `remotecenter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizrecord`
--

DROP TABLE IF EXISTS `quizrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizrecord` (
  `QuizRecordID` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `QuizID` int(4) unsigned NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `WorkshopID` varchar(20) NOT NULL DEFAULT '',
  `NegativeMarking` int(3) NOT NULL DEFAULT '0',
  `MCQuizRecordID` int(5) unsigned NOT NULL,
  PRIMARY KEY (`QuizRecordID`) USING BTREE,
  KEY `QuizID` (`QuizID`),
  CONSTRAINT `FK_quizrecord_1` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`QuizID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizrecord`
--

LOCK TABLES `quizrecord` WRITE;
/*!40000 ALTER TABLE `quizrecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinator`
--

DROP TABLE IF EXISTS `coordinator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coordinator` (
  `CoordID` int(11) NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `CenterID` int(11) NOT NULL,
  `email` text NOT NULL,
  `AdminPriviledges` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`CoordID`),
  KEY `CenterID` (`CenterID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinator`
--

LOCK TABLES `coordinator` WRITE;
/*!40000 ALTER TABLE `coordinator` DISABLE KEYS */;
INSERT INTO `coordinator` VALUES (1,'admin','admin',0,'clicker@cse.iitb.ac.in',2);
/*!40000 ALTER TABLE `coordinator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instantquestion`
--

DROP TABLE IF EXISTS `instantquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instantquestion` (
  `IQuestionID` int(5) NOT NULL AUTO_INCREMENT,
  `IQuestionType` int(2) NOT NULL,
  `NoofOptions` int(2) NOT NULL,
  `CorrectAns` char(6) NOT NULL,
  `IQuizID` int(5) NOT NULL,
  PRIMARY KEY (`IQuestionID`) USING BTREE,
  KEY `fk_instantquestion_1` (`IQuizID`),
  CONSTRAINT `fk_instantquestion_1` FOREIGN KEY (`IQuizID`) REFERENCES `instantquiznew` (`IQuizID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Instant question with different questin type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instantquestion`
--

LOCK TABLES `instantquestion` WRITE;
/*!40000 ALTER TABLE `instantquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `instantquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll`
--

DROP TABLE IF EXISTS `poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll` (
  `ParticipantID` varchar(20) NOT NULL,
  `Response` tinyint(4) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PollID` int(11) NOT NULL,
  PRIMARY KEY (`ParticipantID`,`Response`,`PollID`),
  KEY `fk_poll_1` (`PollID`),
  KEY `fk_poll_2` (`ParticipantID`),
  CONSTRAINT `fk_poll_2` FOREIGN KEY (`ParticipantID`) REFERENCES `participant` (`ParticipantID`),
  CONSTRAINT `fk_poll_1` FOREIGN KEY (`PollID`) REFERENCES `pollquestion` (`PollID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll`
--

LOCK TABLES `poll` WRITE;
/*!40000 ALTER TABLE `poll` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailsetup`
--

DROP TABLE IF EXISTS `emailsetup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailsetup` (
  `EmailAddress` varchar(100) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`EmailAddress`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailsetup`
--

LOCK TABLES `emailsetup` WRITE;
/*!40000 ALTER TABLE `emailsetup` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailsetup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizquestion`
--

DROP TABLE IF EXISTS `quizquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizquestion` (
  `QuizID` int(4) unsigned NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `questionCredit` float DEFAULT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  `QQOrderID` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`QuizID`,`QuestionID`,`WorkshopID`,`QQOrderID`) USING BTREE,
  KEY `QuizID` (`QuizID`),
  KEY `QuestionID` (`QuestionID`),
  KEY `QQOrderID` (`QQOrderID`),
  CONSTRAINT `FK_quizquestion_1` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`QuizID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quizquestion_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizquestion`
--

LOCK TABLES `quizquestion` WRITE;
/*!40000 ALTER TABLE `quizquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `ParticipantID` varchar(20) NOT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  `AttendanceTS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Attendance_Count` int(3) NOT NULL DEFAULT '0',
  `Session` varchar(15) NOT NULL,
  PRIMARY KEY (`ParticipantID`,`AttendanceTS`,`Session`,`WorkshopID`),
  KEY `new_fk_constraint` (`ParticipantID`),
  KEY `fk_attendance_1` (`ParticipantID`),
  CONSTRAINT `fk_attendance_1` FOREIGN KEY (`ParticipantID`) REFERENCES `participant` (`ParticipantID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participant`
--

DROP TABLE IF EXISTS `participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participant` (
  `ParticipantID` varchar(25) NOT NULL,
  `MacAddress` varchar(25) NOT NULL,
  `ParticipantName` varchar(150) NOT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  `Password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ParticipantID`,`WorkshopID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participant`
--

LOCK TABLES `participant` WRITE;
/*!40000 ALTER TABLE `participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `QuestionID` int(11) NOT NULL,
  `Question` blob NOT NULL,
  `LevelofDifficulty` int(11) DEFAULT NULL,
  `Archived` tinyint(1) DEFAULT NULL,
  `Credit` float DEFAULT NULL,
  `Duration` int(11) DEFAULT NULL,
  `ImageName` varchar(20) DEFAULT NULL,
  `QuestionType` tinyint(4) DEFAULT NULL,
  `AnswerOrder` varchar(6) DEFAULT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  `NegativeMark` float NOT NULL DEFAULT '0',
  `Shuffle` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`QuestionID`,`WorkshopID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (0,'',0,0,0,0,'0',0,'0','0',0,1);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz` (
  `QuizID` int(4) unsigned NOT NULL,
  `Duration` int(11) NOT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  `QuizName` varchar(100) NOT NULL,
  PRIMARY KEY (`QuizID`,`WorkshopID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pollquestion`
--

DROP TABLE IF EXISTS `pollquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pollquestion` (
  `PollID` int(11) NOT NULL AUTO_INCREMENT,
  `Question` varchar(500) NOT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PollID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pollquestion`
--

LOCK TABLES `pollquestion` WRITE;
/*!40000 ALTER TABLE `pollquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `pollquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizrecordquestion`
--

DROP TABLE IF EXISTS `quizrecordquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizrecordquestion` (
  `QuizRecordID` int(4) unsigned NOT NULL DEFAULT '0',
  `QuestionID` int(11) NOT NULL,
  `OptionID` int(11) NOT NULL,
  `ParticipantID` varchar(20) NOT NULL,
  `Response` varchar(6) NOT NULL,
  `QRIndex` int(2) DEFAULT NULL,
  `QRTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InvalidQuiz` tinyint(1) DEFAULT NULL,
  `TimeTaken` int(11) DEFAULT NULL,
  `ResponseIndex` tinyint(4) NOT NULL,
  `ResponseIndexCorrect` tinyint(4) DEFAULT NULL,
  `QRQID` int(11) NOT NULL AUTO_INCREMENT,
  `ResponseSend` int(11) NOT NULL,
  PRIMARY KEY (`QuizRecordID`,`QuestionID`,`OptionID`,`ParticipantID`,`ResponseIndex`,`QRQID`) USING BTREE,
  KEY `QuestionID` (`QuestionID`),
  KEY `OptionID` (`OptionID`),
  KEY `ResponseIndex` (`ResponseIndex`),
  KEY `QRQID` (`QRQID`),
  KEY `fk_quizrecordquestion_1` (`ParticipantID`),
  KEY `fk_quizrecordquestion_2` (`QuizRecordID`),
  KEY `fk_quizrecordquestion_3` (`QuestionID`),
  KEY `fk_quizrecordquestion_4` (`OptionID`),
  CONSTRAINT `fk_quizrecordquestion_1` FOREIGN KEY (`ParticipantID`) REFERENCES `participant` (`ParticipantID`),
  CONSTRAINT `fk_quizrecordquestion_2` FOREIGN KEY (`QuizRecordID`) REFERENCES `quizrecord` (`QuizRecordID`),
  CONSTRAINT `fk_quizrecordquestion_3` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`),
  CONSTRAINT `fk_quizrecordquestion_4` FOREIGN KEY (`OptionID`) REFERENCES `options` (`OptionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizrecordquestion`
--

LOCK TABLES `quizrecordquestion` WRITE;
/*!40000 ALTER TABLE `quizrecordquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizrecordquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instantquiznew`
--

DROP TABLE IF EXISTS `instantquiznew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instantquiznew` (
  `IQuizID` int(5) NOT NULL AUTO_INCREMENT,
  `DurationSec` int(5) NOT NULL,
  `QuizDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `WorkshopID` varchar(20) NOT NULL,
  `InstrID` varchar(20) NOT NULL,
  `MCQuizID` int(5) NOT NULL,
  PRIMARY KEY (`IQuizID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Instant quiz with more question and different question type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instantquiznew`
--

LOCK TABLES `instantquiznew` WRITE;
/*!40000 ALTER TABLE `instantquiznew` DISABLE KEYS */;
/*!40000 ALTER TABLE `instantquiznew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizquestionoption`
--

DROP TABLE IF EXISTS `quizquestionoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizquestionoption` (
  `QuizID` int(4) unsigned NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `OptionID` int(11) NOT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  PRIMARY KEY (`QuizID`,`QuestionID`,`OptionID`,`WorkshopID`),
  KEY `QuizID` (`QuizID`),
  KEY `QuestionID` (`QuestionID`),
  KEY `OptionID` (`OptionID`),
  CONSTRAINT `FK_quizquestionoption_1` FOREIGN KEY (`QuizID`) REFERENCES `quiz` (`QuizID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quizquestionoption_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quizquestionoption_ibfk_2` FOREIGN KEY (`OptionID`) REFERENCES `options` (`OptionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizquestionoption`
--

LOCK TABLES `quizquestionoption` WRITE;
/*!40000 ALTER TABLE `quizquestionoption` DISABLE KEYS */;
/*!40000 ALTER TABLE `quizquestionoption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `OptionID` int(11) NOT NULL,
  `OptionValue` varchar(500) DEFAULT NULL,
  `OptionDesc` varchar(500) DEFAULT NULL,
  `OptionCorrectness` tinyint(1) NOT NULL,
  `LevelofDifficulty` int(11) DEFAULT NULL,
  `Archived` tinyint(1) DEFAULT NULL,
  `Credit` float DEFAULT NULL,
  `QuestionID` int(11) NOT NULL,
  `WorkshopID` varchar(20) NOT NULL,
  PRIMARY KEY (`OptionID`,`QuestionID`,`WorkshopID`) USING BTREE,
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `options_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (0,'Z','No Response',0,0,0,0,0,'0');
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maincenter`
--

DROP TABLE IF EXISTS `maincenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maincenter` (
  `MainCenterID` int(11) NOT NULL AUTO_INCREMENT,
  `MainCName` varchar(500) NOT NULL,
  `City` varchar(500) NOT NULL,
  `State` varchar(100) NOT NULL,
  `URL` text NOT NULL,
  PRIMARY KEY (`MainCenterID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maincenter`
--

LOCK TABLES `maincenter` WRITE;
/*!40000 ALTER TABLE `maincenter` DISABLE KEYS */;
INSERT INTO `maincenter` VALUES (1,'IIT Bombay','mumbai','Maharashtra','www.it.iitb.ac.in');
/*!40000 ALTER TABLE `maincenter` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-01 13:09:38
