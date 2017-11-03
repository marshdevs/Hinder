// Callback URL: http://ec2-184-72-191-21.compute-1.amazonaws.com:portno/endpoint

var express = require('express');
var request = require('request');
var aws = require('aws-sdk');

var app = express()

var region = "us-west";
var accessKeyId = "AKIAJUWZLWURXRRFR7OQ";
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
        
        var params = {
            TableName = "hinder-events";
            Item: {
                // Theoretical event schema
                "eventId": generateId(),
                "name": event.name,
                "date": event.date,
                "location": event.location,
                "description": event.description,
                "photo": event.photo,
                "thumbnail": event.thumbnail
            }
        };
        dynamoDB.putItem(params, function(err, data){
            if (err) {
                console.log(err);
                console.log("Error creating event: " + event);
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
                eventId: event.id
            }
        };
        dynamoDB.deleteItem(params, function(err, data){
            if (err) {
                console.log(err);
                console.log();
            } else {
                console.log("Successfully deleted event: " + event.id + " - " + event.name);
            }
        });

    });
});

// User operations -----------------------------------

app.post('/createUser', function(req, res){
    console.log("Received a createUser request...");

});

app.put('/editUser', function(req, res){
    console.log("Received an editUser request...");

});

app.delete('/deleteUser', function(req, res){
    console.log("Received a deleteUser request...");

});

// Project operations ---------------------------------

app.post('/createProject', function(req, res){
    console.log("Received a createProject request...");

});

app.put('/editProject', function(req, res){
    console.log("Received an editProject request...");

});

app.delete('/deleteProject', function(req, res){
    console.log("Received a deleteProject request...");

});

// Matching operations -----------------------------------

app.put('/', function(req, res){
    console.log("Received a  request...");

});
