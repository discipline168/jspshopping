# jspshopping



这是一个模拟在线运动商城的项目 "discipl!ne pro"

使用Servlet+JSP+Druid，遵循MVC模式

演示地址(demo address): http://discipline168.cn/jspshop/


"discipl!ne pro" 是一个JAVAWEB项目，目前已完成功能模块

    商品浏览&详情展示
    用户验证码登入注册、邮箱激活、地址&订单管理、加入/清空购物车
    订单的生成、支付和逾期
    暂无后台管理

下载本项目并使用IDE运行前有以下几点注意事项

    先运行src下的数据库sql文件
    进入src/com/discipline/java/utils/EmailUtils
      对sendMessage方法下‘用户邮箱地址’和‘授权码’（查看邮箱授权码方式自行google，本项目配置为qq邮箱）进行填写以便用户注册后发送邮件激活
      将createMessage方法下激活链接地址改成本地测试的方式，并注释掉云端部署的方式
      对buildContent方法的邮件模板的绝对路径进行配置



