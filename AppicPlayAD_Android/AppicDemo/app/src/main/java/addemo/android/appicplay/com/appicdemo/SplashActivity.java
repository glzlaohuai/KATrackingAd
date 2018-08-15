package addemo.android.appicplay.com.appicdemo;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.widget.LinearLayout;

import com.appicplay.sdk.ad.APBaseAD;
import com.appicplay.sdk.ad.listener.APSplashADListener;
import com.appicplay.sdk.ad.splash.APSplash;

public class SplashActivity extends Activity implements View.OnClickListener {

    private static final String TAG = "SplashActivity";

    APSplash splash;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.splash);
        findViewById(R.id.load).setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.load:
                loadSplash();
                break;
        }
    }

    private void loadSplash() {

        if (splash != null) {
            splash.onDestroy();
        }


        splash = new APSplash(this, "zKyjJJyM", new APSplashADListener() {
            @Override
            public void dismiss(APBaseAD apBaseAD, String s) {
                Log.i(TAG, "dismiss: ");
            }

            @Override
            public void present(APBaseAD apBaseAD, String s) {
                Log.i(TAG, "present: ");
            }

            @Override
            public void clicked(APBaseAD apBaseAD, String s) {
                Log.i(TAG, "clicked: ");
            }

            @Override
            public void failed(APBaseAD apBaseAD, String s, String s1) {
                Log.i(TAG, "failed: " + s1);
            }
        });

        splash.loadAndPresent((LinearLayout) findViewById(R.id.splashContainer), R.layout.splash_bottom);

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        if (splash != null) {
            splash.onDestroy();
        }
    }
}
