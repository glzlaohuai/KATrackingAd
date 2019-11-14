package addemo.android.appicplay.com.appicdemo;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import com.ap.android.atom.sdk.ad.APAD;
import com.ap.android.atom.sdk.core.APSDK;

public class LauncherActivity extends AppCompatActivity implements View.OnClickListener {

    private static final String TAG = "LauncherActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.launcher);

        findViewById(R.id.banner).setOnClickListener(this);
        findViewById(R.id.nativ).setOnClickListener(this);
        findViewById(R.id.interstitial).setOnClickListener(this);
        findViewById(R.id.splash).setOnClickListener(this);
        findViewById(R.id.incentivized).setOnClickListener(this);
        findViewById(R.id.nativ_raw).setOnClickListener(this);
        findViewById(R.id.nativ_list).setOnClickListener(this);

        APSDK.init(this, Config.APP_INFO_ID);
        APAD.setIsMobileNetworkDirectlyDownload(true);
        APAD.useDefaultConfigForSplashIfNoConfigExist(this, "zKyjJJyM");
    }

    @Override
    public void onClick(View view) {

        Intent intent = null;
        switch (view.getId()) {
            case R.id.nativ:
                intent = new Intent(LauncherActivity.this, NativActivity.class);
                break;
            case R.id.nativ_raw:
                intent = new Intent(LauncherActivity.this, NativRawActivity.class);
                break;
            case R.id.nativ_list:
                intent = new Intent(LauncherActivity.this, NativListActivity.class);
                break;
            case R.id.banner:
                intent = new Intent(LauncherActivity.this, BannerActivity.class);
                break;

            case R.id.interstitial:
                intent = new Intent(LauncherActivity.this, InterstitialActivity.class);
                break;

            case R.id.splash:
                intent = new Intent(LauncherActivity.this, SplashActivity.class);
                break;

            case R.id.incentivized:
                intent = new Intent(LauncherActivity.this, IncentivizedActivity.class);
                break;

        }
        startActivity(intent);


    }
}
