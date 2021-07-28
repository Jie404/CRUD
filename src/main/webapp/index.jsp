<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<head>
    <title>列表显示</title>
</head>
<script src="${APP_PATH}/static/js/jQuery-1.12.4.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css"/>

<script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</html>


<html>
<body>
<%-- 员工添加 --%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <%-- 表单 --%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="email" name="empName" class="form-control" id="empName" placeholder="empName">
                            <span id="helpBlock1" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email" placeholder="Email">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" checked id="gender1" value="男"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2" value="女"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="add_dept" name="deptId">
                            </select>
                        </div>
                    </div>


                </form>
                <%-- 表单结束 --%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_add">新增</button>
            </div>
        </div>
    </div>
</div>

<%--修改列表--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <%-- 表单 --%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="email" readonly name="empName" class="form-control" id="empName_update"  placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_update" placeholder="Email">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update" checked  value="男"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update"  value="女"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="update_dept" name="deptId"></select>
                        </div>
                    </div>


                </form>
                <%-- 表单结束 --%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">更新</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%-- 标题 --%>
    <div class="row">
        <div class="col-xs-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%-- 按钮 --%>
    <div class="row">
        <div class="col-xs-4 col-xs-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_all_btn">删除</button>
        </div>
    </div>

    <%-- 显示数据 --%>
    <div class="row">
        <div class="col-xs-12">
            <table class="table tab-condensed" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox"  id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <%-- 显示分页信息 --%>
    <div class="row">
        <%-- 分页文字信息 --%>
        <div class="col-xs-6" id="page_info_area"></div>

        <%-- 分页条信息 --%>
        <div class="col-xs-6" id="page_nav_area"></div>
    </div>

</div>
<script>
    var totalRecord,currentPage;

    $(function () {
        to_page(1);
    })

    function to_page(pageNum) {
        $.get("emps/all", {
            pageNum: pageNum
        }, function (result) {
            // console.log(result);
            //1、解析显示员工数据
            build_emps_table(result);
            //2、解析显示分页信息
            build_page_info(result)
            //3、解析显示分页条数据
            build_page_nav(result)


        }, "json")
    }

    function build_emps_table(result) {
        //清空
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm btn-edit")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑")
            editBtn.attr("edit_va",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm btn-del")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除")
            delBtn.attr("del_va",item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);


            //

            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptName).append(btnTd)
                .appendTo("#emps_table tbody");

        })
    }

    function build_page_info(result) {
        $("#page_info_area").empty();

        var pageInfo = result.extend.pageInfo;
        $("#page_info_area").append("当前第" + pageInfo.pageNum + "页，总" + pageInfo.pages + "页，总" + pageInfo.total + "条记录")

        totalRecord = pageInfo.pages;
        currentPage = pageInfo.pageNum;
    }


    function build_page_nav(result) {
        $("#page_nav_area").empty();

        //page_nav_area

        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1)
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.prePage)
            })
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        })

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.nextPage)
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages)
            })
        }

        ul.append(nextPageLi);
        ul.append(lastPageLi);

        var pageNav = $("<nav></nav>").attr("aria-label", "Page navigation").append(ul).appendTo("#page_nav_area");

    }


