package com.dhansiddh.rnfirebasedynamiclinks.example;

import android.os.Bundle;

import com.dhansiddh.rnfirebasedynamiclinks.RNFirebaseDynamicLinksModule;
import com.facebook.react.ReactActivity;

public class MainActivity extends ReactActivity {

    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "Example";
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onResume() {
        super.onResume();
        RNFirebaseDynamicLinksModule.attachDynamicLinkListener(this);
    }
}
