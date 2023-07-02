<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
  <title>日记本类别管理</title>
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
        <jsp:include page="../common/header.jsp"></jsp:include>
      </div>
      <div class="layui-col-md9">
        <div class="layui-card dbox" style="border-right: 2px solid #eaeaea;height: 90%;padding: 16px;">

          <form class="layui-form layui-form-pane"  style="padding-top: 20px;max-width: 500px;" lay-filter="form">
            <div class="layui-form-item">
              <label class="layui-form-label">日记种类</label>
              <div class="layui-input-block">
                <input type="text" name="typeName" lay-verify="typeName" autocomplete="off" placeholder="请输入日记种类" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <div class="layui-input-block" style="text-align: right;">
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                <button type="submit" class="layui-btn" lay-submit="" lay-filter="saveBtn">立即提交</button>
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

  layui.use(['form', 'layedit', 'laydate'], function() {
    var form = layui.form;
    form.on('submit(saveBtn)', function(data){

      data = {...data.field }//获取form的字段

      var index = layer.load(1); //添加laoding,0-2两种方式

      //如果有id，就把id传过去
      if("${id}"){
        data.id = "${id}";
      }
      axios.post('${basePath}/sys-blog-type/add',data).then(r =>{
        layer.close(index);    //返回数据关闭loading
        if(r.data.code != '0000'){
          layer.msg(r.data.message,{icon:2});
          return;
        }
        layer.msg('类型记录成功!',{icon:1});
        setTimeout(()=>{location.href="${basePath}/diary/blogType.html"},500)
      }).catch(error => {
        layer.msg(error.response.status,{icon:2});
        layer.close(index);    //返回数据关闭loading
      });
      return false;
    });

    form.verify({
      typeName: function(value){
        if(value.length < 1){
          return '类型至少得1个字符啊';
        }
      }

    });

    form.render();

    if("${id}"){
      /**
       * 如果id存在，说明是修改
       */
      let index = layer.load(1); //添加laoding,0-2两种方式
      axios.post('${basePath}/sys-blog-type/get?id=${id}',{}).then(r =>{
        layer.close(index);    //返回数据关闭loading
        if(r.data.code != '0000'){
          layer.msg(r.data.message,{icon:2});
          return;
        }
        //渲染数据
        form.val('form',r.data.data);
      });

    }else{
      //默认今天的日期
      fillDate(form);
    }

  });

</script>
</body>
</html>
