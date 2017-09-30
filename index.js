import {DeviceEventEmitter} from 'react-native';

class RNFirebaseDynamicLinks {
  static subscription;

  addListener (listenser) {
    if (listenser) {
      this.subscription = DeviceEventEmitter.addListener(
        'onDeepLinkReceived',
        (link) => listenser(link)
      );
    }
  }

  removeListener () {
    if (this.subscription) {
      this.subscription.remove();
    }
  }
}

const rnFirebaseDynamicLinks = new RNFirebaseDynamicLinks();

export default rnFirebaseDynamicLinks;