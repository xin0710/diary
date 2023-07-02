<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>日记新增</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <script src="${basePath}/layui/layui.all.js" charset="utf-8"></script>
    <script src="${basePath}/js/axios.min.js"></script>
    <script src="${basePath}/js/vue.js"></script>
    <link rel="stylesheet" href="${basePath}/layui/css/layui.css" media="all">

    <!--富文本编辑器wangEditor-->
    <script src="https://cdn.staticfile.org/wangEditor/10.0.13/wangEditor.min.js"></script>

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
                    <form class="layui-form layui-form-pane"  style="padding-top: 20px;" lay-filter="blog">
                        <div class="layui-form-item">
                            <label class="layui-form-label">日记标题</label>
                            <div class="layui-input-block">
                                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
                            </div>
                        </div>


                        <div class="layui-form-item">
                            <label class="layui-form-label">选择分类</label>
                            <div class="layui-input-block">
                                <c:forEach  items="${types}" var="item">
                                    <input type="radio" name="blogType" value="${item.id}" title="${item.typeName}">
                                </c:forEach>

                            </div>
                        </div>



                        <div class="layui-form-item layui-form-text">
                            <div class="layui-input-block">
                                <div id="editor"></div>
<%--                                <textarea name="content" lay-verify="content" id="demo" class="layui-textarea"></textarea>--%>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-input-block" style="text-align: right;">
                                <button type="reset" class="layui-btn layui-btn-primary">重置日记</button>
                                <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
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

    var E = window.wangEditor
    var editor = new E('#editor')
    // 或者 var editor = new E( document.getElementById('editor') )
    // 配置服务器端地址
    // editor.customConfig.uploadImgServer = '/upload'
    //配置指定文件名
    editor.customConfig.uploadFileName = 'file'
    //如果图片不大，可以用base64存储
    //editor.customConfig.uploadImgShowBase64 = true
    editor.create()

    var IDS = document.getElementById(editor.textElemId)

    IDS.addEventListener('paste', (e) => {
        debugger
        var result = []
        var clipboardData = e.clipboardData || e.originalEvent && e.originalEvent.clipboardData || {}
        var items = clipboardData.items

        this.objForEach(items, function (key, value) {
            var type = value.type

            if (/image/i.test(type)) {
                result.push(value.getAsFile())
            }
        })

        upload(result[0], '/editor');

    });

    function upload(blob, url){
        debugger
        let form = new FormData()

        var formData = new FormData();
        formData.append("file",blob);

        $.ajax({
            url:url, /*接口域名地址*/
            type:'post',
            data: formData,
            contentType: false,
            processData: false,
            success:function(res){
                console.log(res);
                editor.cmd.do('insertHtml', '<img src="' + res.data.data[0] + '" style="max-width:100%;"/>')
            }
        })
    }

    function objForEach (obj, fn) {
        var key = void 0,
            result = void 0
        for (key in obj) {
            if (obj.hasOwnProperty(key)) {
                result = fn.call(obj, key, obj[key])
                if (result === false) {
                    break
                }
            }
        }
    }



    layui.use(['form', 'layedit', 'laydate','jquery'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
        window.$ = layui.jquery;
        //日期
        laydate.render({
            elem: '#date'
        });
        laydate.render({
            elem: '#date1'
        });



        //监听提交
        form.on('submit(demo1)', function(data){
            debugger
            data = {...data.field ,...{content: editor.$textElem[0].innerHTML}}

            if(data.content.length < 10){
                layer.msg('内容至少10个字符！',{icon:2});
                return false;
            }
            var index = layer.load(1); //添加laoding,0-2两种方式

            //如果有id，就把id传过去
            if("${id}"){
                data.id = "${id}";
            }
            axios.post('${basePath}/blog/add',data).then(r =>{
                layer.close(index);    //返回数据关闭loading
                if(r.data.code != '0000'){
                    layer.msg(r.data.message,{icon:2});
                    return;
                }
                layer.msg('日记记录成功!',{icon:1});
                setTimeout(()=>{location.href="/"},500)
            });
            return false;
        });

        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            /*,content: function(value){
                return layedit.sync(editIndex);

            }*/
        });

        form.render();

        //加载数据
        if("${id}"){
            /**
             * 如果id存在，说明是修改
             */
            let index = layer.load(1); //添加laoding,0-2两种方式
            axios.post('${basePath}/blog/get?id=${id}',{}).then(r =>{
                layer.close(index);    //返回数据关闭loading
                if(r.data.code != '0000'){
                    layer.msg(r.data.message,{icon:2});
                    return;
                }
                //渲染数据
                form.val('blog',r.data.data);
                editor.$textElem[0].innerHTML = r.data.data.content;
                // layedit.setContent(editIndex,r.data.data.content)
            });

        }else{
            //默认今天的日期
            fillDate(form);
        }


    });


    /*setTimeout(function(){
        $('body').on('paste', '.layui-layedit-iframe', function(e) {
            alert()
            debugger
            var data = e.originalEvent.clipboardData;
            if (data && data.items) {
                for (var i = 0; i < data.items.length; i++) {
                    var item = data.items[i];
                    if (item.type.indexOf("image") != -1) {
                        debugger
                        var file = item.getAsFile();
                        // 处理粘贴的图片文件
                    }
                }
            }
        });
    },1000)*/



    function fillDate(form){
        var today = new Date();

        var year = today.getFullYear();

        //因为月份从0开始，所以当前月份需要加1才能正确显示；

        var month = today.getMonth()+1;

        var day = today.getDate();

        var week = today.getDay();

        var w=new Array(7);   //通过自定义数组将“0”转换为“星期日”；

        w[0]="星期日"

        w[1]="星期一"

        w[2]="星期二"

        w[3]="星期三"

        w[4]="星期四"

        w[5]="星期五"

        w[6]="星期六"

        let dateStr = year+"年"+month+"月"+day+"日 "+w[week];
        form.val('blog',{
            title: '『' + dateStr + '』'
        });
    }
</script>
</body>
</html>
