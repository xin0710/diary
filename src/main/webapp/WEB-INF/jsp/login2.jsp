<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>小新-日记本系统</title>
    <script src="${basePath}/layui/layui.all.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${basePath}/layui/css/layui.css" media="all">
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        body{
            min-height: 100vh;
            /* 弹性布局 居中 */
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #94bfb560;
        }
        .container{
            background-color: #222;
            width: 350px;
            height: 550px;
            border-radius: 15px;
            overflow: hidden;
            position: relative;
        }
        .container::after{
            content: "";
            position: absolute;
            /* inset为0，相当于top、left、bottom、right都为0的缩写 */
            inset: 0;
            background: url("${basePath}/images/bg.jpg") no-repeat;
            background-size: 500px;
            background-position: left bottom;
            opacity: 0.8;
        }
        /* 注册区域（登录区域很多样式和注册区域的一样，故而一些统一的样式写在了一起） */
        .register-box{
            width: 70%;
            position: absolute;
            z-index: 1;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            transition: 0.3s ease;
        }
        .register-title,
        .login-title{
            color: #fff;
            font-size: 27px;
            text-align: center;
        }
        .register-title span,
        .login-title span{
            color: rgba(0,0,0,0.4);
            display: none;
        }
        .register-box .input-box,
        .login-box .input-box{
            background-color: #fff;
            border-radius: 15px;
            overflow: hidden;
            margin-top: 50px;
            opacity: 1;
            visibility: visible;
            transition: 0.6s ease;
        }
        .register-box input,
        .login-box input{
            width: 100%;
            height: 30px;
            border: none;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            font-size: 12px;
            padding: 8px 0;
            text-indent: 15px;
            outline: none;
        }
        .register-box input:last-child,
        .login-box input:last-child{
            border-bottom: none;
        }
        .register-box input::placeholder,
        .login-box input::placeholder{
            color: rgba(0,0,0,0.4);
        }
        .register-box button,
        .login-box button{
            width: 100%;
            padding: 15px 45px;
            margin: 15px 0;
            background: rgba(0,0,0,0.4);
            border: none;
            border-radius: 15px;
            color: rgba(255,255,255,0.8);
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            opacity: 1;
            visibility: visible;
            transition: 0.3s ease;
        }
        .register-box button:hover,
        .login-box button:hover{
            background-color: rgba(0,0,0,0.8);
        }
        /* 登录区域 */
        .login-box{
            position: absolute;
            inset: 0;
            top: 20%;
            z-index: 2;
            background-color: #fff;
            transition: 0.3s ease;
        }
        .login-box::before{
            content: "";
            background-color: #fff;
            width: 200%;
            height: 250px;
            border-radius: 50%;
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
        }
        .login-box .center{
            width: 70%;
            position: absolute;
            z-index: 3;
            left: 50%;
            top: 40%;
            transform: translate(-50%,-50%);
        }
        .login-title{
            color: #000;
        }
        .login-box .input-box{
            border: 1px solid rgba(0,0,0,0.1);
        }
        .login-box button{
            background-color: #75a297;
        }
        /* 注册、登录区域收起 */
        .login-box.slide-up{
            top: 90%;
        }
        .login-box.slide-up .center{
            top: 10%;
            transform: translate(-50%,0%);
        }
        .login-box.slide-up .login-title,
        .register-box.slide-up .register-title{
            font-size: 16px;
            cursor: pointer;
        }
        .login-box.slide-up .login-title span,
        .register-box.slide-up .register-title span{
            margin-right: 5px;
            display: inline-block;
        }
        .login-box.slide-up .input-box,
        .login-box.slide-up .button,
        .register-box.slide-up .input-box,
        .register-box.slide-up .button{
            opacity: 0;
            visibility: hidden;
        }
        .register-box.slide-up{
            top: 6%;
            transform: translate(-50%,0%);
        }

        input[readonly] {
            background-color: #fff !important;
        }
    </style>
</head>

<body>
<div class="container" id="app">
    <div class="register-box">
        <h2 class="register-title">
            <span>没有账号，去</span>注册日记本
        </h2>
        <div class="input-box">
            <input type="text" v-model="userName1" placeholder="用户名" autocomplete="off">
            <input type="password" v-model="password1" placeholder="密码" autocomplete="off">
            <input type="password" v-model="password11" placeholder="确认密码" autocomplete="off">
        </div>
        <button @click="reg">注册</button>
    </div>
    <div class="login-box slide-up">
        <div class="center">
            <h2 class="login-title">
                <span>已有账号，去</span>登录日记本
            </h2>
            <div class="input-box">
                <input type="text" v-model="userName2" placeholder="用户名" autocomplete="off">
                <input type="password" v-model="password2" placeholder="密码" autocomplete="off">
            </div>
            <button @click="login">登录</button>
        </div>
    </div>
</div>
<script src="${basePath}/js/vue.js"></script>
<script src="${basePath}/js/axios.min.js"></script>


<script>

    let vue = new Vue({
        el:'#app',
        data: {
            //注册
            userName1:'',
            password1:'',
            password11:'',

            //登录
            userName2:'',
            password2:''
        },

        methods:{
            reg(){
                if(this.password1 != this.password11){
                    layer.msg('两次输入密码不一致',{icon:2});
                    return;
                }
                let data = {
                    userName: this.userName1,
                    password: this.password1
                }

                axios.post('${basePath}/user/register',data).then(r =>{

                    if(r.data.code != '0000'){
                        layer.msg(r.data.message,{icon:2});
                        return;
                    }
                    layer.msg('注册成功!',{icon:1});
                });

            },

            login(){
                let data = {
                    userName: this.userName2,
                    password: this.password2
                }
                axios.post('${basePath}/user/login',data).then(r =>{

                    if(r.data.code != '0000'){
                        layer.msg(r.data.message,{icon:2});
                        return;
                    }
                    layer.msg('登录成功!',{icon:1});
                    //登录成功后，就缓存账号密码
                    localStorage.setItem('userName2',this.userName2);
                    localStorage.setItem('password2',this.password2);
                    setTimeout(()=>{
                        location.href="/";
                    },1000)
                });
            },

            //填充缓存的账号和密码
            fillAccount(){
                let userName2 = localStorage.getItem('userName2');
                let password2 = localStorage.getItem('password2');
                if(userName2){
                    this.userName2 = userName2;
                }
                if(password2){
                    this.password2 = password2;
                }
                if(userName2 && password2){
                    setTimeout(()=>{
                        document.querySelector('.login-title').click();
                    },1000)

                }
            }
        },

        created(){
            this.fillAccount();
        }
    });

    // 获取要操作的元素
    let login_title=document.querySelector('.login-title');
    let register_title=document.querySelector('.register-title');
    let login_box=document.querySelector('.login-box');
    let register_box=document.querySelector('.register-box');

    // 绑定标题点击事件
    login_title.addEventListener('click',()=>{
        // 判断是否收起，收起才可以点击
        if(login_box.classList.contains('slide-up')){
            register_box.classList.add('slide-up');
            login_box.classList.remove('slide-up');
        }
    })
    register_title.addEventListener('click',()=>{
        if(register_box.classList.contains('slide-up')){
            login_box.classList.add('slide-up');
            register_box.classList.remove('slide-up');
        }
    })
</script>
</body>

</html>