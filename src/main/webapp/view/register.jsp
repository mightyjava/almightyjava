<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
	<head>
		<c:set var="path" value="${pageContext.request.contextPath}"/>
		<title><spring:message code="title.register.page"/></title>
		
		<link rel="stylesheet" href="${path}/webjars/bootstrap/4.1.3/css/bootstrap.min.css">
		<link rel="stylesheet" href="${path}/webjars/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
		<link rel="stylesheet" href="${path}/css/style.css">
	</head>
	<body>
		<div class="container col-lg-3 col-lg-offset-4">
			<div class="card">
				<div class="card-header">
					<i class="fa fa-user-plus"></i> <strong><spring:message code="label.register.header"/></strong>
					<a href="${path}/user/login" class="btn btn-outline-secondary btn-sm pull-right">
						<i class="fa fa-sign-in"></i> <spring:message code="label.login.header"/>
					</a>
				</div>
				<form:form method="POST" action="${path}/user/add" commandName="userForm"  id="submitUserForm">
					<form:hidden path="id"/>
					<form:hidden path="inputSource" value="register"/>
					<div class="card-body">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-user-circle-o"></i>
								</span>
							</div>
							<spring:message code="placeholder.fullname" var="fullnamePlaceholder"/>
							<form:input class="form-control" path="fullName" placeholder="${fullnamePlaceholder}" required="true"/>
						</div>
						
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-envelope"></i>
								</span>
							</div>
							<spring:message code="placeholder.email" var="emailPlaceholder"/>
							<form:input class="form-control" path="email" placeholder="${emailPlaceholder}" required="true"/>
						</div>
						
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-phone-square"></i>
								</span>
							</div>
							<spring:message code="placeholder.mobile" var="mobilePlaceholder"/>
							<form:input class="form-control" path="mobile" placeholder="${mobilePlaceholder}" required="true"/>
						</div>
						
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-user"></i>
								</span>
							</div>
							<spring:message code="placeholder.username" var="usernamePlaceholder"/>
							<form:input class="form-control" path="userName" placeholder="${usernamePlaceholder}" required="true"/>
						</div>
						
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-lock"></i>
								</span>
							</div>
							<spring:message code="placeholder.password" var="passwordPlaceholder"/>
							<form:password class="form-control" path="password" placeholder="${passwordPlaceholder}" required="true"/>
						</div>
						
						<div class="input-group mb-3">
							<img alt="captcha" src="${path}/captcha-servlet">
						</div>
						
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-key"></i>
								</span>
							</div>
							<spring:message code="placeholder.captcha" var="captchaPlaceholder"/>
							<form:input class="form-control" path="captcha" placeholder="${captchaPlaceholder}" required="true"/>
						</div>
					</div>
					<div class="card-footer" style="background: #fff;border-color: #f1f5fc;color: #777;">
						<span>
							<form:button class="btn btn-outline-secondary btn-block">
								<i class="fa fa-user-plus"></i> <spring:message code="label.button.register"/>
							</form:button>
						</span>
					</div>
				</form:form>
			</div>
		</div>
		<script type="text/javascript" src="${path}/webjars/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript" src="${path}/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
		<script type="text/javascript" src="${path}/js/jquery.save.js"></script>
	</body>
</html>