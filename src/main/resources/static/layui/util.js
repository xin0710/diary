/*layUI扩展方法，方便开发偷懒用*/

function err(msg){
	layer.msg(msg,{icon:2});
}


/*其他自定义方法*/
function delayer(){

	this.time = 1000;
	this.action = null;
	var $this = this;
	this.run = function(param1){
		if(this.action) {
			setTimeout(function(param1){
				$this.action(param1);
			},this.time);
		}
	}
}

const  myStorage  =  {
	        //存储
	        set(key,  value)  {
	                localStorage.setItem(key,  JSON.stringify(value));
	        },
	        //取出数据
	        get(key)  {
	                try  {
	                        const  value  =  localStorage.getItem(key);
	                        if  (value  ===  null  ||  value  ===  undefined  ||  value  ===  "")  {
	                                return  null;
	                        }
	                        return  JSON.parse(localStorage.getItem(key));
				 }  catch  (err)  {
	                        return  null
	                }
	        },
	        //  删除数据
	        remove(key)  {
	                localStorage.removeItem(key);
	        }
	}

//通用文件上传
function openUploadWin(){
	//页面层
	layer.open({
	  type: 2,
	  title: '作品上传',
	  skin: 'layui-layer-rim', //加上边框
	  shade: false,
	  area: ['420px', '240px'], //宽高
	  content: base + "/upload"
	});
}
//回填图片地址
function setImgUrl(id,url){
	$('#' + id).val(url);
}

//预览图片
// function preview(imgUrl){
// 	layer.open({
// 		  type: 2,
// 		  title: '作品上传',
// 		  skin: 'layui-layer-rim', //加上边框
// 		  shade: false,
// 		  shadeClose: true, //开启遮罩关闭
// 		  maxmin: true, //开启最大化最小化按钮
// 		  area: ['520px', '450px'], //宽高
// 		  content: base + "/upload/" + imgUrl
// 		});
// }

var pathnames = window.location.pathname.split('/');
var pathName = pathnames[pathnames.length - 1];

layui.use(['jquery', 'layer'], function(){
  window.$ = layui.$
  ,layer = layui.layer;
  $(function(){
	//首页菜单选中效果
	if(pathName){
		$('#' + pathName).addClass('layui-this').siblings().removeClass('layui-this');
	}

	//加载当前用户的信息
	$.post(base + "/user/getUserInfo.do",{},function(data){

    	if(data.code != '0000'){
    		//err(data.message);
    		return;
    	}

    	$('#notLogin').hide();
    	$('#logined').show();
    	$('#welcome').html('欢迎您，' + data.data.name);

	});

	//加载当前用户拥有的操作权限
	$.post(base + "/user/getPermissions.do",{},function(data){

    	if(data.code != '0000'){
    		//err(data.message);
    		return;
    	}

    	myStorage.set("Permissions",data.data);

    	if(data.data.indexOf('submit') > -1){
    		$('#submitWork').show();
    	}
    	if(data.data.indexOf('audit') > -1){
    		$('#auditlist').show();
    	}
    	if(data.data.indexOf('notify') > -1){
    		$('#notify').show();
    	}



    	return false;

    },'json');
  });




});

function utf82str(str) {
    var out, i, len, c;
    out = "";
    len = str.length;
    for (i = 0; i < len; i++) {
        c = str.charCodeAt(i);
        if ((c >= 0x0001) && (c <= 0x007F)) {
            out += str.charAt(i);
        } else if (c > 0x07FF) {
            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
            out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
        } else {
            out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
        }
    }
    return out;
}

