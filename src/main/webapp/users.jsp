<%@page import="com.bmdb.persist.DBContext"%>
<%@page import="com.bmdb.persist.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    User user = (User)request.getSession().getAttribute("username");
    if (user == null || !user.getUserName().equals("admin"))
    {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User management</title>
<link rel="stylesheet" type="text/css" href="style/tables.css" />
<script type="text/javascript">
    function removee(idm) {
        post("deleteuser?id="+idm, null);
        window.setTimeout(function(){location.reload;}, 2000);
    }
</script>
</head>
<body>
    <jsp:include page="navigation.jsp"></jsp:include>
    <h3>Users</h3>
    <div>
        <table>
            <tr>
                <th>ID</th>
                <th>User name</th>
                <th>Name</th>
                <th>E-mail</th>
                <th colspan="2">Options</th>
            </tr>
            <%
                for (User u : DBContext.get().getUsersService().getUsers())
                {
            %>
            <tr>
                <td><%=u.getId()%></td>
                <td><%=u.getUserName()%></td>
                <td><%=u.getName()%></td>
                <td><%=u.getEmail()%></td>
                <td><a href="reviews.jsp?userId=<%=u.getUserName()%>"
                    title="Reviews by user <%=u.getUserName()%>">Reviews</a></td>
                <td><% if(!u.getUserName().equals("admin")) {%>
                <a href="" onclick="removee(<%=u.getId()%>)">Delete</a>
                <%}%></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>