// Callback URL: http://ec2-184-72-191-21.compute-1.amazonaws.com:portno/endpoint

var express = require('express');
var bodyParser = require('body-parser');
var request = require('request');
var AWS = require('aws-sdk');
var Hashids = require('hashids');

var app = express();
app.use(bodyParser.json());

var region = "us-west-1";
var accessKeyId = "AKIAJ266NZR4QF75FE3A";
var secretAccessKey = "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";
var secretHashSalt = "voBxXOCwSmjtGHYk6mVVzFI2Yr9gbf";

AWS.config.update({
    region: region,
    accessKeyId: accessKeyId,
    secretAccessKey: secretAccessKey
});

var dynamoDB = new AWS.DynamoDB.DocumentClient();

// Event operations -----------------------------------

app.post('/createEvent', function(req, res){
    console.log("POST: Received a createEvent request...");

    var event = req.body;
    var eventId = generateID();
    var params = {
        TableName: "hinder-events",
        Item: {
            "eventId": eventId,
            "name": event.name,
            "date": event.date,
            "location": event.location,
            "description": event.description,
            "photo": event.photo,
            "thumbnail": event.thumbnail,
            "projects": event.projects,
            "users": event.users
        }
    };
    dynamoDB.putItem(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("Error creating event: " + eventId + " - " + event.name);
        } else {
            console.log("Successfully created event: " + eventId + " - " + event.name);
        }
    });

    res.send("POST: createEvent request received.");
});

app.put('/editEvent', function(req, res){
    console.log("PUT: Received a request...");

    res.send("PUT: editEvent request received.");
});

app.delete('/deleteEvent', function(req, res){
    console.log("DELETE: Received a deleteEvent request...");

    var event = req.body;
    var params = {
        TableName: "hinder-events",
        Key: {
            eventId: event.eventId
        }
    };
    dynamoDB.deleteItem(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("Error deleting event: " + event.eventId + " - " + event.name);
        } else {
            console.log("Successfully deleted event: " + event.eventId + " - " + event.name);
        }
    });

    res.send("DELETE: deleteEvent request received.");
});

// User operations -----------------------------------

app.post('/createUser', function(req, res){
    console.log("POST: Received a createUser request...");

    var user = req.body;
    var userId = generateID();
    var params = {
        TableName: "hinder-users",
        Item: {
            "userId": userId,
            "name": user.name,
            "occupation": user.occupation,
            "photo": user.photo,
            "events": user.events,
            "skills": user.skills
        }
    };
    dynamoDB.putItem(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("Error creating user: " + userId + " - " + user.name);
        } else {
            console.log("Successfully created user: " + userId + " - " + user.name);
        }
    });

    res.send("POST: createUser request received.");
});

app.put('/editUser', function(req, res){
    console.log("PUT: Received an editUser request...");

    res.send("PUT: editUser request received.");
});

app.delete('/deleteUser', function(req, res){
    console.log("DELETE: Received a deleteUser request...");

    var user = req.body;
    var params = {
        TableName: "hinder-users",
        Key: {
            userId: user.userId
        }
    };
    dynamoDB.deleteItem(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("Error deleting user: " + user.userId + " - " + user.name);
        } else {
            console.log("Successfully deleted user: " + user.userId + " - " + user.name);
        }
    });

    res.send("DELETE: deleteUser request received.");
});

// Project operations ---------------------------------

app.post('/createProject', function(req, res){
    console.log("POST: Received a createProject request...");

    var project = req.body;
    var projectId = generateID();
    var params = {
        TableName: "hinder-projects",
        Item: {
            "projectId": projectId,
            "eventId": project.eventId,
            "name": project.name,
            "description": project.description,
            "size": project.size,
            "photo": project.photo,
            "skills": project.skills,
            "users": project.users
        }
    };
    dynamoDB.putItem(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("Error creating project: " + projectId + " - " + project.name);
        } else {
            console.log("Successfully created project: " + projectId + " - " + project.name);
        }
    });

    res.send("POST: createProject request received.");
});

app.put('/editProject', function(req, res){
    console.log("PUT: Received an editProject request...");

    res.send("PUT: editProject request received.");
});

app.delete('/deleteProject', function(req, res){
    console.log("DELETE: Received a deleteProject request...");

    var project = JSON.parse(data.toString());
    var params = {
        TableName: "hinder-projects",
        Key: {
            projectId: user.projectId
        }
    };
    dynamoDB.deleteItem(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("Error deleting project: " + project.projectId + " - " + project.name);
        } else {
            console.log("Successfully deleted project: " + project.projectId + " - " + project.name);
        }
    });

    res.send("DELETE: deleteProject request received.");
});

// Matching operations -----------------------------------

app.put('/match', function(req, res){
    console.log("PUT: Received a match request...");

    var match = JSON.parse(data.toString());
    var params = {
        TableName: "hinder-matches",
        Item: {
            "matchId": match.matchId,
            "matched": match.matched
        }
    };
    dynamoDB.putItem(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("Error creating match: " + matchId);
        } else {
            console.log("Successfully created match: " + projectId + " - " + match.matched);
        }
    });

    res.send("PUT: match request received.");
});

// Generate ID's ----------------------------------------

function generateID() {
    var timeStampInMs = Date.now();
    var hashids = new Hashids("voBxXOCwSmjtGHYk6mVVzFI2Yr9gbf");
    console.log(timeStampInMs);
    return hashids.encode(timeStampInMs);
}

// run --------------------------------------------------

app.listen(8080, function(){
    console.log("Listening on port 8080...");
});
