<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>日记本首页</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <script src="${basePath}/layui/layui.all.js" charset="utf-8"></script>
    <script src="${basePath}/js/vue.js"></script>
    <script src="${basePath}/js/axios.min.js"></script>
    <link rel="stylesheet" href="${basePath}/layui/css/layui.css" media="all">

</head>
<body>
<div id="app" class="layui-container">
    <div class="layui-row layui-col-space10">
        <div class="layui-row">
            <div class="layui-col-md12">
                <jsp:include page="common/header.jsp"></jsp:include>
            </div>
            <div class="layui-col-md9">
                <jsp:include page="diary/list.jsp"></jsp:include>
            </div>
            <div class="layui-col-md3" style="">
                <jsp:include page="common/sider.jsp"></jsp:include>
            </div>



        </div>
    </div>
    <jsp:include page="common/footer.jsp"></jsp:include>
</div>



<script>

</script>
</body>
</html>
