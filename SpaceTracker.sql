CREATE TABLE institution
(
  institutionID INT AUTO_INCREMENT NOT NULL,
  fullInstitutionName VARCHAR(100) NOT NULL,
  launchProvider bit NOT NULL,
  government bit NOT NULL,
  abbreviatedName VARCHAR(30) NOT NULL,
  employees INT,
  description VARCHAR(100) NOT NULL,
  founded INT NOT NULL,
  PRIMARY KEY (institutionID)
);

CREATE TABLE vehicleFamily
(
  vehicleFamilyID INT AUTO_INCREMENT NOT NULL,
  name VARCHAR(30) NOT NULL,
  block INT,
  description VARCHAR(300),
  version INT,
  operational bit,
  institutionID INT NOT NULL,
  PRIMARY KEY (vehicleFamilyID),
  FOREIGN KEY (institutionID) REFERENCES institution(institutionID)
);

CREATE TABLE offices
(
  officesID INT AUTO_INCREMENT NOT NULL,
  address VARCHAR(30) NOT NULL,
  city VARCHAR(30) NOT NULL,
  institutionID INT NOT NULL,
  PRIMARY KEY (officesID),
  FOREIGN KEY (institutionID) REFERENCES institution(institutionID)
);

CREATE TABLE orbit
(
  orbitID INT AUTO_INCREMENT NOT NULL,
  abbreviatedName VARCHAR(20),
  name VARCHAR(30) NOT NULL,
  PRIMARY KEY (orbitID)
);

CREATE TABLE engine
(
  engineID INT AUTO_INCREMENT NOT NULL,
  stageCombustion bit,
  thrustKN INT,
  chamberPressureBAR INT,
  impulseS INT,
  fuel VARCHAR(20),
  mixtureRatio FLOAT,
  pumps INT,
  inDev bit NOT NULL,
  operational bit NOT NULL,
  description VARCHAR(100) NOT NULL,
  name VARCHAR(30) NOT NULL,
  PRIMARY KEY (engineID)
);

CREATE TABLE stage
(
  stageID INT AUTO_INCREMENT NOT NULL,
  stageOnEarth INT NOT NULL,
  reusable bit NOT NULL,
  name VARCHAR(40) NOT NULL,
  stageOnMars INT NOT NULL,
  devVehicle bit NOT NULL,
  vehicleFamilyID INT NOT NULL,
  engineID INT,
  PRIMARY KEY (stageID),
  FOREIGN KEY (vehicleFamilyID) REFERENCES vehicleFamily(vehicleFamilyID),
  FOREIGN KEY (engineID) REFERENCES engine(engineID)
);

CREATE TABLE crew
(
  crewID INT AUTO_INCREMENT NOT NULL,
  firstName INT NOT NULL,
  lastName INT NOT NULL,
  active bit NOT NULL,
  institutionID INT NOT NULL,
  PRIMARY KEY (crewID),
  FOREIGN KEY (institutionID) REFERENCES institution(institutionID)
);

CREATE TABLE maritimeVesselType
(
  maritimeVesselTypeID INT AUTO_INCREMENT NOT NULL,
  typeName VARCHAR(30) NOT NULL,
  PRIMARY KEY (maritimeVesselTypeID)
);

CREATE TABLE launchRange
(
  launchRangeID INT AUTO_INCREMENT NOT NULL,
  fullName VARCHAR(50) NOT NULL,
  state VARCHAR(50) NOT NULL,
  latitude FLOAT,
  longitude FLOAT,
  institutionID INT NOT NULL,
  PRIMARY KEY (launchRangeID),
  FOREIGN KEY (institutionID) REFERENCES institution(institutionID)
);

CREATE TABLE events
(
  eventsID INT AUTO_INCREMENT NOT NULL,
  name VARCHAR(60) NOT NULL,
  description VARCHAR(200),
  streamURL VARCHAR(300),
  dateTime datetime,
  institutionID INT NOT NULL,
  PRIMARY KEY (eventsID),
  FOREIGN KEY (institutionID) REFERENCES institution(institutionID)
);

CREATE TABLE core
(
  coreID INT AUTO_INCREMENT NOT NULL,
  serial INT,
  stageID INT NOT NULL,
  PRIMARY KEY (coreID),
  FOREIGN KEY (stageID) REFERENCES stage(stageID)
);

CREATE TABLE mission
(
  missionID INT AUTO_INCREMENT NOT NULL,
  name INT NOT NULL,
  success INT,
  description VARCHAR(200),
  postMissionDescription VARCHAR(300),
  eventsID INT NOT NULL,
  PRIMARY KEY (missionID),
  FOREIGN KEY (eventsID) REFERENCES events(eventsID)
);

