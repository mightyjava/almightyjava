<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title><spring:message code="title.login.page"/></title>
		<c:set var="path" value="${pageContext.request.contextPath}"/>
		<link rel="stylesheet" href="${path}/webjars/bootstrap/4.1.3/css/bootstrap.min.css">
		<link rel="stylesheet" href="${path}/webjars/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="${path}/css/style.css">
	</head>
	<body>
		<div class="container col-lg-3 col-lg-offset-4">
			<div class="card">
				<div class="card-header">
					<strong><i class="fa fa-user"></i> <spring:message code="label.login.header"/></strong>
					<a href="${path}/user/register" class="btn btn-outline-secondary btn-sm pull-right">
						<strong><i class="fa fa-user-plus"></i> <spring:message code="label.register.header"/></strong>
					</a>
				</div>
				<form method="POST" action="${path}/user/login" class="form-signin form-horizontal needs-validation" autocomplete="off" novalidate>
					<div class="card-body">
						<c:if test="${error ne null}">
							<div class="alert alert-danger alert-dismissible">
								<button type="button" class="close" data-dismiss="alert">&times;</button>
								<strong>${error}</strong>
							</div>
						</c:if>
						<c:if test="${message ne null}">
							<div class="alert alert-success alert-dismissible">
								<button type="button" class="close" data-dismiss="alert">&times;</button>
								<strong>${message}</strong>
							</div>
						</c:if>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-user"></i>
								</span>
							</div>
							<spring:message code="placeholder.username" var="usernamePlaceholder"/>
							<input type="text" class="form-control" name="username" placeholder="${usernamePlaceholder}" required="true" autocomplete="off"/>
							<div class="valid-feedback">
						 		<spring:message code="label.valid.feedback"/>
						 	</div>
						 	<div class="invalid-feedback">
		          				<spring:message code="placeholder.username"/>
		        			</div>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="fa fa-lock fa-lg"></i>
								</span>
							</div>
							<spring:message code="placeholder.password" var="passwordPlaceholder"/>
							<input type="password" class="form-control" name="password" placeholder="${passwordPlaceholder}" required="true" autocomplete="new-password"/>
							<div class="valid-feedback">
						   		<spring:message code="label.valid.feedback"/>
							</div>
							<div class="invalid-feedback">
		          				<spring:message code="placeholder.password"/>
		        			</div>
						</div>
						<c:if test="${not empty captchaEncode}">
							<div class="input-group mb-3">
								<img alt="captcha" class="img-thumbnail" src="data:image/png;base64,${captchaEncode}"/>
							</div>
						
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text">
										<i class="fa fa-key"></i>
									</span>
								</div>
								<spring:message code="placeholder.captcha" var="captchaPlaceholder"/>
								<input class="form-control" name="captcha" placeholder="${captchaPlaceholder}" required="true"/>
								<div class="valid-feedback">
							   		<spring:message code="label.valid.feedback"/>
								</div>
								<div class="invalid-feedback">
			          				<spring:message code="placeholder.captcha"/>
			        			</div>
							</div>
						</c:if>
						<div class="input-group mb-3" style="margin-bottom: 0px !important;">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<input type="checkbox" name="remember-me" id="remember-me"/>
								</span>
							</div>
							<input type="text" class="form-control" value='<spring:message code="label.remember.me"/>' disabled="disabled">
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</div>
					<div class="card-footer" style="background: #fff;border-color: #f1f5fc;color: #777;">
						<span>
							<button type="submit" class="btn btn-outline-secondary btn-block">
								<i class="fa fa-sign-in"></i> <spring:message code="label.button.login"/>
							</button>
						</span>
					</div>
				</form>
			</div>
		</div>
		<script type="text/javascript" src="${path}/webjars/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript" src="${path}/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	</body>
</html>
<script>
$(function() {
  	window.addEventListener('load', function() {
    	var forms = document.getElementsByClassName('needs-validation');
    	var validation = Array.prototype.filter.call(forms, function(form) {
      		form.addEventListener('submit', function(event) {
        		if (form.checkValidity() === false) {
          			event.preventDefault();
          			event.stopPropagation();
        		}
        		form.classList.add('was-validated');
      		}, false);
    	});
  	}, false);
  	
  	if (($(window).width() < 1024  ) && ($(window).height() < 768)) {
  		$(".container").removeClass("col-lg-3").addClass("col-sm-6");
  	}
});
</script>