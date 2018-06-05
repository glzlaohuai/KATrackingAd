package com.appicplay.appicsdk;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.ImageRequest;
import com.android.volley.toolbox.Volley;
import com.appicplay.sdk.ad.APBaseAD;
import com.appicplay.sdk.ad.listener.APNativeADListener;
import com.appicplay.sdk.ad.nativ.APNative;

import java.text.SimpleDateFormat;
import java.util.Date;

public class NativeADDemoActivity extends Activity {

    private static final String TAG = "NativeADDemoActivity";

    Button loadBtn;
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
        adContainer = findViewById(R.id.adContainer);

        loadBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                doLoadStuff();
            }
        });

    }

    private void doLoadStuff() {

        Log.i(TAG, "doLoadStuff: ");

        if (this.loadedAD != null) {
            this.loadedAD.destroy();
            adContainer.removeAllViews();
        }

        APNative apNative = new APNative(this, "XrGovLye", adContainer, adContainer, new APNativeADListener() {
            @Override
            public void success(APBaseAD ad, String slotID) {
                NativeADDemoActivity.this.loadedAD = (APNative) ad;
                handleLoadSuccess();
            }

            @Override
            public void fail(APBaseAD ad, String slotID, String errorMsg) {
                Toast.makeText(getApplicationContext(), "原生广告加载失败：" + errorMsg, Toast.LENGTH_SHORT).show();
            }

            @Override
            public void close(APBaseAD ad, String slotID) {
                Toast.makeText(getApplicationContext(), "原生广告被关闭：", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void click(APBaseAD ad, String slotID) {
                Toast.makeText(getApplicationContext(), "原生广告被点击：" + slotID, Toast.LENGTH_SHORT).show();
            }
        });
        apNative.load();
    }

    private void handleLoadSuccess() {

        Log.i(TAG, "handleLoadSuccess: 原生广告加载成功，加载物料...");

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(new ImageRequest(loadedAD.getImageUrl(), new Response.Listener<Bitmap>() {
            @Override
            public void onResponse(Bitmap response) {
                Log.i(TAG, "onResponse: 原生广告物料加载成功，进行展示...");
                doShow(response);
            }
        }, 0, 0, ImageView.ScaleType.CENTER, Bitmap.Config.ARGB_8888, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        }));
    }

    private void doShow(Bitmap bitmap) {

        ViewGroup viewContainer = adContainer;

        ImageView imageView = new ImageView(this);
        imageView.setImageBitmap(bitmap);
        imageView.setScaleType(ImageView.ScaleType.FIT_XY);

        int containerWidth = viewContainer.getWidth();

        float imageRatio = bitmap.getWidth() * 1.0f / bitmap.getHeight();

        int imageHeight = (int) (containerWidth / imageRatio);

        TextView textView = new TextView(this);
        textView.setText(this.loadedAD.getDesc());
        textView.setTextSize(15);
        textView.setPadding(10, 5, 5, 5);
        textView.setTextColor(Color.BLACK);

        viewContainer.addView(imageView, containerWidth, imageHeight);
        viewContainer.addView(textView, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

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