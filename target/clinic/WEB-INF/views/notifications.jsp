<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Notifications</title>
<!-- MDB CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css"
	rel="stylesheet">
<!-- MDB JS -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
</head>

<body>
	<div class="container mt-5">
		<h2 class="text-center">Notifications</h2>
		<ul class="list-group">
			<%
                List<String> notifications = (List<String>) request.getAttribute("notifications");
                if (notifications != null && !notifications.isEmpty()) {
                    for (String notification : notifications) {
                        out.println("<li class=\"list-group-item\">" + notification + "</li>");
                    }
                } else {
                    out.println("<li class=\"list-group-item\">No notifications found.</li>");
                }
            %>

			<a href="DashboardServlet"
				class="btn btn-secondary btn-md" >Back</a>
		</ul>
	</div>
</body>

</html>
