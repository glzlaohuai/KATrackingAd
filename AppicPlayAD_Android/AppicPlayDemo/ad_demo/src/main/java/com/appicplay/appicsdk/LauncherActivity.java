package com.appicplay.appicsdk;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;

import com.appicplay.sdk.ad.APAD;

public class LauncherActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.launcher);
        setComponents();

        APAD.init(this, "test_test_test", "test_ad");
    }

    private void setComponents() {
        findViewById(R.id.nativeAD).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LauncherActivity.this, NativeADDemoActivity.class);
                startActivity(intent);
            }
        });
    }
}
