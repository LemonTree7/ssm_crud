<%--
  Created by IntelliJ IDEA.
  User: Lemon
  Date: 2018/8/18
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<h1 align="center">SSM框架管理系统———CRUD</h1>

<body>

<!-- 弹出层修改员工 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <%--<input type="text" name="empName" class="form-control" id="empName_update_input"--%>
                            <%--placeholder="username">--%>
                            <p class="form-control-static" id="empName_update_static">email@example.com</p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="empEmail" class="form-control" id="email_update_input"
                                   placeholder="E-mail">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">

                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender1_update_input" value="M">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="empDeptId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 弹出层新增员工 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="username">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="empEmail" class="form-control" id="email_add_input"
                                   placeholder="E-mail">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">

                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender1_add_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="empDeptId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h3>SSM-CRUD-员工列表</h3>
        </div>
    </div>

    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success" id="btn_add_emp">新增</button>
            <button class="btn btn-danger" id="btn_delete_all">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>#</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所属部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <div class="col-md-6" id="page_info_area">
            <%--当前第  页,总  页,总  记录--%>
        </div>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord;
    var currentPage;
    //点击新增按钮弹出模态框
    $("#btn_add_emp").click(function () {

        $("#empAddModal form")[0].reset();
        //之后要发送一个Ajax请求 拿到部门的所有信息
        getDepts("#empAddModal select");
        //点击按钮弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //查询所有部门信息显示到下拉列表
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/department/list",
            data: "GET",
            success: function (result) {
                //console.log(result);
                //{"code":100,"msg":"处理成功","extend":{"depts":[{"deptId":1,"deptName":"开发部"},
                // {"deptId":2,"deptName":"测试组"},{"deptId":3,"deptName":"前台"},{"deptId":4,"deptName":"需求"},
                // {"deptId":5,"deptName":"娱乐部"},{"deptId":6,"deptName":"应酬部"}]}}
                //显示部门信息在下拉列表中
                //$("#dept_add_select").append("");
                //清空表格
                $("#dept_add_select").empty();
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    function validate_add_form() {
        //1。校验员工姓名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");
        }

        //2.校验邮箱格式
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            /* $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确"); */
            $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
            $("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");
        }
        return true;
    }

    //显示校验提示结果信息
    function show_validate_msg(ele, status, msg) {
        //清楚当前元素状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).parent().next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //发送请求校验数据库是否有这数据
    $("#empName_add_input").blur(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/employee/checkname",
            data: 'empName=' + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", "用户名不可用");
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    //点击保存按钮保存新增员工
    $("#emp_save_btn").click(function () {
        //模态框中填写表单数据交给服务器 进行保存
        //在这之前要进行表单校验
        //1、先对要提交给服务器的数据进行校验
        //注释就是绕过前台校验，
        // if(!validate_add_form()){
        //     return false;
        // };
        //判断之前的ajax用户名是否校验成功
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        //校验成功提交数据
        $.ajax({
            url: "${APP_PATH}/employee/save",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                if (result.code == 100) {
                    //员工保存成功
                    // 1.关闭模态框
                    $("#empAddModal").modal("hide");
                    // 2.来到最后一页显示保存的数据
                    //发送ajax请求显示最后一页数据就行to_page(9999)
                    to_page(totalRecord);
                } else {
                    //显示失败信息
                    //console.log(result);
                    if (undefined != result.extend.errorFields.empEmail) {
                        //显示邮箱的错误信息{"code":200,"msg":"处理失败","extend":{"errorFields":{"empEmail":"邮箱格式不正确"}}}
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.empEmail);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });


    $(function () {
        <%--$.ajax({--%>
        <%--url:"${APP_PATH}/employee/list",--%>
        <%--data:"pn=1",--%>
        <%--type:"GET",--%>
        <%--success:function (result) {--%>
        <%--//console.log(result);--%>
        <%--//1.解析并显示员工数据--%>
        <%--build_emps_table(result);--%>
        <%--//2.解析并显示分页信息--%>
        <%--build_page_info(result);--%>
        <%--//3.解析并显示分页条--%>
        <%--build_page_nav(result);--%>
        <%--}--%>
        <%--});--%>
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/employee/list",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        });
    }

    //1.解析并显示员工数据
    function build_emps_table(result) {
        //清空表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            //<th><input type="checkbox"/></th>
            var empCodeTd = $("<td></td>").append($("<input type='checkbox' class='check_item'/>"));
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append(item.empGender == 'M' ? "男" : "女");
            var empEmailTd = $("<td></td>").append(item.empEmail);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             * <button class="btn btn-success btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
             编辑
             </button>
             * @type {*|jQuery}
             */
            var editBtn = $("<button></button>").addClass("btn btn-success btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工
            editBtn.attr("edit-id", item.empId);
            /**
             *<button class="btn btn-danger btn-sm">
             <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
             删除
             </button>
             * @type {jQuery}
             */
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性，来表示当前员工
            delBtn.attr("del-id", item.empId);
            var btnId = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(empCodeTd).append(empIdTd).append(empNameTd).append(empGenderTd).append(empEmailTd).append(deptNameTd).append(btnId).appendTo("#emps_table tbody");
        });
    }

    //2.解析并显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第 " + result.extend.pageInfo.pageNum + " 页,总 " + result.extend.pageInfo.pages + " 页,总 " + result.extend.pageInfo.total + " 记录");
        totalRecord = result.extend.pageInfo.pages;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //3.解析并显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        //page_nav_area
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        //添加首页和前一页提示
        ul.append(firstPageLi).append(prePageLi);
        //给123遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }

            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        //添加下一页页末页提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入到nav中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //给编辑按钮一个绑定一个事件 点击弹出弹出框empUpdateModal这话id
    //1.可以创建按钮的时候绑定  2.绑定点击live jquery新版没有这个方法 使用on进行替代
    $(document).on("click", ".edit_btn", function () {
        //alert("nihao");
        //1.查询出  员工 部门 信息，
        //查询部门信息放到下拉列表
        getDepts("#empUpdateModal select");
        //查出员工信息
        getEmp($(this).attr("edit-id"));
        //把员工的id传递到模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        })
    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/employee/edit/" + id,
            type: "GET",
            success: function (result) {
                //console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.empEmail);
                $("#empUpdateModal input[name=empGender]").val([empData.empGender]);
                $("#empUpdateModal select").val([empData.empDeptId])
            }
        });
    }

    //修改员工数据
    $("#emp_update_btn").click(function () {
        //验证邮箱
        //1.校验邮箱格式
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            /* $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确"); */
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }

        //2.发送ajax请求，保存数据
        $.ajax({
            url: "${APP_PATH}/employee/save/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                //关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_page(currentPage);
            }
        });
    });

    //单个删除
    $(document).on("click", ".delete_btn", function () {

        //弹出是否删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var ids = $(this).attr("del-id");
        if (confirm("确认删除【" + empName + "】吗?")) {
            //确认，发送ajax请求
            $.ajax({
                url: "${APP_PATH}/employee/delete/" + ids,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //点击check_all后全选
    $("#check_all").click(function () {
        //$(this).prop("checked");
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    //check_item
    $(document).on("click", ".check_item", function () {
        //$("#check_all").prop("checked");
        //判断当前的元素是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //点击全部删除，就批量删除
    $("#btn_delete_all").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组装员工id的字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";

        });
        //去除，
        empNames = empNames.substring(0, empNames.length - 1);
        //去除-
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗?")) {
            //发送ajax请求
            $.ajax({
                url: "${APP_PATH}/employee/delete/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });


</script>
</body>
</html>
