<%@ include file="/WEB-INF/views/includes.jsp"%>
<div class="table">
	<table>
		<tr>
			<th>Username</th>
			<th>Admin</th>
			<th>Enabled</th>
		</tr>
		<c:forEach items="${userList}" var="item">
			<tr>
				<td>${item.userName}</td>
				<td><input type="checkbox" name="admin"
					id="${item.userName}_admin" value="${item.admin}"
					${item.admin=="true" ? 'checked' : '' }></td>
				<td><input type="checkbox" name="enabled"
					id="${item.userName}_enabled" value="${item.enabled}"
					${item.enabled=="true" ? 'checked' : '' }></td>
			</tr>
		</c:forEach>
	</table>
</div>

<div class="form">
	<c:url value="/admin/create" var="action" />
	<form:form method="post" action="${action}" modelAttribute="user">
		<table>
			<tr>
				<td><form:label path="userName">Name:</form:label></td>
				<td><form:input path="userName" /></td>
			</tr>
			<tr>
				<td><form:label path="password">Password:</form:label></td>
				<td><form:password path="password" /></td>
			</tr>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<tr>
					<td><form:label path="admin">Admin</form:label></td>
					<td><form:radiobutton path="admin" value="true" />Yes <form:radiobutton
							path="admin" value="false" />No</td>
				</tr>
			</sec:authorize>
			<tr>
				<td colspan="2"><form:button value="submit">Save</form:button></td>
			</tr>
		</table>
	</form:form>
</div>