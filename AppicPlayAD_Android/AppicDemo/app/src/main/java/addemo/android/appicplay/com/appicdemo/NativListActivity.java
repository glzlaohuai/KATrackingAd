package addemo.android.appicplay.com.appicdemo;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.androidquery.AQuery;
import com.appicplay.sdk.ad.APBaseAD;
import com.appicplay.sdk.ad.listener.APNativeADListener;
import com.appicplay.sdk.ad.nativ.APNative;

import java.util.ArrayList;
import java.util.List;

public class NativListActivity extends Activity {

    private static final String TAG = "NativListActivity";


    private ListView listView;

    private List<APBaseAD> nativeList = new ArrayList<>();

    private XAdapter adapter = new XAdapter();


    private int adViewWidth = 0;

    private View.OnLayoutChangeListener layoutChangeListener = new View.OnLayoutChangeListener() {
        @Override
        public void onLayoutChange(View view, int i, int i1, int i2, int i3, int i4, int i5, int i6, int i7) {
            int width = view.getWidth();

            Log.i(TAG, "onLayoutChange: 获取到宽度：" + width);

            if (width > 0) {
                adViewWidth = width;
                view.removeOnLayoutChangeListener(this);
                adapter.notifyDataSetChanged();
            }
        }
    };

    private boolean isLayoutChangeListenerAdded = false;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.nativ_list);

        listView = findViewById(R.id.listView);
        loadNativeAD();

        listView.setAdapter(adapter);
    }


    private void loadNativeAD() {

        for (int i = 0; i < 2; i++) {
            final int finalI = i;
            final APNative apNative = new APNative(this, "PJyeKVAv", new APNativeADListener() {
                @Override
                public void success(APBaseAD ad, String slotID) {
                    nativeList.add(ad);
                    adapter.notifyDataSetChanged();

                    Log.i(TAG, "success: " + ((APNative) ad).getTitle());
                }

                @Override
                public void fail(APBaseAD ad, String slotID, String errorMsg) {
                    Log.i(TAG, "fail: " + finalI);
                }

                @Override
                public void close(APBaseAD ad, String slotID) {

                }

                @Override
                public void click(APBaseAD ad, String slotID) {

                }

                @Override
                public void gotoDeeplink(APBaseAD apBaseAD) {

                }

                @Override
                public void gotoDownload(APBaseAD apBaseAD) {

                }
            });
            apNative.setPreferImageSize(640, 960);
            apNative.loadNative();
        }
    }

    class ItemValue {

        private String name;
        private int age;
        private String image;
        private String desc;


        public ItemValue(String name, int age, String image, String desc) {
            this.name = name;
            this.age = age;
            this.image = image;
            this.desc = desc;
        }


        public String getName() {
            return name;
        }

        public int getAge() {
            return age;
        }

        public String getImage() {
            return image;
        }

        public String getDesc() {
            return desc;
        }
    }


    class XViewHolder {


        TextView nameView;
        TextView descView;

        ImageView imgView;

    }


    class ADViewHolder {

        TextView titleView;
        TextView descView;

        FrameLayout primaryViewContainer;

        TextView actView;

    }


    class XAdapter extends BaseAdapter {

        private static final int ITEM_AD = 0;
        private static final int ITEM_ITEM = 1;

        AQuery aQuery = new AQuery(NativListActivity.this);

        @Override
        public int getCount() {
            return 200;
        }

        @Override
        public Object getItem(int i) {
            if (getItemViewType(i) == ITEM_AD) {

                //0,20,40
                int adPos = i / 20;

                //有该位置已经加载好的广告
                if (nativeList.size() >= adPos + 1) {
                    return nativeList.get(adPos);
                }

                return null;
            } else {
                return new ItemValue("小明" + Math.random(), (int) (10 + Math.random() * 100), "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536646506553&di=ba7366178edbb8c3bb7b2b6fafde4b9c&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201509%2F26%2F20150926165216_E4P5t.jpeg", "今天天气不错，挺风和日丽的");
            }

        }

        @Override
        public long getItemId(int i) {
            return 0;
        }

        @Override
        public View getView(int i, View view, ViewGroup viewGroup) {

            int viewType = getItemViewType(i);

            if (viewType == ITEM_ITEM) {

                XViewHolder viewHolder;
                if (view != null && view.getTag() != null && view.getTag() instanceof XViewHolder) {
                    viewHolder = (XViewHolder) view.getTag();
                } else {
                    view = getLayoutInflater().inflate(R.layout.item_value, null);
                    viewHolder = new XViewHolder();

                    viewHolder.nameView = view.findViewById(R.id.name_view);
                    viewHolder.descView = view.findViewById(R.id.desc_view);
                    viewHolder.imgView = view.findViewById(R.id.img_view);

                    view.setTag(viewHolder);
                }
                ItemValue itemValue = (ItemValue) getItem(i);

                viewHolder.nameView.setText(itemValue.getName());
                viewHolder.descView.setText(itemValue.getDesc());

                aQuery.id(viewHolder.imgView).image(itemValue.image);

            } else {

                //ad

                final ADViewHolder adViewHolder;

                if (view != null && view.getTag() != null && view.getTag() instanceof ADViewHolder) {
                    adViewHolder = (ADViewHolder) view.getTag();
                } else {
                    view = getLayoutInflater().inflate(R.layout.item_ad, null);


                    adViewHolder = new ADViewHolder();

                    adViewHolder.titleView = view.findViewById(R.id.name_view);
                    adViewHolder.actView = view.findViewById(R.id.act_view);
                    adViewHolder.descView = view.findViewById(R.id.desc_view);
                    adViewHolder.primaryViewContainer = view.findViewById(R.id.primary_view_container);

                    if (!isLayoutChangeListenerAdded) {
                        isLayoutChangeListenerAdded = true;
                        adViewHolder.primaryViewContainer.addOnLayoutChangeListener(layoutChangeListener);
                    }

                    view.setTag(adViewHolder);
                }

                adViewHolder.primaryViewContainer.removeAllViews();

                APNative ad = (APNative) getItem(i);

                if (ad != null) {
                    Log.i(TAG, "getView: 该位置已经有广告加载完成：" + i);
                    adViewHolder.titleView.setText(ad.getTitle());
                    adViewHolder.descView.setText(ad.getDesc());
                    adViewHolder.actView.setText(ad.getActionText());

                    //有获取到实际adContainer的宽度
                    if (adViewWidth > 0) {
                        View exposureView = ad.getExposureView(adViewHolder.primaryViewContainer, adViewWidth);
                        adViewHolder.primaryViewContainer.addView(exposureView);
                    }

                } else {

                    Log.i(TAG, "getView: 该位置还没有广告加载完成" + i);
                    //该位置未有加载成功的广告
                    adViewHolder.titleView.setText("广告加载中...");
                    adViewHolder.descView.setText("加载中...");
                    adViewHolder.actView.setText("加载中");
                }
            }
            return view;
        }


        @Override
        public int getItemViewType(int position) {

            //0,20,40,60,80....的位置是广告
            int value = position % 20;

            if (value == 0) {
                return ITEM_AD;
            } else {
                return ITEM_ITEM;
            }
        }
    }
}
