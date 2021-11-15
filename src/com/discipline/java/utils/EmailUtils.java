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
        Session session = Session.getDefaultInstance(props);
        session.setDebug(true);
        try {

            MimeMessage message = createMessage(session,user);

            Transport transport = session.getTransport();
            //设置邮件用户名和授权码
            transport.connect("discipline168@foxmail.com","tjelqbfcgjgsbfjc");

            transport.sendMessage(message,message.getAllRecipients());
            transport.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("邮件发送超时!");
        }
    }


    public static MimeMessage createMessage(Session session, User user) throws Exception {

        MimeMessage message = new MimeMessage(session);

        message.setFrom(new InternetAddress("discipline168@foxmail.com","disciplinepro","UTF-8"));

        message.setRecipients(Message.RecipientType.TO,user.getEmail());

        message.setSubject("激活您的电子邮件地址");

        String url = "http://127.0.0.1:8080/userservlet?method=active&email=" + Base64Utils.encode(user.getEmail()) + "&code=" + Base64Utils.encode(user.getCode());
        System.out.println(url);

        message.setContent(buildContent(user.getEmail(),
                "localhost:8080/userservlet?method=active&email="
                        +Base64Utils.encode(user.getEmail())+"&code="
                        +Base64Utils.encode(user.getCode())),"text/html;charset=UTF-8");

        message.setSentDate(new Date());

        message.saveChanges();

        return message;
    }


    public static String buildContent(String email,String activehHref) throws IOException {

        //加载邮件html模板
        InputStream inputStream = new FileInputStream("E:\\Projects\\java-projects\\jspshopping\\web\\commons\\HtmlEmailTemplate.html");
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
        String htmlText = MessageFormat.format(buffer.toString(), email, "<a href='http://"+activehHref+"'>"+activehHref+"</a>");

        return htmlText;
    }




}