//==================增加功能=======================

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清楚表单数据（表单重置）
        reset_form($("#empAddModal form"));
        //发送ajax请求，查出所有部门信息，显示所有部门信息
        getDepts($("#empAddModal select"));
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });


    //清空模态框的内容
    function reset_form(ele){
        ele[0].reset();
        ele.find("*").removeClass("has-error has-success");
        ele.find(".help-block").text("");
    }


    //获取部门信息
    function getDepts(ele) {
        ele.empty();
        $.get("${APP_PATH}/depts/all", {}, function (result) {
            var depts = result.extend.depts;
            $.each(depts, function (index, item) {
                ele.append($("<option></option>").attr("value", item.deptId).append(item.deptName))
            })
        }, "json");
    }

    //==点击保存==
    $("#emp_add").click(function () {
        //1、先对提交数据进行校验
        if (!validata_add_form()) {
            return false;
        }

        //2、检验用户名是否重复
        if($(this).attr("ajax-va") == "fail"){
            return false;
        }
        //3、发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emps/all",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // 关闭模态框
                $('#empAddModal').modal('hide');

                //来到最后一页
                to_page(totalRecord + 1);

            }
        })
    })

    //检查用户名是否已经存在
    $("#empName").change(function () {
        //发送用户名是否可用
        var empName = this.value;
        $.get("${APP_PATH}/emps/check", {
            "empName": empName
        }, function (result) {
            if (result.code == 100) {
                show_validata_msg($("#empName"), "success", "用户名可用用")
                $("#emp_add").attr("ajax-va","success");
            } else {
                show_validata_msg($("#empName"), "fail", result.extend.msg);
                $("#emp_add").attr("ajax-va","fail");
            }
        }, "json")
    })

    //校验用户名
    function validata_add_form() {
        //正则表达式
        //1、校验用户名
        var empName = $("#empName").val();
        // var regName = /(^[a-z0-9_-]{3,16}$) | (^[\u2E80-\u9FFF]{2,5}$)/;
        var regName = /^[a-z0-9_-]{3,16}$/;
        if (!regName.test(empName)) {
            show_validata_msg($("#empName"), "fail", "用户名可以是3-16位英文和数字组合而成");
            return false;
        } else {
            show_validata_msg($("#empName"), "success", "");
        }
        var email = $("#email").val();

        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})/;
        //2、校验邮箱

        if (!regEmail.test(email)) {
            show_validata_msg($("#email"), "fail", "请输入正确电子邮件");
            return false;
        } else {
            show_validata_msg($("#email"), "success", "");
        }
        return true;
    }

    //显示校验
    function show_validata_msg(ele, status, msg) {
        ele.parent().removeClass("has-success has-error");
        ele.next("span").text("");

        if (status == "success") {
            ele.parent().addClass("has-success");
            ele.next("span").text(msg);
        } else {
            ele.parent().addClass("has-error");
            ele.next("span").text(msg);
        }
    }

    //============ 修改功能 ===============
    //点击编辑按钮弹出模态框
    $(document).on("click",".btn-edit",function () {

        //清楚表单数据（表单重置）
        reset_form($("#empUpdateModal form"));

        //发送ajax请求，查出所有部门信息，显示所有部门信息
        getDepts($("#update_dept"));

        //根据ID查出员工信息
        getEmp($(this).attr("edit_va"));

        //把编辑ID值传进更新按钮
        $("#emp_update").attr("edit-id",$(this).attr("edit_va"));

        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    })

    function getEmp(id){
        $.get("${APP_PATH}/emps/all/"+id,{},function (result) {
            var emp = result.extend.emp;
            $("#empName_update").val(emp.empName);
            $("#email_update").val(emp.email);
            console.log(emp.gender)
            /*if(emp.gender == "男"){
                $("#gender2_update").remove("checked");
                $("#gender1_update").attr("checked","checked")
            }else{
                $("#gender2_update").remove("checked");
                $("#gender1_update").attr("checked","checked")
            }*/
            $("#empUpdateModal input[name = gender]").val([emp.gender]);
            $("#update_dept").val([emp.deptId]);
        },"json");
    }

    $("#emp_update").click(function () {
        //验证信息
        //1、校验邮箱
        var email = $("#email_update").val();

        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})/;

        if (!regEmail.test(email)) {
            show_validata_msg($("#email_update"), "fail", "请输入正确电子邮件");
            return false;
        } else {
            show_validata_msg($("#email_update"), "success", "");
        }

        //2、发送ajax请求报讯保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emps/all/"+$(this).attr("edit-id"),
            // type:"post",
            // data: $("#empUpdateModal form").serialize()+"&_method=PUT",
            type:"put",
            data: $("#empUpdateModal form").serialize(),
            success :function (result) {
                // alert(result.msg)
                //1、关闭模态框
                $("#empUpdateModal").modal("hide");
                //2、回到本页面
                to_page(currentPage)
            }

        })

        /*$.put("",{},function () {

        },"json")*/
    })

    //=========删除==========
    $(document).on("click",".btn-del",function () {

        var empName = $(this).parents("tr").find("td:eq(2)").text()
        var id = $(this).attr("del_va");
        if(confirm("是否要删除["+empName+"]")){
            $.ajax({
                url:"${APP_PATH}/emps/all/"+id,
                type:"delete",
                dataType:"json",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    })
//===========批量删除==============
    //完成全选  不选功能
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"))
    })

    //部分选择
    $(document).on("click",".check_item",function (){
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    })

    //点击全部删除，就批量删除
    $("#emp_del_all_btn").click(function () {

        var empNameStr = "";
        var idStr = "";

        $.each($(".check_item:checked"),function (index,item) {

            empNameStr += $(this).parents("tr").find("td:eq(2)").html()+",";
            idStr += $(this).parents("tr").find("td:eq(1)").html()+"-";
        })
        empNameStr = empNameStr.substring(0,empNameStr.length-1);
        idStr = idStr.substring(0,idStr.length-1);
        if(confirm("确定要删除["+empNameStr+"]吗？")){
            $.ajax({
                url : "${APP_PATH}/emps/all/"+idStr,
                type:"delete",
                success:function (result) {
                    alert(result.msg);
                    $("#check_all").prop("checked",false)
                    to_page(currentPage);
                }
            })
        }
    })

</script>
</body>
