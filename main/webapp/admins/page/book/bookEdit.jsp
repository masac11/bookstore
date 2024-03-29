<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改书籍</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="/admins/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/admins/css/public.css" media="all"/>
</head>
<body class="childrenBody">
<form class="layui-form layui-row layui-col-space10">
    <div class="layui-col-md9 layui-col-xs12">
        <div class="layui-form-item magt3">
            <label class="layui-form-label">ID</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="id" readonly>
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">书籍名</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="name" lay-verify="name" placeholder="请输入书籍名称">
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">选择类别</label>
            <div class="layui-input-block">
                <select id="category" name="category" lay-verify="" lay-search>
                    <c:forEach var="list" items="${categoryList}">
                        <c:choose>
                            <c:when test="${selected == list.id}">
                                <option value="${list.id}" selected>${list.name}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${list.id}">${list.name}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">作者</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="author" lay-verify="author" placeholder="请输入作者名称">
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">ISBN</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="isbn" lay-verify="isbn" placeholder="请输入ISBN">
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">出版社</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="publish" lay-verify="publish" placeholder="请输入出版社名称">
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <textarea name="sketch" id="sketch" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">单价</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="price" lay-verify="price" placeholder="请输入单价">
            </div>
        </div>
        <div class="layui-form-item magt3">
            <label class="layui-form-label">发行日期</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="pubdate" placeholder="yyyy-MM-dd">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <a class="layui-btn layui-btn-sm" lay-filter="editBooks" id="save" lay-submit>保存</a>
            </div>
        </div>
</form>
<div class="layui-form-item magt3">
    <label class="layui-form-label">展示图</label>
    <div class="layui-upload">
        <button type="button" class="layui-btn" id="test1">选择图片</button>
        <button type="button" class="layui-btn" id="test2">修改图片</button>
    </div>
</div>
<script type="text/javascript" src="/admins/layui/layui.js"></script>
<script>
    layui.use(['form', 'layer', 'laydate', 'upload'], function () {
        var form = layui.form;
        layer = parent.layer === undefined ? layui.layer : top.layer,
            laypage = layui.laypage,
            $ = layui.jquery;
        var laydate = layui.laydate;
        var upload  = layui.upload;
        form.verify({
            name: function (val) {
                if (val == '') {
                    return "书籍名称不能为空";
                }
            }
        });
        //选完文件后不自动上传
        upload.render({
            elem: '#test1'
            ,url: '/books/editPic' //改成您自己的上传接口
            ,auto: false
            //,multiple: true
            ,bindAction: '#test2'
            ,before: function (obj) {
                this.data = {
                    id: $("#id").val()
                }
            }
            ,done: function(res){
                layer.msg('上传成功');
                console.log(res)
            }
        });
        laydate.render({
            elem: '#pubdate'
        });
        form.on("submit(editBooks)", function (data) {
            //弹出loading
            var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
            $.ajax({
                url: "/books/editInfo",
                type: 'post',
                dataType: 'json',
                data: JSON.stringify({
                    id: $("#id").val(),
                    name: $('#name').val(),
                    categoryId: document.getElementById("category").value,
                    author: $('#author').val(),
                    sketch: $('#sketch').val(),
                    isbn: $('#isbn').val(),
                    publish: $('#publish').val(),
                    pubdate: $('#pubdate').val(),
                    price: $('#price').val()
                }),
                cache: false,
                headers: {
                    'Content-Type': 'application/json'
                },
                success: function (res) {
                },
                error: function (e) {
                }
            });
            setTimeout(function () {
                top.layer.close(index);
                top.layer.msg("书籍修改成功！");
                layer.closeAll("iframe");
                //刷新父页面
                parent.location.reload();
            }, 500);
            return false;
        });
    });
</script>
</body>
</html>