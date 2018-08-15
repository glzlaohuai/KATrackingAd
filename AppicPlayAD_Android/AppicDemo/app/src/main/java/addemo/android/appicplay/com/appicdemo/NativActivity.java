package addemo.android.appicplay.com.appicdemo;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;

import com.appicplay.sdk.ad.APBaseAD;
import com.appicplay.sdk.ad.listener.APNativeADListener;
import com.appicplay.sdk.ad.nativ.APNative;

public class NativActivity extends Activity {

    private static final String TAG = "NativActivity";
    APNative apNative;
    ViewGroup container;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.nativ);

        container = findViewById(R.id.nativContainer);

        findViewById(R.id.load).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (apNative != null) {
                    apNative.destroy();
                }

                apNative = new APNative(NativActivity.this, "PJyeKVAv", new APNativeADListener() {
                    @Override
                    public void success(APBaseAD apBaseAD, String s) {
                        Log.i(TAG, "success: ");
                        container.removeAllViews();

                        container.addView(((APNative) apBaseAD).getExposureView(container, APNative.MATCH_PARENT));
                        apBaseAD.show();
                    }

                    @Override
                    public void fail(APBaseAD apBaseAD, String s, String s1) {
                        Log.i(TAG, "fail: " + s1);
                    }

                    @Override
                    public void close(APBaseAD apBaseAD, String s) {
                        Log.i(TAG, "close: ");
                    }

                    @Override
                    public void click(APBaseAD apBaseAD, String s) {
                        Log.i(TAG, "click: ");
                    }
                });
                apNative.setPreferImageSize(600, 300);

                apNative.loadNative();
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (apNative != null) {
            apNative.onDestroy();
        }
    }
}
