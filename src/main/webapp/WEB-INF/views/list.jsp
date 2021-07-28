<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>列表显示</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<%
    pageContext.setAttribute ("APP_PATH",request.getContextPath());
%>
<script src="${APP_PATH}/static/js/jQuery-1.12.4.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css"/>
<script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

<body>

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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>

        <%-- 显示数据 --%>
        <div class="row">
            <div class="col-xs-12">
                <table class="table tab-container">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <%--<td>${emp.gender=="M"?"男":"女"}</td>--%>
                            <td>${emp.gender}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>

        <%-- 显示分页信息 --%>
        <div class="row">
            <%-- 分页文字信息 --%>
            <div class="col-xs-6">
                <div>当前第${pageInfo.pageNum}页，总${pageInfo.pages}页，总${pageInfo.total}条记录</div>
            </div>

            <%-- 分页条信息 --%>
            <div class="col-xs-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/emps/page?pageNum=1">首页</a></li>
                        <li>
                            <a href="${APP_PATH}/emps/page?pageNum=${pageInfo.prePage}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                       <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                           <c:if test="${pageNum == pageInfo.pageNum}">
                               <li class="active"><a href="#">${pageNum}</a></li>
                           </c:if>
                           <c:if test="${pageNum != pageInfo.pageNum}">
                               <li><a href="${APP_PATH}/emps/page?pageNum=${pageNum}" >${pageNum}</a></li>
                           </c:if>

                       </c:forEach>
                        <li>
                            <a href="${APP_PATH}/emps/page?pageNum=${pageInfo.nextPage}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li><a href="${APP_PATH}/emps/page?pageNum=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>

</body>
</html>
