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

app.get('/queryEvents/:location', function(req, res){
    console.log("GET: Received a queryEvents request...");

    var params = {
        TableName: "hinder-events",
        FilterExpression: "#loc = :userLocation",
        ExpressionAttributeNames: {
            "#loc": "eventLocation"
        },
        ExpressionAttributeValues: {
            ":userLocation": req.params.location
        }
    };
    dynamoDB.scan(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("GET: Error scanning events by location: " + req.params.location);
            res.status(404).send({status:"Error", description: "Failed to scan events by location.", field: "location", value: req.params.location});
        } else {
            console.log("GET: Successfully scanned events by location: " + req.params.location);
            res.status(200).send(data.Items);
        }
    });
});

app.post('/createEvent', function(req, res){
    console.log("POST: Received a createEvent request...");

    var event = req.body;
    var eventId = generateID();
    var params = {
        TableName: "hinder-events",
        Item: {
            "eventId": eventId,
            "eventName": event.name,
            "eventDate": event.date,
            "eventLocation": event.location,
            "eventDescription": event.description,
            "eventPhoto": event.photo,
            "eventThumbnail": event.thumbnail,
            "eventProjects": event.projects,
            "eventUsers": event.users
        }
    };
    dynamoDB.put(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("POST: Error creating event: " + eventId + " - " + event.name);
            res.status(503).send({status: "Error", description: "Failed to create event with ID.", field: "eventId", value: eventId});
        } else {
            console.log("POST: Successfully created event: " + eventId + " - " + event.name);
            res.status(200).send({status: "Success", eventId: eventId, description: "Successfully created event."});
        }
    });
});

app.get('/getEvent', function(req, res){
    console.log("GET: Received a getEvent request...");

    var params = {
        TableName: "hinder-events",
        Key: {
            eventId: req.query.eventId
        }
    };
    dynamoDB.get(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("GET: Error getting event by ID: " + req.query.eventId);
            res.status(404).send({status: "Error", description: "Failed to retrieve event by ID.", field: "eventId", value: req.query.eventId});
        } else {
            console.log("GET: Successfully queried event by ID: " + req.query.eventId);
            res.status(200).send(data.Item);
        }
    });
});

app.put('/updateEvent', function(req, res){
    console.log("PUT: Received an updateEvent request...");

    var event = req.body;
    var params = {
        TableName: "hinder-events",
        Key: {
            "eventId": event.eventId
        },
        UpdateExpression: "set eventName = :n, eventDate = :d, eventLocation = :l, \
            eventDescription = :e, eventPhoto = :p, eventThumbnail = :t,\
            eventProjects = :j, eventUsers = :u",
        ExpressionAttributeValues: {
            ":n": event.name,
            ":d": event.date,
            ":l": event.location,
            ":e": event.description,
            ":p": event.photo,
            ":t": event.thumbnail,
            ":j": event.projects,
            ":u": event.users
        },
        ReturnValues: "UPDATED_NEW"
    };
    dynamoDB.update(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("PUT: Error updating event: " + event.eventId + " - " + event.name);
            res.status(404).send({status: "Error", description: "Failed to update event by ID.", field: "eventId", value: event.eventId});
        } else {
            console.log("PUT: Successfully updated event: " + event.eventId);
            res.status(200).send({status: "Success", eventId: event.eventId, description: "Successfully updated event."});
        }
    });
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
    dynamoDB.delete(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("DELETE: Error deleting event by ID: " + event.eventId);
            res.status(404).send({status: "Error", description: "Failed to delete event by ID.", field: "eventId", value: event.eventId});
        } else {
            console.log("DELETE: Successfully deleted event by ID: " + event.eventId);
            res.status(200).send({status: "Success", eventId: event.eventId, description: "Successfully deleted event."});
        }
    });
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
            "userName": user.name,
            "userOccupation": user.occupation,
            "userPhoto": user.photo,
            "userEvents": user.events,
            "userSkillset": user.skillset
        }
    };
    dynamoDB.put(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("POST: Error creating user: " + userId + " - " + user.name);
            res.status(503).send({status: "Error", description: "Failed to create user with ID.", field: "userId", value: userId});
        } else {
            console.log("POST: Successfully created user: " + userId + " - " + user.name);
            res.status(200).send({status: "Success", userId: userId, description: "Successfully created user."});
        }
    });
});

