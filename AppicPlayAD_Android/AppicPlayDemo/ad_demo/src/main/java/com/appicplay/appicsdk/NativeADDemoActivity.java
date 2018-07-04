package com.appicplay.appicsdk;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Toast;

import com.appicplay.sdk.ad.APBaseAD;
import com.appicplay.sdk.ad.listener.APNativeADListener;
import com.appicplay.sdk.ad.nativ.APNative;

import java.text.SimpleDateFormat;
import java.util.Date;

public class NativeADDemoActivity extends Activity {

    private static final String TAG = "NativeADDemoActivity";

    Button loadBtn;
    Button showBtn;
    ViewGroup adContainer;

    private APNative loadedAD;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.native_demo);

        initComponents();
    }


    private void initComponents() {
        loadBtn = findViewById(R.id.load);
        showBtn = findViewById(R.id.show);
        adContainer = findViewById(R.id.adContainer);

        loadBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                loadBtn.setEnabled(false);
                showBtn.setEnabled(false);
                doLoadStuff();
            }
        });

        showBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                doShow();
            }
        });
    }

    private void doLoadStuff() {

        Log.i(TAG, "doLoadStuff: ");

        if (this.loadedAD != null) {
            this.loadedAD.destroy();
            adContainer.removeAllViews();
        }

        APNative apNative = new APNative(this, "DlGdpoGq", new APNativeADListener() {
            @Override
            public void success(APBaseAD ad, String slotID) {
                Log.i(TAG, "success: ");
                Toast.makeText(NativeADDemoActivity.this, "success", Toast.LENGTH_SHORT).show();
                NativeADDemoActivity.this.loadedAD = (APNative) ad;
                enableShow();
                loadBtn.setEnabled(true);
            }

            @Override
            public void fail(APBaseAD ad, String slotID, String errorMsg) {
                Log.i(TAG, "fail: ");
                Toast.makeText(getApplicationContext(), "原生广告加载失败：" + errorMsg, Toast.LENGTH_SHORT).show();
                loadBtn.setEnabled(true);
            }

            @Override
            public void close(APBaseAD ad, String slotID) {
                Log.i(TAG, "close: ");
                Toast.makeText(getApplicationContext(), "原生广告被关闭：", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void click(APBaseAD ad, String slotID) {
                Log.i(TAG, "click: ");
                Toast.makeText(getApplicationContext(), "原生广告被点击：" + slotID, Toast.LENGTH_SHORT).show();
            }
        });
        apNative.setPreferImageSize(1080, 320);
        apNative.loadNative();
    }


    private void enableShow() {
        showBtn.setEnabled(true);
    }

    private void doShow() {
        adContainer.removeAllViews();
        adContainer.addView(loadedAD.getExposureView(adContainer, APNative.MATCH_PARENT));
        this.loadedAD.show();
    }

    public static String formatTime(long time) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String timeStr = "<" + simpleDateFormat.format(new Date(time)) + ">";
        return timeStr;
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (this.loadedAD != null) {
            this.loadedAD.onResume();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (this.loadedAD != null) {
            this.loadedAD.onPause();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (this.loadedAD != null) {
            this.loadedAD.onDestroy();
        }
    }
}