package addemo.android.appicplay.com.appicdemo;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.androidquery.AQuery;
import com.ap.android.atom.sdk.ad.APBaseAD;
import com.ap.android.atom.sdk.ad.listener.APNativeADListener;
import com.ap.android.atom.sdk.ad.nativ.APNative;
import com.ap.android.atom.sdk.ad.nativ.APNativePattern;
import com.ap.android.atom.sdk.core.utils.LogUtils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class NativRawActivity extends Activity {

    private static final String TAG = "NativRawActivity";

    private APNative ad;

    private AQuery aQuery = new AQuery(this);

    public static String formatTime(long time) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String timeStr = "<" + simpleDateFormat.format(new Date(time)) + ">";
        return timeStr;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.nativ_raw);

        findViewById(R.id.load).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                load();
            }
        });

        findViewById(R.id.show).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                show();
            }
        });
    }

    private void load() {
        LogUtils.v(TAG, "开始进行原生广告load...");

        if (this.ad != null) {
            this.ad.destroy();
            ViewGroup adContainer = this.findViewById(R.id.viewContainer);
            adContainer.setOnTouchListener(null);
            adContainer.setOnClickListener(null);
        }

        //
        APNative x = new APNative(this, Config.NATIVE_SLOT_ID, new APNativeADListener() {
            @Override
            public void success(APBaseAD ad, String slotID) {
                NativRawActivity.this.ad = (APNative) ad;
                Toast.makeText(NativRawActivity.this, "load成功", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void fail(APBaseAD ad, String slotID, String errorMsg) {
                LogUtils.v(TAG, "失败：" + slotID + ",error:" + errorMsg);
                Toast.makeText(NativRawActivity.this, "load失败" + errorMsg, Toast.LENGTH_SHORT).show();

            }

            @Override
            public void close(APBaseAD ad, String slotID) {
                LogUtils.v(TAG, "被关闭：" + slotID);
            }

            @Override
            public void click(APBaseAD ad, String slotID) {
                LogUtils.v(TAG, "被点击：" + slotID);
            }

            @Override
            public void gotoDeeplink(APBaseAD apBaseAD) {
                Log.i(TAG, "gotoDeeplink: ");
            }

            @Override
            public void gotoDownload(APBaseAD apBaseAD) {
                Log.i(TAG, "gotoDownload: ");
            }

            @Override
            public void videoShowFailed(APBaseAD apBaseAD, String s) {
                Log.i(TAG, "videoShowFailed: "+s);
            }

            @Override
            public void videoShowCompleted(APBaseAD apBaseAD) {
                Log.i(TAG, "videoShowCompleted: ");
            }

            @Override
            public void videoShowCountDown(APBaseAD apBaseAD, int i) {
                Log.i(TAG, "videoShowCountDown: ");
            }
        });
        x.setPattern(APNativePattern.RAW);
        x.setPreferImageSize(640, 960);
        x.loadNative();
    }

    private void show() {

        if (ad == null) return;

        String iconUrl = ad.getIconUrl();
        String imgUrl = ad.getImageUrl();
        String title = ad.getTitle();
        String desc = ad.getDesc();

        String action = ad.getActionText();

        LogUtils.v(TAG, "icon:" + iconUrl + ",imageUrl:" + imgUrl + ",title:" + title + ",desc:" + desc + ",action:" + action);

        ViewGroup viewContainer = findViewById(R.id.viewContainer);

        TextView titleView = findViewById(R.id.titleView);
        TextView descView = findViewById(R.id.descView);
        TextView actionView = findViewById(R.id.actionView);

        ImageView imgView = findViewById(R.id.imgView);

        titleView.setText(title);
        descView.setText(desc);
        actionView.setText(action);

        aQuery.id(imgView).image(imgUrl);

        ad.registerViewForInteraction(viewContainer);
        ad.show();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (this.ad != null) {
            this.ad.onResume();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (this.ad != null) {
            this.ad.onPause();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (this.ad != null) {
            this.ad.onDestroy();
        }
    }
}