app.get('/getUser', function(req, res){
    console.log("GET: Received a getUser request...");

    var params = {
        TableName: "hinder-users",
        Key: {
            userId: req.query.userId
        }
    };
    dynamoDB.get(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("GET: Error getting user by ID: " + req.query.userId);
            res.status(404).send({status: "Error", description: "Failed to get user by ID.", field: "userId", value: req.query.userId});
        } else {
            console.log("GET: Successfully queried user by ID: " + req.query.userId);
            res.status(200).send(data.Item);
        }
    });
});

app.put('/updateUser', function(req, res){
    console.log("PUT: Received an updateUser request...");

    var user = req.body;
    var params = {
        TableName: "hinder-users",
        Key: {
            "userId": user.userId
        },
        UpdateExpression: "set userName = :n, userOccupation = :o, userPhoto = :p,\
            userEvents = :e, userSkillset = :s",
        ExpressionAttributeValues: {
            ":n": user.name,
            ":o": user.occupation,
            ":p": user.photo,
            ":e": user.events,
            ":s": user.skillset
        },
        ReturnValues: "UPDATED_NEW"
    };
    dynamoDB.update(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("PUT: Error updating event: " + user.userId + " - " + user.name);
            res.status(404).send({status: "Error", description: "Failed to update event by ID.", field: "userId", value: user.userId});
        } else {
            console.log("PUT: Successfully updated event: " + user.userId);
            res.status(200).send({status: "Success", userId: user.userId, description: "Successfully updated user."});
        }
    });
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
    dynamoDB.delete(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("DELETE: Error deleting user by ID: " + user.userId);
            res.status(404).send({status: "Error", description: "Failed to delete user by ID.", field: "userId", value: user.userId});
        } else {
            console.log("DELETE: Successfully deleted user by ID: " + user.userId);
            res.status(200).send({status: "Success", userId: user.userId, description: "Successfully deleted user."});
        }
    });
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
            "projectName": project.name,
            "projectDescription": project.description,
            "projectSize": project.size,
            "projectPhoto": project.photo,
            "projectSkillset": project.skillset,
            "projectUsers": project.users
        }
    };
    dynamoDB.put(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("POST: Error creating project: " + projectId + " - " + project.name);
            res.status(503).send({status: "Error", description: "Failed to create project with ID.", field: "projectId", value: projectId});
        } else {
            console.log("POST: Successfully created project: " + projectId + " - " + project.name);
            res.status(200).send({status: "Success", projectId: projectId, description: "Successfully created project."});
        }
    });
});

app.get('/getProject', function(req, res){
    console.log("GET: Received a getProject request...");

    var params = {
        TableName: "hinder-projects",
        Key: {
            projectId: req.query.projectId
        }
    };
    dynamoDB.get(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("GET: Error getting project by ID: " + req.query.projectId);
            res.status(404).send({status: "Error", description: "Failed to get project by ID.", field: "projectId", value: req.query.projectId});
        } else {
            console.log("GET: Successfully queried project by ID: " + req.query.projectId);
            res.status(200).send(data.Item);
        }
    });
});

app.put('/updateProject', function(req, res){
    console.log("PUT: Received an editProject request...");

    var project = req.body;
    var params = {
        TableName: "hinder-projects",
        Key: {
            "projectId": project.projectId
        },
        UpdateExpression: "set projectName = :n, projectDescription = :d, projectSize = :s, \
            projectPhoto = :p, projectSkillset = :t, projectUsers = :u",
        ExpressionAttributeValues: {
            ":n": project.name,
            ":d": project.description,
            ":s": project.size,
            ":p": project.photo,
            ":t": project.skillset,
            ":u": project.users
        },
        ReturnValues: "UPDATED_NEW"
    };
    dynamoDB.update(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("PUT: Error updating project: " + project.projectId + " - " + project.name);
            res.status(404).send({status: "Error", description: "Failed to update project by ID.", field: "projectId", value: project.projectId})
        } else {
            console.log("PUT: Successfully updated project: " + project.projectId);
            res.status(200).send({status: "Success", projectId: project.projectId, description: "Successfully updated project."});
        }
    });
});

