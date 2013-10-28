<html xmlns="http://www.w3.org/1999/xhtml" xmlns:lang="en" lang="en">
<%@ include file="/WEB-INF/views/includes.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="css/smoothness/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
<link href="css/main.css" rel="stylesheet">
<script src="js/jquery-1.9.0.js"></script>
<script src="js/jquery-ui-1.10.0.custom.js"></script>
</head>
<body unselectable="on">
	<div id="title">
		<h1>Tool to annotate Texts</h1>
	</div>
	<div id="outerContainer">
		<form id="searchForm"
			action="${pageContext.request.contextPath}/getData" method="post">
			<input type="hidden" value="${textID}" name="textID" /> <input
				type="hidden" value="${userID}" name="userID" />
			<div id="left-sidebar">
				<div class="subtitle">Text to be annotated</div>
				<div class="innerContainer">
					<div id="sidebar-content" unselectable="off">${textWithMarkups}</div>
				</div>
				<div class="buttonContainer">
					<input type="button" id="newEntity"
						value="Mark selected text as new Entity" />
				</div>
			</div>
			<div id="main-content">
				<div class="subtitle">Entity candidates</div>
				<div class="innerContainer">
					<c:forEach items="${text.labels}" var="label">
						<div id="item${label.textHasLabelId}" class="items">
							<input type="radio"
								id="candidate:${label.textHasLabelId},<%= Candidate.OTHER_ENTITY_CANDIDATE_ID %>"
								class="candidateRadioButton"
								value="${label.textHasLabelId},<%= Candidate.OTHER_ENTITY_CANDIDATE_ID %>"
								name="candidate:${label.textHasLabelId}"></input><label
								for="candidate:${label.textHasLabelId},<%= Candidate.OTHER_ENTITY_CANDIDATE_ID %>">This
								is another Named Entity not listed here:</label>
							<div class="entityDesc">
								<textarea name="${label.textHasLabelId},otherDesc"
									unselectable="off"></textarea>
							</div>
							<hr />
							<input type="radio"
								id="candidate:${label.textHasLabelId},<%= Candidate.NO_ENTITY_CANDIDATE_ID %>"
								class="candidateRadioButton"
								value="${label.textHasLabelId},<%= Candidate.NO_ENTITY_CANDIDATE_ID %>"
								name="candidate:${label.textHasLabelId}" /> <label
								for="candidate:${label.textHasLabelId},<%= Candidate.NO_ENTITY_CANDIDATE_ID %>">This
								is no Named Entity.</label>
							<div class="entityDesc">Click here if you think this is no
								Named Entity.</div>
							<hr />
							<c:forEach items="${label.candidates}" var="candidate"
								varStatus="status">
								<input type="radio" class="candidateRadioButton"
									id="candidate:${label.textHasLabelId},${candidate.id}"
									value="${label.textHasLabelId},${candidate.id}"
									name="candidate:${label.textHasLabelId}"
									${!status.first ? '' : 'checked=checked'} />
								<label for="candidate:${label.textHasLabelId},${candidate.id}">
									<span class="italic">${candidate.url}</span>
								</label>
								<div class="entityDesc selectable" unselectable="off">
							 		<a href="${candidate.description}" style="font-size:9pt" target="_blank">${candidate.description}</a>
								</div>
								<hr />
							</c:forEach>
							<c:if test="${empty label.candidates}">
								<div>The program found no candidates for this label.</div>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</div>
			<div id="right-sidebar">
				<div class="subtitle">Potential entites</div>
				<div class="innerContainer"></div>
				<div class="buttonContainer">
					<input type="submit" id="button" value="Next Text!" />
				</div>
			</div>
		</form>
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