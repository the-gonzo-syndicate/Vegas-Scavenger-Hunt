# VEGAS SCAVENGER HUNT

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Vegas Scavenger Hunt is an iOS Application created with Swift, by a student organization of The College of Southern Nevada. The app will lead users on various themed scavenger hunts throughout Las Vegas. They will take pictures of the required areas, earning points and badges for each place they visit. This would lead to many opportunities for advertising of nearby businesses and attractions.

### App Evaluation
- **Category:** Travel & Tourism / Interactive Gaming.
- **Mobile:** Uses camera and location data, mobile only.
- **Story:** Allows users to search Las Vegas for stops on defined scavenger hunts, where upon the user can log their stop, take a         picture, and gain points on the leaderboard. 
- **Market:** It will be heavily marketed towards the Travel and Tourism industry, which Las Vegas caters to around 40 million tourists   a year. It will aid in giving tourists who often do not know what to do in Las Vegas a multitude of exciting goals to achieve, but yet   will also be challenging for locals as well. Eventually would love to add advertisements and featured stops. 
- **Habit:** Users can gain points for the various stops they visit, and complete entire scavenger hunts, which can be quite addicting.   Being able to see your progress on a leaderboard of others will also add to it's addictiveness.
- **Scope:** The scope is focused to showing people interesting places and sights in Las Vegas from a tourism standpoint, but can also     be used to deliver advertising and specials at nearby establishments. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a new account.
* User can login.
* User can view a profile page.
* User can view a leaderboard.
* User can scroll through a list of scavenger hunts.
* User can see details of a scavenger hunt.
* User can see details of a scavenger hunt stop.
* User can record visiting a scavenger hunt stop.
* User can take a picture at a scavenger hunt stop.
* User gains points for visiting places/completing scavenger hunts.

**Optional Nice-to-have Stories**

* User is greeted with an animated splash screen.
* User is shown an onboarding message upon first login.
* User recieves a video picture collage by email upon scavenger hunt completion.
* User can share scavenger hunt stop checkins on social media. 

### 2. Screen Archetypes

* Login Screen
   * User can login.
* Registration Screen
   * User can create a new account.
* Stream
   * User can scroll through a list of scavenger hunts.
* Profile
   * User can view a profile page.
* Stream
   * User can view a leaderboard.
* Detail
   * User can see details of a scavenger hunt.
* Detail 
   * User can see details of a scavenger hunt stop.
* Creation
   * User can record visiting a scavenger hunt stop.
   * User can take a picture at a scavenger hunt stop.
   * User gains points for visiting places/completing scavenger hunts.

### 3. Navigation

**1st Tab Navigation** (Tab to Screen)

* Profile
* Scavenger Hunt Feed
* Leaderboard

**2nd Tab Navigation**

* Scavenger Hunt Stop Detail
* Scavenger Hunt Stop Creation

**Flow Navigation** (Screen to Screen)

* Login Page
   * => Scavenger Hunt Feed
   * => Registration Screen
* Registration Screen
   * => Scavenger Hunt Feed
* Scavenger Hunt Feed
   * => Scavenger Hunt Detail
* Scavenger Hunt Detail
   * => Scavenger Hunt Stop Detail
* Scavenger Hunt Stop Detail
   * => Scavenger Hunt Stop Creation

## Wireframes
**Digital Wireframe**

<img src="https://github.com/the-gonzo-syndicate/Vegas-Scavenger-Hunt-Organizational/blob/master/Vegas_Scavenger_Hunt_Wireframe_3.PNG" width=600>

**Gif Wireframe Model**

<img src="http://g.recordit.co/7SP7IEA9dI.gif" width=400>


### [BONUS] Interactive Prototype

Interactive Prototype can be viewed here: https://www.figma.com/proto/Xg2hfX2mlsesFcS4GWt4ukhp/Vegas-Scavenger-Hunt?node-id=3%3A2&scaling=scale-down

## Schema 

### Models

#### User

| Property      | Type        | Description   |
|---------------|-------------|---------------|
| userID        | Number      | Unique ID given to each user | 
| userName      | String      | Unique name for user credentials |
| userPass      | String      | Unique password for user credentials |
| userEmail     | String      | User supplied Email address |
| profileImg    | File        | User loaded profile image |
| huntCount     | Number      | Number of Scavenger Hunts completed by user |
| stopCount     | Number      | Number of Scavenger Hunt stops visited by user |
| pointsCount   | Number      | Number of points collected over time by user |
| huntArray     | Array       | Array of completed Scavenger Hunts |
| stopArray     | Array       | Array of completed Scavenger Hunt Stops |

#### Hunt

| Property        | Type    | Description   |
|-----------------|---------|---------------|
| huntID          | Number  | Unique ID given to each Scavenger Hunt |
| huntName        | String  | Name given to each Scavenger Hunt |
| huntImg         | File    | Image assiciated with the Scavenger Hunt |
| huntBio         | String  | Information about the Scavenger Hunt for Detail Screen |
| huntStops       | Array   | Stops associated with this Scavenger Hunt |
| huntPointVal    | Number  | Point value associated with the completion of the Scavenger Hunt |
| huntDifficulty  | String  | Difficulty value set to the Scavenger Hunt |

