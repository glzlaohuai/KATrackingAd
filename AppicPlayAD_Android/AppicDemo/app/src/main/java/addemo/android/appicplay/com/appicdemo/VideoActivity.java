package addemo.android.appicplay.com.appicdemo;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;

import com.appicplay.sdk.ad.listener.APVideoADListener;
import com.appicplay.sdk.ad.video.APVideo;

public class VideoActivity extends Activity {


    private static final String TAG = "VideoActivity";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.video);

        APVideo.setActivity(this);
        APVideo.setListener(new APVideoADListener() {
            @Override
            public void loadFailed(String s) {
                Log.i(TAG, "loadFailed: " + s);
            }

            @Override
            public void loadSuccess() {
                Log.i(TAG, "loadSuccess: ");
            }

            @Override
            public void showComplete() {
                Log.i(TAG, "showComplete: ");
            }

            @Override
            public void clicked() {
                Log.i(TAG, "clicked: ");
            }

            @Override
            public void showFailed(String s) {
                Log.i(TAG, "showFailed: ");
            }
        });

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

        APVideo.loadVideoAD();

    }

    private void show() {
        if (APVideo.isReady()) {
            APVideo.showVideoAD(this);
        } else {
            Log.i(TAG, "show: video is not ready, show failed.");
        }
    }
}
