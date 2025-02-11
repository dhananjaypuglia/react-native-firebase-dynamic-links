/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ToastAndroid
} from 'react-native';
import FirebaseDynamicLinks from 'react-native-firebase-dynamic-links';
import RNFirebase from 'react-native-firebase';

export default class Example extends Component {

  componentWillMount () {
    const firebase = RNFirebase.initializeApp();
    FirebaseDynamicLinks.addListener(this._handleLinkReceived);
  }

  componentWillUnmount () {
    FirebaseDynamicLinks.removeListener();
  }

  _handleLinkReceived = (link) => {
    if (link) {
      ToastAndroid.show(link, ToastAndroid.LONG);
    }
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.android.js
        </Text>
        <Text style={styles.instructions}>
          Double tap R on your keyboard to reload,{'\n'}
          Shake or press menu button for dev menu
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('Example', () => Example);
