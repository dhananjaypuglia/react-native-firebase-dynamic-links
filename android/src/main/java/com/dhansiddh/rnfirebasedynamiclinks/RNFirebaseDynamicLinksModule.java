
package com.dhansiddh.rnfirebasedynamiclinks;

import android.app.Activity;
import android.net.Uri;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.dynamiclinks.FirebaseDynamicLinks;
import com.google.firebase.dynamiclinks.PendingDynamicLinkData;

public class RNFirebaseDynamicLinksModule extends ReactContextBaseJavaModule {

  public static ReactApplicationContext context;
  private static String deepLinkReceivedEvent = "onDeepLinkReceived";
  private String moduleName = "RNFirebaseDynamicLinks";

  public RNFirebaseDynamicLinksModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  public static void attachDynamicLinkListener(Activity mainActivity) {
    FirebaseDynamicLinks.getInstance()
            .getDynamicLink(mainActivity.getIntent())
            .addOnSuccessListener(mainActivity, new OnSuccessListener<PendingDynamicLinkData>() {
              @Override
              public void onSuccess(PendingDynamicLinkData pendingDynamicLinkData) {
                // Get deep link from result (may be null if no link is found)
                Uri deepLink = null;
                if (pendingDynamicLinkData != null) {
                  // Handle the deep link here
                  deepLink = pendingDynamicLinkData.getLink();
                  sendEvent(context, deepLinkReceivedEvent, deepLink.toString());
                }
              }
            })
            .addOnFailureListener(mainActivity, new OnFailureListener() {
              @Override
              public void onFailure(@NonNull Exception e) {
//                Log.d("Linking failed", "getDynamicLink:onFailure", e);
              }
            });
  }

  private static void sendEvent(ReactContext reactContext,
                                String eventName,
                                @Nullable String params) {
    reactContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
            .emit(eventName, params);
  }

  @Override
  public String getName() {
    return moduleName;
  }
}