CREATE TABLE launchpad
(
  launchPadID INT AUTO_INCREMENT NOT NULL,
  FullName VARCHAR(30) NOT NULL,
  abbreviatedName VARCHAR(30) NOT NULL,
  launchRangeID INT NOT NULL,
  PRIMARY KEY (launchPadID),
  FOREIGN KEY (launchRangeID) REFERENCES launchRange(launchRangeID)
);

CREATE TABLE payload
(
  payloadID INT AUTO_INCREMENT NOT NULL,
  payloadMassKG INT,
  description VARCHAR(40),
  heightKM INT,
  longitude FLOAT,
  inclination FLOAT,
  classified bit,
  name VARCHAR(30) NOT NULL,
  orbitID INT,
  institutionID INT,
  missionID INT,
  PRIMARY KEY (payloadID),
  FOREIGN KEY (orbitID) REFERENCES orbit(orbitID),
  FOREIGN KEY (institutionID) REFERENCES institution(institutionID),
  FOREIGN KEY (missionID) REFERENCES mission(missionID)
);

CREATE TABLE crewMission
(
  crewMissionID INT AUTO_INCREMENT NOT NULL,
  crewID INT NOT NULL,
  missionID INT NOT NULL,
  PRIMARY KEY (crewMissionID),
  FOREIGN KEY (crewID) REFERENCES crew(crewID),
  FOREIGN KEY (missionID) REFERENCES mission(missionID)
);

CREATE TABLE spacecraft
(
  spacecraftID INT AUTO_INCREMENT NOT NULL,
  name VARCHAR(30) NOT NULL,
  crewed bit NOT NULL,
  stageID INT NOT NULL,
  payloadID INT NOT NULL,
  PRIMARY KEY (spacecraftID),
  FOREIGN KEY (stageID) REFERENCES stage(stageID),
  FOREIGN KEY (payloadID) REFERENCES payload(payloadID)
);

CREATE TABLE landingZone
(
  landingZoneID INT AUTO_INCREMENT NOT NULL,
  name CHAR(50) NOT NULL,
  abbreviatedName VARCHAR(30) NOT NULL,
  launchRangeID INT NOT NULL,
  PRIMARY KEY (landingZoneID),
  FOREIGN KEY (launchRangeID) REFERENCES launchRange(launchRangeID)
);

CREATE TABLE maritimeVessel
(
  maritimeVesselID INT AUTO_INCREMENT NOT NULL,
  currentLocation VARCHAR(100) NOT NULL,
  name VARCHAR(40) NOT NULL,
  active bit NOT NULL,
  institutionID INT NOT NULL,
  maritimeVesselTypeID INT NOT NULL,
  PRIMARY KEY (maritimeVesselID),
  FOREIGN KEY (institutionID) REFERENCES institution(institutionID),
  FOREIGN KEY (maritimeVesselTypeID) REFERENCES maritimeVesselType(maritimeVesselTypeID)
);

CREATE TABLE launchattempt
(
  launchAttemptID INT AUTO_INCREMENT NOT NULL,
  dateTime datetime,
  goForLaunch bit NOT NULL,
  scrubbed bit,
  scrubReason VARCHAR(100),
  backupDateTime datetime,
  missionID INT NOT NULL,
  launchPadID INT NOT NULL,
  PRIMARY KEY (launchAttemptID),
  FOREIGN KEY (missionID) REFERENCES mission(missionID),
  FOREIGN KEY (launchPadID) REFERENCES launchpad(launchPadID)
);

CREATE TABLE coreMission
(
  coreMissionID INT AUTO_INCREMENT NOT NULL,
  coreID INT NOT NULL,
  launchAttemptID INT NOT NULL,
  PRIMARY KEY (coreMissionID),
  FOREIGN KEY (coreID) REFERENCES core(coreID),
  FOREIGN KEY (launchAttemptID) REFERENCES launchattempt(launchAttemptID)
);

CREATE TABLE landingAttempt
(
  landingAttemptID INT AUTO_INCREMENT NOT NULL,
  success bit,
  coreMissionID INT NOT NULL,
  landingZoneID INT,
  maritimeVesselID INT,
  PRIMARY KEY (landingAttemptID),
  FOREIGN KEY (coreMissionID) REFERENCES coreMission(coreMissionID),
  FOREIGN KEY (landingZoneID) REFERENCES landingZone(landingZoneID),
  FOREIGN KEY (maritimeVesselID) REFERENCES maritimeVessel(maritimeVesselID)
);