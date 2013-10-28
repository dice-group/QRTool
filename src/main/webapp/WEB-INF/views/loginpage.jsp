<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="css/smoothness/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
<link href="css/main.css" rel="stylesheet">
<script src="js/jquery-1.9.0.js"></script>
<script src="js/jquery-ui-1.10.0.custom.js"></script>
</head>
<body>
	<div id="title">
		<h1>Tool to annotate Texts</h1>
	</div>
	<div id="outerContainer">
		<div id="left-sidebar">
			<div class="subtitle">Login with internal account</div>
			<div class="innerContainer">
				<div id="login-error">${error}</div>
				<form action="j_spring_security_check" method="POST">
					<label for="username">User Name:</label> <input id="username"
						name="j_username" type="text" class="selectable" /> <label
						for="password">Password:</label> <input id="password"
						name="j_password" type="password" class="selectable" /> <input
						type="submit" value="Log In" />
				</form>
			</div>
		</div>
		<div id="main-content">
			<div class="subtitle">Login with Google</div>
			<div class="innerContainer" style="text-align: center;">
				<form action="j_spring_openid_security_check" method="post">
					<input name="openid_identifier" type="hidden"
						value="https://www.google.com/accounts/o8/id" class="selectable" />
					<input type="submit" value="Sign in with Google" />
				</form>
			</div>
		</div>
	</div>
</body>