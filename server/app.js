// Callback URL: http://ec2-184-72-191-21.compute-1.amazonaws.com:portno/endpoint

var express = require('express');
var request = require('request');
var aws = require('aws-sdk');

var app = express()

var region = "us-west";
var accessKeyId = "AKIAJ266NZR4QF75FE3A";
var secretAccessKey = "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";

aws.config.update({
    region: region,
    accessKeyId: accessKeyId,
    secretAccessKey: secretAccessKey
});

var dynamoDB = aws.DynamoDB.DocumentClient();

// Event operations -----------------------------------

app.post('/createEvent', function(req, res){
    console.log("Received a createEvent request...");

    req.on('data', function(data){
        var event = JSON.parse(data.toString());
        var eventId = generateEID();
        var params = {
            TableName = "hinder-events";
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
    });
});

app.put('/editEvent', function(req, res){
    console.log("Received a request...");

});

app.delete('/deleteEvent', function(req, res){
    console.log("Received a deleteEvent request...");

    req.on('data', function(data){
        var event = JSON.parse(data.toString());
        var params = {
            TableName: "hinder-events";
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

    });
});

// User operations -----------------------------------

app.post('/createUser', function(req, res){
    console.log("Received a createUser request...");

    req.on('data', function(data){
        var user = JSON.parse(data.toString());
        var userId = generateUID();
        var params = {
            TableName = "hinder-users";
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
    });
});

app.put('/editUser', function(req, res){
    console.log("Received an editUser request...");

});

app.delete('/deleteUser', function(req, res){
    console.log("Received a deleteUser request...");

    req.on('data', function(data){
        var user = JSON.parse(data.toString());
        var params = {
            TableName: "hinder-users";
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

    });
});

// Project operations ---------------------------------

app.post('/createProject', function(req, res){
    console.log("Received a createProject request...");

    req.on('data', function(data){
        var project = JSON.parse(data.toString());
        var projectId = generatePID();
        var params = {
            TableName = "hinder-projects";
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
    });
});

app.put('/editProject', function(req, res){
    console.log("Received an editProject request...");

});

app.delete('/deleteProject', function(req, res){
    console.log("Received a deleteProject request...");

    req.on('data', function(data){
        var project = JSON.parse(data.toString());
        var params = {
            TableName: "hinder-projects";
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

    });
});

// Matching operations -----------------------------------

app.put('/match', function(req, res){
    console.log("Received a match request...");

    req.on('data', function(data){
        var match = JSON.parse(data.toString());
        var params = {
            TableName = "hinder-matches";
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
    });
});
