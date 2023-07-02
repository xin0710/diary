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
        <div id="typelist" class="layui-card dbox" style="border-right: 2px solid #eaeaea;height: 90%;padding: 16px;">
          <a href="${basePath}/diary/blogType/add.html"><button type="button" class="layui-btn layui-btn-parmary">新增</button></a>
          <table class="layui-table">
            <colgroup>
              <col width="50">
              <col width="150">
              <col width="200">
              <col>
            </colgroup>
            <thead>
            <tr>
              <th>ID</th>
              <th>类型名称</th>
              <th>创建日期</th>
              <th>操作</th>
            </tr>
            </thead>
            <tbody>
              <tr v-for="item in listData">
                <td>{{item.id}}</td>
                <td>{{item.typeName}}</td>
                <td>{{item.createDate}}</td>
                <td>
                  <a :href="'${basePath}/diary/blogType/add.html?id='+item.id"><button type="button" class="layui-btn layui-btn-normal layui-btn-sm">修改</button></a>
                  <button @click="del(item.id)" type="button" class="layui-btn layui-btn-danger layui-btn-sm">删除</button>
                </td>
              </tr>

            </tbody>
          </table>


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

  new Vue({
    el:'#typelist',
    data:{
      listData:[]
    },
    methods:{
      getData(){
        var index = layer.load(1); //添加laoding,0-2两种方式
        axios.post('${basePath}/sys-blog-type/selectAll',{}).then(r =>{
          layer.close(index);    //返回数据关闭loading
          if(r.data.code != '0000'){
            layer.msg(r.data.message,{icon:2});
            return;
          }
          console.log(r.data.data);
          this.listData = r.data.data;
        }).catch(error => {
          layer.msg(error.response.status,{icon:2});
          layer.close(index);    //返回数据关闭loading
        })
      },
      del(id){
        if(!confirm('您确定要删除这个类型吗？（此操作无法撤销）')){
          return;
        }
        var index = layer.load(1); //添加laoding,0-2两种方式
        axios.post('${basePath}/sys-blog-type/delete?id=' + id,{}).then(r =>{
          console.log(r)
          layer.close(index);    //返回数据关闭loading
          if(r.data.code != '0000'){
            layer.msg(r.data.message,{icon:2});
            return;
          }
          this.getData(); //删除成功后重新刷新列表
        }).catch(error => {
          layer.msg(error.response.status,{icon:2});
          layer.close(index);    //返回数据关闭loading
        })
      }
    },
    created(){
      this.getData()
    }

  });

</script>
</body>
</html>
