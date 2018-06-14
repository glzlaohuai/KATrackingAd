package com.appicplay.appicsdk;

import android.app.Application;
import android.content.Context;
import android.support.multidex.MultiDex;

import com.appicplay.sdk.ad.APLifeCycleInvoker;

public class XApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        APLifeCycleInvoker.onApplicationCreate(this);
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        APLifeCycleInvoker.onApplicationAttachBaseContext(base);

        MultiDex.install(this);
    }
}
