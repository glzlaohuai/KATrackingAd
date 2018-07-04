package com.appicplay.appicsdk;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.appicplay.sdk.ad.APBaseAD;
import com.appicplay.sdk.ad.listener.APNativeADListener;
import com.appicplay.sdk.ad.nativ.APNative;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class NativeADDemoActivity2 extends Activity {

    private static final String TAG = "NativeADDemoActivity2";

    RecyclerView recyclerView;
    XAdapter adapter;

    private static final int TYPE_ITEM = 0;
    private static final int TYPE_AD = 1;

    private LinkedList<Object> data = new LinkedList<>();

    private List<APNative> adList = new ArrayList<>();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.native_demo2);

        for (int i = 0; i < 50; i++) {
            data.add("normal item");
        }

        setComponents();
        loadNativeAds();
    }

    private void loadNativeAds() {

        for (int i = 0; i < 5; i++) {
            final int finalI = i;
            APNative apNative = new APNative(this, "XrGovLye", new APNativeADListener() {
                @Override
                public void success(APBaseAD apBaseAD, String s) {
                    data.add(finalI * 2, apBaseAD);
                    adList.add((APNative) apBaseAD);

                    adapter.notifyDataSetChanged();
                    Log.i(TAG, "success: index:" + finalI * 2);
                }

                @Override
                public void fail(APBaseAD apBaseAD, String s, String s1) {
                    Log.i(TAG, "fail: index:" + finalI * 2 + ",reason:" + s1);
                }

                @Override
                public void close(APBaseAD apBaseAD, String s) {

                }

                @Override
                public void click(APBaseAD apBaseAD, String s) {
                    Log.i(TAG, "click: index:" + finalI * 2);
                }
            });
            apNative.setPreferImageSize(1080, 320);
            apNative.loadNative();
        }
    }


    @Override
    protected void onResume() {
        super.onResume();
        for (APNative ad : adList) {
            ad.onResume();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        for (APNative ad : adList) {
            ad.onPause();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        for (APNative ad : adList) {
            ad.onDestroy();
        }
    }

    private void setComponents() {
        recyclerView = findViewById(R.id.recyclerView);
        adapter = new XAdapter();
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);
    }


    class XAdapter extends RecyclerView.Adapter {

        @Override
        public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = null;
            if (viewType == TYPE_AD) {
                view = LayoutInflater.from(getApplicationContext()).inflate(R.layout.ad_item, parent, false);
                ADViewHolder adViewHolder = new ADViewHolder(view);
                return adViewHolder;
            } else {
                view = LayoutInflater.from(getApplicationContext()).inflate(R.layout.news_feed_item, parent, false);
                ItemViewHolder itemViewHolder = new ItemViewHolder(view);
                return itemViewHolder;
            }
        }

        @Override
        public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
            if (getItemViewType(position) == TYPE_ITEM) {

            } else {
                APNative apNative = (APNative) data.get(position);
                ADViewHolder adViewHolder = (ADViewHolder) holder;

                adViewHolder.adContainerView.removeAllViews();
                adViewHolder.adContainerView.addView(apNative.getExposureView(adViewHolder.adContainerView, APNative.MATCH_PARENT), new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));


                adViewHolder.descView.setText(apNative.getDesc());

                apNative.show();
            }
        }

        @Override
        public int getItemViewType(int position) {
            if (data.get(position) instanceof String) {
                return TYPE_ITEM;
            }
            return TYPE_AD;
        }

        @Override
        public int getItemCount() {
            return data.size();
        }
    }


    class ItemViewHolder extends RecyclerView.ViewHolder {

        public ItemViewHolder(View itemView) {
            super(itemView);
        }
    }

    class ADViewHolder extends RecyclerView.ViewHolder {

        TextView descView;

        LinearLayout adContainerView;


        public ADViewHolder(View itemView) {
            super(itemView);

            descView = itemView.findViewById(R.id.desc);
            adContainerView = itemView.findViewById(R.id.self_render_container);
        }
    }


}
