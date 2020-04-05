<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加管理员</title>
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
        <div class="layui-row layui-col-space10">
            <div class="layui-col-md9 layui-col-xs7">
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">管理员ID</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="id" readonly>
                    </div>
                </div>
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">管理员名称</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="name" lay-verify="name" placeholder="请输入管理员名称">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"></label>
                    <div class="layui-input-block">
                        <a class="layui-btn layui-btn-sm" lay-filter="editAdmins" lay-submit>保存</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript" src="/admins/layui/layui.js"></script>
<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form;
        layer = parent.layer === undefined ? layui.layer : top.layer,
            laypage = layui.laypage,
            $ = layui.jquery;
        form.verify({
            name: function (val) {
                if (val == '') {
                    return "管理员名称不能为空";
                }
            }
        });
        form.on("submit(editAdmins)", function (data) {
            //弹出loading
            var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
            $.ajax({
                url: "/admins/edit",
                type: 'post',
                dataType: 'json',
                data: JSON.stringify({
                    name: $("#name").val(),  //管理员名称
                    id: $("#id").val()
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
                top.layer.msg("管理员修改成功！");
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