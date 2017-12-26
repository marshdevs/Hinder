
# Hinder
*The Easy Way to Find Teammates*<br><br>
**CS 130: Software Engineering**<br>
**Professor:** Miryung Kim<br>

**Discussion 1B**<br>
**TA:** Twinkle Gupta<br>

**Team Name:** TBD<br>
Kimberly Svatos, 604425426<br>
Marshall Briggs, 304417630<br>
Kyle Haacker, 904467146<br>
George Archbold, 604407413<br>
Daniel Berestov, 404441309<br>
Apurva Panse, 504488023<br>

**Team Repository:** https://github.com/marshdevs/Hinder<br>
**YouTube Demo:** https://www.youtube.com/watch?v=qBbuuaJ-_Y4

## Project Motivation
When it comes to group based projects where the groups are expected to be formed and the project finished in a specific amount of time, such as for a Hackathon or class, finding groups can be difficult, especially if you go in alone. It can be challenging to figure out who to team up with, and, more importantly, if the skills or interests of the people you approach align with the project and goals you had in mind. Unfortunately, this often leads to settling for a group you’re unsatisfied with, if for no other reason than it was the only group you could find or approach. Our team wanted to create a solution to this problem, through Hinder, a matchmaking service specifically for group projects and Hackathons. By exposing all project teams to event attendees, and vice versa, we allow teams to find members that have a skillset aligning with their needs, and a programmer can browse and match with a project that truly interests them. We hope that by acting as a middleman who introduces teams and programmers to each other, we can improve the overall experience for hackathons and other group projects.<br>

## Feature Description 
# Project Matching
The main interface of the project, the majority of the code for Project Matching occurs in MyKoladaViewController.swift
# Profile Editing
This is how a user edits what projects will see on them when swiping for potential team members. This is all editable by the user, and the majority of the code is in EditProfileViewController.swift
# Project Creation
If a user signs up for an event and already has an existing project idea, and only wants to find more teammates, their use case will be to create a project. This occurs in CreateProjectViewController.swift
# Project Viewing
Once a user is matched to a group/project, they will want to be able to view these projects to be able to contact 
# Event Creation


## API Documentation
A selection of classes with API functions are SessionUser (Singleton, provides shared, global access to signed-in user), ImageListener (Observer pattern, for asynchronous image download), and the User/Event/Project/MediatorRequest classes for making requests in the backend. A more complete, detailed discussion of our APIs is included in the part C report. We used XCode markup language (documentation in the Apple Developer docs). We then used jazzy (command "jazzy --min-acl internal") to generate the HTML documentation for our APIs. Complete API documentation can be found in this repository, in the directory "APIDocs/".

