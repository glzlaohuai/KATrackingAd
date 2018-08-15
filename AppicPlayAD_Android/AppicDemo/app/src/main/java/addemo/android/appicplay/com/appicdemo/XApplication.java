package addemo.android.appicplay.com.appicdemo;

import android.app.Application;
import android.content.Context;
import android.support.multidex.MultiDex;

import com.appicplay.sdk.core.APApplication;

public class XApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        APApplication.onApplicationCreate(this);
    }


    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);

        APApplication.onApplicationAttachBaseContext(base);

        MultiDex.install(this);
    }
}
