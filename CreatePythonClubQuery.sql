-- Creating the Python Club tables through a query
-- Here are the requirements:
/*
Data Requirements:

>Meetings Schedule: place, time, Date,speakers, subject, duration, 
>Meeting minutes:  participants (all the above), minutes, Topics to Follow up, results,
Meetup: meetup place, time, Date, participants, speakers, subject, duration, contact, post date, member who posted
>Members: MemberId, name, email, member since, leadership role
Posting: event
Resources and Tutorials: member who posted, Post date, subject, URL, description, rating
General Announcements: who posted, topic, Date Posted, Text
Discussion Board: Topic, who posted, discussion, comments
Login information--
Report inappropriate data--member reporting, post id, what is inappropriate, reviewed by, date, discussion

Reporting Requirements
Users: Officers, Members, public, Database Admin
Views do you need--security
Members, email list, 
List events, Upcoming events, history of events
List of meetings with minutes
List of Resources
List of Analytics
Advertizing

Security
Officers : what can they do
Post meetings, Add members, Delete members, remove posts, post minutes, Post events, post resources, discussions
Post meet ups, (Insert, update and delete in any table)
Manage member interactions to keep them legal and civil
View anything
Roles
members: Post events, discussion, announcements, add resources
Edit their own posts, but no one elses
view anything (question on member names and emails) member has option to make email public or not
Members can report inappropriate content, only view own reports and discussion
Non members
View most things, not member emails, not reports on inappropriate material.

*/

-- CTRL+R and click Next a bunch of times and the EER diagram is created automatically

-- "Updating" the tables cheat - Drop all tables and recreate them

-- Tables with foreign keys must be dropped first
DROP TABLE IF EXISTS pythonclub.attendance;
DROP TABLE IF EXISTS pythonclub.meetingminutes;
-- Drop table meetings schedule

-- Primary keys next
DROP TABLE IF EXISTS pythonclub.members;
DROP TABLE IF EXISTS pythonclub.meeting;

CREATE TABLE members (
	PK_idMembers INT NOT NULL,
    PRIMARY KEY (PK_idMembers),
    
    LastName VARCHAR(45),
    FirstName VARCHAR(45),
    Email VARCHAR(100),
    DateAdded DATE
);

CREATE TABLE meeting (
	PK_idMeeting INT NOT NULL,
    PRIMARY KEY (PK_idMeeting),
    
    MeetingType VARCHAR(45),
    MeetingDate DATE,
    MeetingTime TIME
);

-- I think SQL code runs top to bottom, because this must be put after meeting and members since it uses their PKs
CREATE TABLE attendance (
	FK_idMembers INT NOT NULL,
	FOREIGN KEY (FK_idMembers) REFERENCES members(PK_idMembers),
    
    FK_idMeeting INT NOT NULL,
    FOREIGN KEY (FK_idMeeting) REFERENCES meeting(PK_idMeeting)
);

CREATE TABLE meetingminutes (
	FK_idMembers_Participants INT NOT NULL,
    FOREIGN KEY (FK_idMembers_Participants) REFERENCES members(PK_idMembers),
    
	Minutes INT,
    TopicsToFollowUp int, -- I don't know what this is supposed to be
    results int -- Don't know what this is either
);

CREATE TABLE meetings_schedule (
	MeetingPlace VARCHAR(45),
    MeetingTime TIME,
    MeetingDate DATE,
    
    FK_idMembers_Speakers INT NOT NULL,
    FOREIGN KEY (FK_idMembers_Speakers) REFERENCES members(PK_idMembers),
    
    MeetingSubject VARCHAR(45),
    MeetingDuration VARCHAR(45) -- INT and TIME don't really make sense for duration and the data-entry person can just write it in plaintext
);



-- MeetingMinutes