app.delete('/deleteProject', function(req, res){
    console.log("DELETE: Received a deleteProject request...");

    var project = req.body;
    var params = {
        TableName: "hinder-projects",
        Key: {
            projectId: project.projectId
        }
    };
    dynamoDB.delete(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("DELETE: Error deleting project by ID: " + project.projectId);
            res.status(404).send({status: "Error", description: "Failed to delete project by ID.", field: "projectId", value: project.projectId});
        } else {
            console.log("DELETE: Successfully deleted project by ID: " + project.projectId);
            res.status(200).send({status: "Success", projectId: project.projectId, description: "Successfully created project."});
        }
    });
});

// Matching operations -----------------------------------

// Returns false if one of the user/project pair has swiped left, or if no entry exists yet
app.put('/match/:event/:direction/:key', function(req, res){
    console.log("PUT: Received a match request...");

    var direction = true
    if (req.params.direction == "left") {
        direction = false
    }
    var eventId = req.params.event;
    var matchId = req.params.key;
    var params = {
        TableName: "hinder-matches",
        Key: {
            "eventId": eventId
        }
    };
    dynamoDB.get(params, function(err, data){
        if (err) {
            console.log(err);
            console.log("PUT: Error returning matches for eventId: " + eventId);
            res.status(503).send({status: "Error", description: "Could not return matches for eventId. Probably does not exist yet.", field: "eventId", value: eventId});
        } else {
            console.log(data.Item);
            if (data.Item == undefined) {
                console.log("PUT: Error getting matches for event: " + eventId);
                console.log("Creating matches entry for eventId...");
                var params = {
                    TableName: "hinder-matches",
                    Item: {
                        "eventId": eventId,
                        "matches": [{
                            "matchId": matchId,
                            "approve": direction
                        }]
                    }
                };
                dynamoDB.put(params, function(err, data){
                    if (err) {
                        console.log(err);
                        console.log("PUT: Error creating entry for event: " + eventId);
                        res.status(503).send({status: "Error", description: "Could create new match element for eventId.", field: "eventId", value: eventId});
                    } else {
                        console.log("Successfully created entry for event: " + eventId);
                        res.status(200).send(false);
                    }
                });
            } else {
                // Check if pair match exists
                for (var i = 0; i < data.Item.matches.length; i++) {
                    if (data.Item.matches[i].matchId == matchId) {
                        console.log("PUT: Successfully returned match: " + matchId + " - " + data.Item.matches);
                        res.status(200).send(data.Item.matches[i].approve);
                        return
                    }
                }
                // Match doesn't exist, create it
                var project = req.body;
                var params = {
                    TableName: "hinder-matches",
                    Key: {
                        "eventId": eventId
                    },
                    UpdateExpression: "SET #matches = list_append(#matches, :newmatch)",
                    ExpressionAttributeNames: {
                        "#matches" : "matches"
                    },
                    ExpressionAttributeValues: {
                        ":newmatch": [{"matchId": matchId, "approve": direction}]
                    },
                    ReturnValues: "UPDATED_NEW"
                };
                dynamoDB.update(params, function(err, data){
                    if (err) {
                        console.log(err);
                        console.log("PUT: Error creating match: " + matchId + " - " + direction);
                        res.status(404).send({status: "Error", description: "Failed to update match with ID.", field: "matchId", value: matchId})
                    } else {
                        console.log("PUT: Successfully created match: " + matchId + " - " + direction);
                        res.status(200).send(false);
                    }
                });
            }
        }
    });
});

// Generate ID's ----------------------------------------

function generateID() {
    var timeStampInMs = Date.now();
    var hashids = new Hashids("voBxXOCwSmjtGHYk6mVVzFI2Yr9gbf");
    return hashids.encode(timeStampInMs);
}

// run --------------------------------------------------

app.listen(8080, function(){
    console.log("Listening on port 8080...");
});
