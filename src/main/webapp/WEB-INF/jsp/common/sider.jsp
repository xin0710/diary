<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<div class="layui-row" id="sider">
  <div class="layui-col-md12">
    <div class="layui-card">
      <div class="layui-card-header"><b><i class="layui-icon layui-icon-friends" style="color: #000;"></i></b>个人信息</div>
      <div class="layui-card-body">
        <div style="text-align: center;">
          <img style="width: 200px;" :src="'${basePath}/upload/'+userInfo.face">
        </div>
        <div class="nickName">{{userInfo.nickName}}</div>
        <div class="signature">个性签名：{{userInfo.signature}}</div>
      </div>
    </div>
  </div>
  <div class="layui-col-md12"  style="margin-top: 2px;">
    <div class="layui-card">
      <div class="layui-card-header"><b><i class="layui-icon layui-icon-list" style="color: #000;"></i></b>日记类别</div>
      <div class="layui-card-body">
        <ul class="tlist">
            <li v-for="item in typelist"> <a :href="'${basePath}/?blogType='+item.id">{{item.typeName}}</a></li>
        </ul>

      </div>
    </div>
  </div>
  <div class="layui-col-md12"  style="margin-top: 2px;">
    <div class="layui-card">
      <div class="layui-card-header"><b><i class="layui-icon layui-icon-date" style="color: #000;"></i></b>按日期</div>
      <div class="layui-card-body">
        <ul class="tlist">
        <c:forEach  items="${statistics}" var="item">
          <li> <a href="${basePath}/?date=${item.date2}">${item.date}(${item.total})</a></li>
        </c:forEach>

        </ul>

      </div>
    </div>
  </div>
</div>
<script>
  new Vue({
    el:'#sider',
    data:{
      typelist:[],
      userInfo : {},
      faceUrl: ''
    },
    methods:{
      getTypelist(){
        var index = layer.load(1); //添加laoding,0-2两种方式
        axios.post('${basePath}/sys-blog-type/selectAll',{}).then(r =>{
          layer.close(index);    //返回数据关闭loading
          if(r.data.code != '0000'){
            layer.msg(r.data.message,{icon:2});
            return;
          }
          this.typelist = r.data.data;
        }).catch(error => {
          layer.msg(error.response.status,{icon:2});
          layer.close(index);    //返回数据关闭loading
        })
      },

      getUser(){

        axios.post('${basePath}/user/get',{}).then(r =>{
          this.userInfo = r.data.data
          this.faceUrl = '${basePath}/upload/'+this.userInfo.face;
        }).catch(error => {
          layer.msg(error.response,{icon:2});
        })

      }

    },
    created(){
      this.getTypelist();
      this.getUser();
    }
  });
</script>