#### Stop

| Property        | Type        | Description   |
|-----------------|-------------|---------------|
| stopID          | Number      | Unique ID given to each Scavenger Hunt Stop |
| stopName        | String      | Name given to each Scavenger Hunt Stop |
| stopImg         | File        | Image associated with the Scavenger Hunt Stop |
| stopBio         | String      | Information about the Scavenger Hunt Stop for Detail Screen |
| inHunt          | String      | Scavenger Hunt the Stop is a member of |
| stopCoords      | GeoLocation | Geographic Coordinates of Scavenger Hunt Stop |
| stopPointVal    | Number      | Point value associated with finding the Scavenger Hunt Stop |


### Networking
* Login Screen
   * (Read/GET) Query matching username and password
      ```swift
      @IBAction func onLogin(_ sender: Any) {
        
          let username = usernameField.text!
          let password = passwordField.text!
        
          PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
              if user != nil {
                  self.performSegue(withIdentifier: "loginSegue", sender: nil)
              } else {
                  print("Error: \(String(describing: error?.localizedDescription))")
              }
          }
      }
      ```
* Registration Screen
   * (Create/POST) Create user with username, password, and Email
      ```swift
      @IBAction func onSignUp(_ sender: Any) {
        
          let user = PFUser()
          
          user.userName = usernameField.text
          user.userPass = passwordField.text
          user.userEmail = emailField.text
        
          user.signUpInBackground { (success, error) in
              if success {
                  self.performSegue(withIdentifier: "loginSegue", sender: nil)
              } else {
                  print("Error: \(String(describing: error?.localizedDescription))")
              }
          }
      }
      ```
* Profile Screen
   * (Update/PUT) Change a user's profile image
      ```swift
      let user = PFObject(className: "User")
        
      let imageData = imageView.image!.pngData()
      let file = PFFileObject(data: imageData!)
        
      user["profileImg"] = file
        
      .saveInBackground { (success, error) in
          if success {
              self.dismiss(animated: true, completion: nil)
              print("saved!")
          } else {
              print("error!")
          }
      }
      ```
   * (Read/GET) Fetch username, hunts completed, stops completed, points, and profile picture
      ```swift
      let query = PFQuery(className: "User")
      
      query.selectKeys(["userName", "profileImg", "huntCount", "stopCOunt", "pointsCount"])
      
      query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
          if let error = error {
              print(error.localizedDescription)
          } else if let objects = objects {
              print("Success") 
              for object in objects {
                  print(object.objectId as Any)
              }
          }
      }
      ```
* Leaderboard Screen
   * (Read/GET) Fetch users with highest point, hunt, and stop totals
      ```swift
      var query = PFUser.query()
      
      query.selectKeys(["userName", "pointsCount", "huntCount", "stopCount"])
      
      query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
          if let error = error {
              print(error.localizedDescription)
          } else if let objects = objects {
              print("Success") 
              for object in objects {
                  print(object.objectId as Any)
              }
          }
      }
      ```
* Hunts Feed Screen
   * (Read/Get) Fetch details of hunts for individual Cells
      ```swift
      let query = PFQuery(className: "Hunt")
      
      query.selectKeys(["huntName", "huntImg", "huntBio", "huntStops", "huntPointVal", "huntDifficulty"])
      
      query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
          if let error = error {
              print(error.localizedDescription)
          } else if let objects = objects {
              print("Success") 
              for object in objects {
                  print(object.objectId as Any)
              }
          }
      }
      ```
   * (Read/GET) Fetch stops user has completed on each hunt Cell (Progress Bar)
      ```swift
      let query = PFQuery(className: "User")
      
      query.includeKey("huntArray")
      
      query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
          if let error = error {
              print(error.localizedDescription)
          } else if let objects = objects {
              print("Success") 
              for object in objects {
                  print(object.objectId as Any)
              }
          }
      }
      ```
* Hunt Detail Screen
   * (Read/GET) Fetch all hunt details
      ```swift
      let query = PFQuery(className: "Hunt")
      
      query.selectKeys(["huntName", "huntImg", "huntBio", "huntStops", "huntPointVal", "huntDifficulty"])
      
      query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
          if let error = error {
              print(error.localizedDescription)
          } else if let objects = objects {
              print("Success") 
              for object in objects {
                  print(object.objectId as Any)
              }
          }
      }
      ```
* Stop Detail Screen
   * (Read/GET) Fetch all stop details
      ```swift
      let query = PFQuery(className: "Stop")
      
      query.selectKeys(["stopName", "stopImg", "stopBio", "stopPointVal"])
      
      query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
          if let error = error {
              print(error.localizedDescription)
          } else if let objects = objects {
              print("Success") 
              for object in objects {
                  print(object.objectId as Any)
              }
          }
      }
      ```
* Location Capture Screen
   * (Create/Post) Capture GeoLocation, Picture, and add stop information to users visited stops
      ```swift
      let locationCapture = PFObject(className:"Stop")
      
      locationCapture["stopCoords"] = picture
      locationCapture["stopImg"] = coords
      
      // query for searching GeoLocations of all stops to match collected stop
      
      ```
### API endpoints
* No API endpoints are used
