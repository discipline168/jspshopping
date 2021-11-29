package com.discipline.java.utils;

import com.alibaba.druid.support.logging.Log;
import com.discipline.java.bean.User;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.time.DateFormatUtils;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.text.MessageFormat;
import java.util.Date;
import java.util.Properties;

public class EmailUtils {
    public static void sendMessage(User user) {

        Properties props = new Properties();
        props.setProperty("mail.transport.protocol","smtp");
        props.setProperty("mail.smtp.host","smtp.qq.com");
        props.setProperty("mail.smtp.auth","true");

        props.setProperty("mail.smtp.timeout", "200000");//设置链接超时
        props.setProperty("mail.smtp.port", Integer.toString(25));//设置端口
        props.setProperty("mail.smtp.socketFactory.port", Integer.toString(465));//设置ssl端口 (不开SLL部署至linux会报错)
        props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");



        Session session = Session.getDefaultInstance(props);
        session.setDebug(true);
        try {

            MimeMessage message = createMessage(session,user);

            Transport transport = session.getTransport();
            //设置邮件用户名和授权码
            transport.connect("你的邮箱地址","你的授权码");

            transport.sendMessage(message,message.getAllRecipients());
            transport.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("邮件发送超时!");
        }
    }


    public static MimeMessage createMessage(Session session, User user) throws Exception {

        MimeMessage message = new MimeMessage(session);

        message.setFrom(new InternetAddress("你的邮箱地址","disciplinepro","UTF-8"));

        message.setRecipients(Message.RecipientType.TO,user.getEmail());

        message.setSubject("激活您的电子邮件地址");

        //本地测试
/*        String url = "http://127.0.0.1:8080/userservlet?method=active&email=" +
                Base64Utils.encode(user.getEmail()) + "&code=" + Base64Utils.encode(user.getCode());

        message.setContent(buildContent(user.getEmail(),
                "localhost:8080/userservlet?method=active&email="
                        +Base64Utils.encode(user.getEmail())+"&code="
                        +Base64Utils.encode(user.getCode())),"text/html;charset=UTF-8");*/

        //云端部署
        String url = "http://discipline168.cn/jspshop/userservlet?method=active&email=" +
                Base64Utils.encode(user.getEmail()) + "&code=" + Base64Utils.encode(user.getCode());
        //System.out.println(url);

        message.setContent(buildContent(user.getEmail(),
                "http://discipline168.cn/jspshop/userservlet?method=active&email="
                        +Base64Utils.encode(user.getEmail())+"&code="
                        +Base64Utils.encode(user.getCode())),"text/html;charset=UTF-8");



        message.setSentDate(new Date());

        message.saveChanges();

        return message;
    }


    public static String buildContent(String email,String activehHref) throws IOException {

        //加载邮件html模板
        //本地(绝对路径 E:\Projects\java-projects\jspshopping 为项目所在路径)
        InputStream inputStream = new FileInputStream("E:\\Projects\\java-projects\\jspshopping\\src\\HtmlEmailTemplate.html");

        //linux
        //InputStream inputStream = new FileInputStream("../webapps/jspshop/WEB-INF/classes/HtmlEmailTemplate.html");

        System.out.println(inputStream);
        BufferedReader fileReader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
        StringBuffer buffer = new StringBuffer();
        String line = "";
        try {
            while ((line = fileReader.readLine()) != null) {
                buffer.append(line);
            }
        } catch (Exception e) {
            System.out.println("读取邮件html模板文件失败");
        } finally {
            inputStream.close();
            fileReader.close();
        }

        //填充html模板中的参数
        String htmlText = MessageFormat.format(buffer.toString(), email, "<a href='"+activehHref+"'>"+activehHref+"</a>");

        return htmlText;
    }




}
