
# react-native-firebase-dynamic-links

## Getting started

`$ npm install react-native-firebase-dynamic-links --save`

### Mostly automatic installation

`$ react-native link react-native-firebase-dynamic-links`

## Setup

### iOS

Setup the Xcode project to receive incoming firebase dynamic links visit the link `https://firebase.google.com/docs/dynamic-links/ios/receive` for setup

#### RNFirebaseDynamicLinks AppDelegate extension

FirebaseDynamicLinks implements an AppDelegate method application openURL and continueUserActivity. You must manually add this file to the same folder where your AppDelegate.m lives:

Expand the RNFirebaseDynamicLinks project and drag/drop the file RNFirebaseDynamicLinks+AppDelegate.m and place the file to exist in the same folder as your app's AppDelegate.m. 

### Android

Setup the Android project to receive incoming firebase dynamic links visit the link `https://firebase.google.com/docs/dynamic-links/android/receive` for setup

#### Adding dynamic link listener

Attach a listener for incoming firebase links. Add the below code in you MainActivity to receive incoming dynamic links

```java
protected void onResume() {
    super.onResume();
    // Add firebase listener for dynamic links
    RNFirebaseDynamicLinksModule.attachDynamicLinkListener(this);
}
```

## Usage
```javascript
import RNFirebaseDynamicLinks from 'react-native-firebase-dynamic-links';

// Attach listener for incoming dynamic links
RNFirebaseDynamicLinks.addListener(this._handleLinkReceived);

_handleLinkReceived = (link) => {
  // Incoming deep link
}

// Remove the dynamic link listener
RNFirebaseDynamicLinks.removeListener();

```
  