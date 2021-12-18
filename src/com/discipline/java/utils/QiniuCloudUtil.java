package com.discipline.java.utils;

import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import com.qiniu.util.Base64;
import com.qiniu.util.StringMap;
import com.qiniu.util.UrlSafeBase64;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;

import java.io.*;
import java.util.UUID;


public class QiniuCloudUtil {


    // 设置需要操作的账号的AK和SK
    private static final String ACCESS_KEY = "";
    private static final String SECRET_KEY = "";

    // 要上传的空间
    private static final String bucketname = "";

    // 密钥
    private static final Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);

    private static final String DOMAIN = "";

    private static final String style = "imageView2/0/q/100";

    public String getUpToken() {
        return auth.uploadToken(bucketname, null, 3600, new StringMap().put("insertOnly", 1));
    }




    //base64方式上传
    public String put64image(String file64,String length,String key) throws Exception {



        System.out.println("file64: "+file64);
        System.out.println("length(): "+length);

        //华北空间使用 upload-z1.qiniu.com，华南空间使用 upload-z2.qiniu.com，北美空间使用 upload-na0.qiniu.com
        String url = "http://upload-na0.qiniu.com/putb64/" + length + "/key/" + UrlSafeBase64.encodeToString(key);

        RequestBody rb = RequestBody.create(null, file64);
        Request request = new Request.Builder().
                url(url).
                addHeader("Content-Type", "application/octet-stream")
                .addHeader("Authorization", "UpToken " + getUpToken())
                .post(rb).build();
        //System.out.println(request.headers());
        OkHttpClient client = new OkHttpClient();
        okhttp3.Response response = client.newCall(request).execute();
        System.out.println(response);
        //如果不需要添加图片样式，使用以下方式
        //return DOMAIN + key;
        return DOMAIN + key +"?"+ style;

    }



}
