<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<div id="dlist" class="layui-card dbox" style="border-right: 2px solid #eaeaea;">
  <div class="layui-card-header"><b><i class="layui-icon layui-icon-list" style="color: #000;"></i></b>日记列表</div>
  <div class="layui-card-body">
    <ul class="dlist">
      <li v-for="item in datalist"><a :href="'${basePath}/diary/' + item.id + '.html'">{{item.title}}</a></li>
    </ul>
    {{empty?'该类型还没有日记哦，快去写一篇吧！':''}}
    <div id="pageCode"></div>
  </div>
</div>
<script>

  layui.use('laypage', function(){
    var laypage = layui.laypage;
    window.laypage = laypage; //绑定到windows对象上，方便vue去获取
  });

  var dlist = new Vue({
      el:"#dlist",

      data:{
        datalist:[],
        pageIndex:1,
        size:10,
        total:0
      },

      methods:{
        queryBlogs(){
          axios.post('${basePath}/blog/select?pageIndex='+this.pageIndex+'&size=' + this.size,{
            blogType:'${blogType}',
            date:'${date}',
            kws:'${kws}'
          }).then(r =>{
            if(r.data.code != '0000'){
              layer.msg(r.data.message,{icon:2});
              return;
            }
            this.datalist = r.data.data.records;
            this.total = r.data.data.total;

            laypage.render({
              elem: 'pageCode' //注意，这里的 pageCode 是 ID，不用加 # 号
              ,count: dlist.total //数据总数，从服务端得到
              ,limit:dlist.size
              ,curr:r.data.data.current //必须加，不然死循环
              ,jump: function(obj,first) {
                let curr = obj.curr; //当前页码
                dlist.pageIndex = curr;//更新data的页码
                //console.log(curr)
                if(!first) dlist.queryBlogs();//重新加载
              }
            });


          });
        }
    },

    computed:{
      empty(){
        return this.total == 0
      }
    },

    created(){
      this.queryBlogs();
    }
  });
</script>
