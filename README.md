# Demo: Using Google Protocol Buffers (proto/protobuf) in Perfect

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involved with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>

This repository holds one simple project designed to show you how protocol buffers are created & sent, as well as received & decoded.  

The objects in the API are separated by function:

- ChatMessage is the model we are using, as well as our generated proto (More on that later)
- Handlers contain the handlers used to send and receive the protobuffs
- ProtoSender contains the method used to actually send the data to the /receive endpoint


## Compatibility with Swift

The master branch of this project currently compiles with **Xcode 8.2/8.3 beta 2** or the **Swift 3.0.2/3.1** toolchains on Ubuntu. 

## Testing

### IMPORTANT NOTES ABOUT XCODE

If you choose to generate an Xcode Project by running `swift package generate-xcodeproj`, you **MUST** change to the executable target **AND** setup a custom working directory wherever you cloned the project. 

**IF YOU ARE USING PERFECT ASSISTANT, DO NOT RUN INTEGRATION -- THIS WILL BREAK THE XCODE BUILD**

![Proper Xcode Setup](https://raw.githubusercontent.com/PerfectExamples/Perfect-APNS-Demo/master/supporting/xcode.png)

### Following the Routes

First open [http://0.0.0.0:8181/](http://0.0.0.0:8181/) in your browser. 

Enter some text into the title and body fields, then hit send. 

The console output should look similar to:

```
[INFO] Starting HTTP server localhost on 0.0.0.0:8181
Serialized Proto into Data
Sending Proto…
Proto Received!
Proto was received and converted into a message with: 
title: Test 
body of: Message
```

To take a deeper look at what is going on in the app, set some breakpoints in the handlers. In general, `sendHandler` takes the POST variables from the webpage form, converts them into a protobuf-compatible model object, serializes that into `Data`, then passes that data to the `ProtoSender` struct to simulate sending the data to an API. From there, the data is sent to the /receive endpoint, and the `receiveHandler` takes the data in and converts it to a corresponding protobuf-compatible model object, which it then uses to print out text to the screen, thereby completing the chain of events that shows you how to create and send a protobuf, as well as receive and use one. 

## Proto Setup for Your Own Projects

**This is the procedure to generate your own models, just note that it has already been done in the sample project**

### Creating a .proto File for Your Own Models

If you're going to use your own model, you will need to setup a proto file. An example is given to you in the main directory of the project, see "ChatMessage.proto". In general, it should look something like this:

```
syntax = "proto3";

message ChatMessage {
    string title = 1;
    string body = 2;
}
```

Learn more about the syntax & available options [here](https://developers.google.com/protocol-buffers/)

### Generation of Swift Files

First, you need to make sure you have protocol buffers installed, which is easy to do with homebrew: `brew install protobuf`

Second, you need to clone & build Swift Provider:

```
git clone https://github.com/apple/swift-protobuf.git
cd swift-protobuf
swift build
```

Next, you need to copy the executable to a location in your path. This works, but feel free to put it where you like, just make sure it ends up in your shell $PATH:

```
sudo cp .build/debug/protoc-gen-swift /usr/local/bin
```

From there, restart your shell or open a new tab. Navigate to the directory your .proto files are in, and then run this command for each (just change ChatMessage.proto to your own model):

```
protoc --swift_out=./Sources/ ChatMessage.proto
```

The script will place .swift source files (like ChatMessage.pb.swift) into your source. If you have multiple targets, just adjust the file path above to put the models in the right place. 

## Issues

We are transitioning to using JIRA for all bugs and support related issues, therefore the GitHub issues has been disabled.

If you find a mistake, bug, or any other helpful suggestion you'd like to make on the docs please head over to [http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1) and raise it.

A comprehensive list of open issues can be found at [http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)



## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
