<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>日记本详情页</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <script src="${basePath}/layui/layui.all.js" charset="utf-8"></script>
    <script src="${basePath}/js/vue.js"></script>
    <script src="${basePath}/js/axios.min.js"></script>
    <link rel="stylesheet" href="${basePath}/layui/css/layui.css" media="all">
    <style>
        .title {margin: 20px;text-align: center;}
        .title2{text-align: center;color: #666;}
        .content {text-indent: 2em;margin-top: 50px;}
        .tools{margin-top: 100px;text-align: right;}
    </style>
</head>
<body>
<div id="app" class="layui-container">
    <div class="layui-row layui-col-space10">
        <div class="layui-row">
            <div class="layui-col-md12">
                <jsp:include page="common/header.jsp"></jsp:include>
            </div>
            <div class="layui-col-md9">
                <div class="layui-card dbox" style="border-right: 2px solid #eaeaea;height: auto;padding: 16px;">
                    <h1 class="title">${blog.title}</h1>
                    <div class="title2">发布时间：${blog.createDate} &nbsp;&nbsp;&nbsp; 日志类别：${blog.blogType}</div>
                    <div class="content">${blog.content}</div>
                    <div class="tools">
                        <a href="${basePath}/diary/add.html?id=${blog.id}"><button type="button" class="layui-btn layui-btn-normal">修改</button></a>
                        <button onclick="del()" type="button" class="layui-btn layui-btn-danger">删除</button>
                        <a href="${basePath}/"><button type="button" class="layui-btn layui-btn-warm">返回</button></a>
                    </div>
                </div>


            </div>
            <div class="layui-col-md3" style="">
                <jsp:include page="common/sider.jsp"></jsp:include>
            </div>
            <div style="clear: both;"></div>
            <jsp:include page="common/footer.jsp"></jsp:include>


        </div>
    </div>

</div>



<script>

    function del(){
        if(confirm('您确定要删除这个日记吗？')){
            var index = layer.load(1); //添加laoding,0-2两种方式
            axios.post('${basePath}/blog/delete?id=${id}',{}).then(r =>{
                layer.close(index);    //返回数据关闭loading
                if(r.data.code != '0000'){
                    layer.msg(r.data.message,{icon:2});
                    return;
                }
                layer.msg('日记删除成功!',{icon:1});
                setTimeout(()=>{location.href="/"},500)
            }).catch(error => {
                layer.msg(error.response.status,{icon:2});
                layer.close(index);    //返回数据关闭loading
            })
        }
    }


</script>
</body>
</html>
