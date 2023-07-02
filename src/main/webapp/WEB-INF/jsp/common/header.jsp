<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<style>
  body{background:url("${basePath}/images/blog3.png") no-repeat;
    background-size: 100% 100% ;
    background-attachment: fixed;}
  .dlist li{line-height: 30px;}
  .dlist li a,.tlist li a {color: #0088cc}
  #pageCode{text-align: center;margin-top: 50px;}
  .nickName {text-align: center;font-size: 16px}
  .signature{text-align: center;color: #666}
  .dbox{height: 90%;}
  .content img {width: 100%}
  .content p ,h1,h2{margin-bottom: 20px;}
  .searchbox {float: right}

  @media screen and (max-width: 999px) {
    .searchbox {float: none !important;width: 100% !important;}
    .dbox {height: auto}
  }

  .footer {height: auto;text-align: center;color: #fff;background: #393D49}
</style>
<ul class="layui-nav" lay-filter="">
  <li class="layui-nav-item"><a href="/" style="font-size: 20px"><i class="layui-icon layui-icon-face-smile" style="font-size: 20px"></i>  小新日记本</a></li>
  <li class="layui-nav-item layui-this"><a href="/"><i class="layui-icon layui-icon-home" style="color: #FFF;"></i>  主页</a></li>
  <li class="layui-nav-item"><a href="${basePath}/diary/add.html"><i class="layui-icon layui-icon-edit" style="color: #FFF;"></i>写日记</a></li>
  <li class="layui-nav-item"><a href="${basePath}/diary/blogType.html"><i class="layui-icon layui-icon-list" style="color: #FFF;"></i>日记分类</a></li>
  <li class="layui-nav-item"><a href="${basePath}/diary/user.html"><i class="layui-icon layui-icon-friends" style="color: #FFF;"></i>个人中心</a></li>
  <div class="searchbox layui-nav-item" style="width: 260px;height: 60px;">
    <form method="post" action="${basePath}/">
      <input style="display: inline-block;width: 60%" type="text" name="kws" required   placeholder="请输入关键字" autocomplete="off" class="layui-input">
      <button style="margin-top: -2px;" class="layui-btn layui-btn-primary"><i class="layui-icon layui-icon-search"></i>搜索</button>
    </form>
  </div>

  <script>


    layui.use(['jquery', 'layer'], function(){
      let $ = layui.$;
      let pathName = window.location.pathname;
      switch (pathName) {
        case "/diary/add.html":
          $('.layui-nav-item').eq(2).addClass("layui-this").siblings().removeClass("layui-this")
              break;
        case "/diary/blogType.html":
          $('.layui-nav-item').eq(3).addClass("layui-this").siblings().removeClass("layui-this")
          break;
        case "/diary/user.html":
          $('.layui-nav-item').eq(4).addClass("layui-this").siblings().removeClass("layui-this")
          break;
      }

      /**
       * 因为header.jsp每个页面都有，所以声明一些通用的状态变量
       */


    });


  </script>

</ul>
