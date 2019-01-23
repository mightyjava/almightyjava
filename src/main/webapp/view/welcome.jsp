<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="shortcut icon" href="https://ignite.apache.org/images/java.png">
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
		<link rel="stylesheet" href="${path}/webjars/bootstrap/4.1.3/css/bootstrap.min.css">
		<link rel="stylesheet" href="${path}/webjars/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="${path}/css/common.css">
		<title><spring:message code="title.welcome.page"/></title>
	</head>
	<body>
		<jsp:directive.include file="menu.jsp" />
	    <div id="container" class="container-class">
    		<div class="row inner-jsp margin-20"></div>
	    </div>
	    <div class="navbar navbar-expand-lg bg-dark navbar-dark fixed-bottom">
   			<div class="col-md-12 navbar-text text-center">
   				<label class="margin-11pt">© <spring:message code="label.footer.copyright"/></label>
				<div class="btn-group dropup float-right">
				  	<button type="button" class="btn btn-sm bg-dark btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    		<i class="fa fa-language fa-lg"></i> Change Language
				  	</button>
				  	<div class="dropdown-menu">
					    <a class="dropdown-item text-dark" href="?lang=fr">
					    	<img class="img-custom" src="https://lipis.github.io/flag-icon-css/flags/4x3/fr.svg"> French</a>
					    <div class="dropdown-divider"></div>
					    <a class="dropdown-item text-dark" href="?lang=en">
					    	<img class="img-custom" src="https://lipis.github.io/flag-icon-css/flags/4x3/us.svg"> English</a>
					</div>
				</div>
    		</div>
	    </div>
	    <script type="text/javascript" src="${path}/webjars/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript" src="${path}/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${path}/js/jquery.boot.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
		<script type="text/javascript">
			window.onload=function(){
				console.log($("#homeList") != null || $("#homeList") != "");
			 	if($("#homeList") != null || $("#homeList") != ""){ 
			 		setTimeout(function () {
			 			$("#homeList").trigger("click");
			 		}, 500);
			 	}
			}
		</script>
	</body>
</html>