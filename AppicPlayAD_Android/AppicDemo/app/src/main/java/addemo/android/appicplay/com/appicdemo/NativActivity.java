package addemo.android.appicplay.com.appicdemo;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.appicplay.sdk.ad.APBaseAD;
import com.appicplay.sdk.ad.listener.APNativeADListener;
import com.appicplay.sdk.ad.nativ.APNative;
import com.appicplay.sdk.core.utils.LogUtils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class NativActivity extends Activity {

    private static final String TAG = "NativActivity";

    private APNative ad;

    public static String formatTime(long time) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String timeStr = "<" + simpleDateFormat.format(new Date(time)) + ">";
        return timeStr;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.nativ);

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
            adContainer.removeAllViews();
        }

        //
        APNative x = new APNative(this, "PJyeKVAv", new APNativeADListener() {
            @Override
            public void success(APBaseAD ad, String slotID) {
                NativActivity.this.ad = (APNative) ad;
                Toast.makeText(NativActivity.this, "load成功", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void fail(APBaseAD ad, String slotID, String errorMsg) {
                LogUtils.v(TAG, "失败：" + slotID + ",error:" + errorMsg);
                Toast.makeText(NativActivity.this, "load失败" + errorMsg, Toast.LENGTH_SHORT).show();

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

            }

            @Override
            public void gotoDownload(APBaseAD apBaseAD) {

            }
        });
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
        viewContainer.removeAllViews();
        viewContainer.addView(ad.getExposureView(viewContainer, APNative.MATCH_PARENT));

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
