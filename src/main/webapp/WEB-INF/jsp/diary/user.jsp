<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>个人中心</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <script src="${basePath}/layui/layui.all.js" charset="utf-8"></script>
    <script src="${basePath}/js/axios.min.js"></script>
    <script src="${basePath}/js/vue.js"></script>
    <link rel="stylesheet" href="${basePath}/layui/css/layui.css" media="all">
    <style>

    </style>
</head>
<body>

<div class="layui-container">
    <div class="layui-row layui-col-space10">
        <div class="layui-row">
            <div class="layui-col-md12">
                <jsp:include page="../common/header.jsp"></jsp:include>
            </div>
            <div class="layui-col-md9">
                <div class="layui-card dbox" style="border-right: 2px solid #eaeaea;height: 90%;padding: 16px;">
                    <form class="layui-form layui-form-pane"  style="padding-top: 20px;" lay-filter="userInfo">
                        <div class="layui-form-item">
                            <label class="layui-form-label">我的昵称</label>
                            <div class="layui-input-block">
                                <input type="text" name="nickName" lay-verify="nickName" autocomplete="off" placeholder="请输入昵称" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-upload">

                            <div style="margin-left: 0px;margin-bottom: 20px">
                                <div class="layui-upload-list" style="float: left;">
                                    <!-- 图片预览 -->
                                    <img style="width: 150px; height: 150px;" class="layui-upload-img" id="uploaderShow">
                                    <p id="errorText"></p>
                                </div>

                                <div style="width: 150px;margin-top:100px;margin-left:20px;float: left">
                                    <button type="button" style="margin-bottom: 10px;" class="layui-btn" id="uploader">上传图片</button>

                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-block">
                                <input type="radio" name="gender" value="0" title="男" checked>
                                <input type="radio" name="gender" value="1" title="女" >
                                <input type="radio" name="gender" value="2" title="保密" >
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">出生日期</label>
                            <div class="layui-input-block">
                                <input id="birthday" name="birthday" lay-verify="birthday" type="text" class="layui-input" id="test1" placeholder="yyyyMMdd">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">个性签名</label>
                            <div class="layui-input-block">
                                <input type="text" name="signature" lay-verify="signature" autocomplete="off" placeholder="请输入个性签名" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-input-block" style="text-align: right;">
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即更新</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="layui-col-md3" style="">
                <jsp:include page="../common/sider.jsp"></jsp:include>
            </div>



        </div>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</div>

<script>
    layui.use(['form', 'layedit', 'laydate','upload','element','jquery'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,upload = layui.upload
            ,element = layui.element
            ,$ = layui.jquery
            ,laydate = layui.laydate;

        //日期
        laydate.render({
            elem: '#birthday'
        });

        //常规使用 - 普通图片上传
        var uploadInst = upload.render({
            elem: '#uploader'
            //,url: 'https://httpbin.org/post' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            ,url: '${basePath}/upload' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#uploaderShow').attr('src', result); //图片链接（base64）
                });
                console.log('before')
                element.progress('progressBar', '0%'); //进度条复位
                layer.msg('上传中', {icon: 16, time: 1000});
            }
            ,done: function(res){
                console.log(res)
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                //上传成功的一些操作
                //记录上传的图片地址
                window.face = res.data.file;
                $('#errorText').html(''); //置空上传失败的状态
            }
            ,error: function(){
                console.log('error')
                //演示失败状态，并实现重传
                var errorText = $('#errorText');
                errorText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                errorText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }

        });


        //监听提交
        form.on('submit(demo1)', function(data){
            data = {...data.field }
            if(window.face){
                data.face = window.face;
            }
            var index = layer.load(1); //添加laoding,0-2两种方式

            axios.post('${basePath}/user/update',data).then(r =>{
                layer.close(index);    //返回数据关闭loading
                if(r.data.code != '0000'){
                    layer.msg(r.data.message,{icon:2});
                    return;
                }
                layer.msg('个人信息更新成功!',{icon:1});
                setTimeout(()=>{location.href="/diary/user.html"},500)
            });
            return false;
        });

        form.verify({
            nickName: function(value){
                if(value.length < 5){
                    return '昵称至少得5个字符啊！';
                }
            }
            ,birthday: function(value){
                if(value.length < 1){
                    return '请选择出生日期！';
                }
            }
            ,signature: function(value){
                if(value.length < 10){
                    return '请填写个性签名，至少10个字符！';
                }
            }
        });

        form.render();
        form.val('userInfo', {
            nickName: "${user.nickName}",
            gender:"${user.gender}",
            birthday:"${user.birthday}",
            signature:"${user.signature}"
        });

        $('#uploaderShow').attr('src', "${basePath}/upload/${user.face}");

    });


</script>
</body>
</html>
