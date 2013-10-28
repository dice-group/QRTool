<html xmlns="http://www.w3.org/1999/xhtml" xmlns:lang="en" lang="en">
<%@ include file="/WEB-INF/views/includes.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="css/smoothness/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
<link href="css/main.css" rel="stylesheet">
<script src="js/jquery-1.9.0.js"></script>
<script src="js/jquery-ui-1.10.0.custom.js"></script>
</head>
<body unselectable="on">
	<div id="title">
		<h1>Contributers</h1>
	</div>
	<div id="outerContainer">
		<div id="main-content">
			<div class="innerContainer">
				<div>${text}</div>
				<hr />
				<ul>
					<li>Ricardo Usbeck</li>
					<li>Maximilian Speicher</li>
					<li>Michael Röder</li>
					<li>Björn Freiberg</li>
					<li>Benno Mielke</li>
					<li>Didier Cherix</li>
				</ul>
			</div>
		</div>
	</div>
	<div id="footer">
		<a href="<spring:url value="/" htmlEscape="true" />">Home</a> <a
			href=" <spring:url value="/j_spring_security_logout" htmlEscape="true" />">Logout</a>
		<sec:authorize url="/admin">
			<a href="<spring:url value="/admin" htmlEscape="true" />">Admin</a>
		</sec:authorize>
		<a href="<spring:url value="/contributers" htmlEscape="true"/>">Contributers</a>
	</div>
	<script src="js/main.js" type="text/javascript"></script>
</body>
</html>
</body>
</html>