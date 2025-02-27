Original App Design Project
===

# Discount Discover

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [Video Walkthrough](#Video-Walkthrough)

## Overview
### Description
Discount Discover shows coupons and sales at nearby stores based on the user's current location. It notifies the user of deals when they are nearby a store that fits their preferences.

### App Evaluation
- **Category:** Shopping
- **Mobile:** This app makes use of maps and location to show the user deals nearby them. It also sends notifications of these deals.
- **Story:** This app makes it easy for users to find deals and decide where they might want to shop without having to go out of their way to look for them.
- **Market:** This app appeals to any individual who shops. This is a large potential user base.
- **Habit:** This app can be used any time the user wants to shop, which could be rather often.
- **Scope:** Building this app includes exploration of integrating a map SDK to find nearby stores, pulling the deals from an API, and creating a user profile with preferences. It could be expanded to create business profiles that can add deals.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create new account/log in to access preference settings
* User can see a list of all deals within a certain radius that fit their preferences (get deals from DiscountAPI)
* Tapping on a deal shows deal details
* Notification when nearby a store with deals that fits their preferences
* Settings (Account, Notifications)
* Profile with profile picture and preferences
* Map view (Google Maps SDK) where stores with deals are marked

**Optional Nice-to-have Stories**

* Users can submit deals for approval to be added
* Business profile that can add deals
* User can search stores
* Stores that don't have deals show at the bottom of the list

### 2. Screen Archetypes

* Login Screen
    * User can login
* Registration Screen
    * User can create a new account
* Profile
    * Upload profile photo
    * View and change preferences
* Stream - Nearby Deals
    * User can see a list of all deals within a certain radius that fit their preferences (from DiscountAPI)
* Map View
    * Stores with deals are marked
* Detail - Deals
    * Show details of tapped deal
* Settings
    * Account and notifications settings

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Deals
* Map View
* Profile

**Flow Navigation** (Screen to Screen)

* Login Screen
   * => Nearby Deals
* Registration Screen
   * => Preference Selection
   * => Nearby Deals
* Profile
   * => Settings
   * => Preference Selection
   * => Photo
* Stream - Nearby Deals
   * => Deals
* Map View
   * => Deals
* Detail - Deals
   * => None
* Settings
   * => None
   
## Wireframes
<img src="https://i.imgur.com/oLvl4M3.jpg" width=800>

## Schema 
### Models
#### Deal - from DiscountAPI

   | Property        | Type       | Description |
   | --------------- | ---------- | ------------|
   | name            | String     | name of deal |
   | description     | String     | description of deal |
   | finePrint       | String     | "fine print" details of deal |
   | url             | URL        | url of deal |
   | category        | String     | category of deal |
   | imageUrl        | URL        | url of deal's image |
   | expiresAt       | DateTime   | date when deal expires |
   | storeName       | String     | store provider of deal |
   | storeAddress    | String     | address of store |
   | storeCoordinate | Coordinate | coordinate of store |
   
#### User - from Parse

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | Number   | unique id for the user |
   | username      | String   | username of user |
   | password      | String   | password of user |
   | email         | String   | email of user |
   | preferences   | Array    | selected preference categories of user |

### Networking
#### List of network requests by screen
   - Login Screen
      - (Read/GET) Check login credentials
       ```objective-c
       [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error) {
                 NSLog(@"User log in failed: %@", error.localizedDescription);
            
            } else {
                 NSLog(@"User logged in successfully");
                 // segue to Nearby Stores
            }
        }
        ```
   - Registration Screen
      - (Create/POST) Create a new user
       ```objective-c
       [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error) {
                 NSLog(@"User log in failed: %@", error.localizedDescription);
            
            } else {
                 NSLog(@"User registered successfully");
                 // segue to Nearby Stores
            }
        }
        ```
   - Profile
      - (Update/PUT) Update user profile image
      ```objective-c
       PFQuery *query = [PFQuery queryWithClassName:@"User"];

        // Retrieve the object by id
        [query getObjectInBackgroundWithId:currentId block:^(PFObject *user, NSError *error) {
            user[@"image"] = // get image;
            [user saveInBackground];
        }
        ```
      - (Update/PUT) Update user preferences
      ```objective-c
       PFQuery *query = [PFQuery queryWithClassName:@"User"];

        // Retrieve the object by id
        [query getObjectInBackgroundWithId:currentId block:^(PFObject *user, NSError *error) {
            user[@"preferences"] = // new preferences;
            [user saveInBackground];
        }
        ```
        
#### Existing API Endpoints
##### Discount API
- Base URL - [https://api.discountapi.com/v2](https://api.discountapi.com/v2)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /deals/?location=location&radius=radius&category_slugs=category_slugs | get all deals within radius of location within specified categories
    `GET`    | /deals/:id | gets specific deal by :id
    `GET`    | /categories   | get all categories
    
## Video Walkthrough
<img src='https://i.imgur.com/NzzbnXR.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
