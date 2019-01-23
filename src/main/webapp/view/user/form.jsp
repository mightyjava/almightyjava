<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<script type="text/javascript" src="${path}/js/jquery.save.js"></script>

<div class="container col-lg-5">

	<div class="card">
	
		<div class="card-header">
			<strong>
				<c:choose>
					<c:when test="${isNew}"><i class="fa fa-plus-circle fa-lg"></i></c:when>
					<c:otherwise><i class="fa fa-edit fa-lg"></i></c:otherwise>
				</c:choose> <spring:message code="label.user"/>
			</strong>
		</div>
		<form:form method="post" class="form-horizontal" action="${path}/user/save" commandName="userForm" id="submitUserForm">
			<form:hidden path="id"/>
			<form:hidden path="inputSource" value="userForm"/>
			<div class="card-body">
			
				<div class="row">
					<label class="col-md-3 control-label"><spring:message code="label.fullname"/> : </label>
					<div class="col-md-5 mb-3">
						<spring:message code="placeholder.fullname" var="fullnamePlaceholder"/>
						<form:input class="form-control" path="fullName" placeholder="${fullnamePlaceholder}" required="true"/>
					</div>
				</div>
				
				<div class="row">	
					<label class="col-md-3 control-label"><spring:message code="label.email"/> : </label>
					<div class="col-md-5 mb-3">	
						<spring:message code="placeholder.email" var="emailPlaceholder"/>
						<form:input class="form-control" path="email" placeholder="${emailPlaceholder}" required="true"/>
					</div>
				</div>
				
				<div class="row">
					<label class="col-md-3 control-label"><spring:message code="label.username"/> : </label>
					<div class="col-md-5 mb-3">
						<spring:message code="placeholder.username" var="usernamePlaceholder"/>
						<form:input class="form-control" path="userName" placeholder="${usernamePlaceholder}" required="true"/>
					</div>
				</div>
				
				<div class="row">	
					<c:choose>
						<c:when test="${isNew}">
							<label class="col-md-3 control-label"><spring:message code="label.password"/> : </label>
							<div class="col-md-5 mb-3">
								<spring:message code="placeholder.password" var="passwordPlaceholder"/>
								<form:password class="form-control" path="password" placeholder="${passwordPlaceholder}" required="true"/>
							</div>
						</c:when>
						<c:otherwise>
							<form:hidden path="userId"/>
							<form:hidden path="password"/>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div class="row">
					<label class="col-md-3 control-label"><spring:message code="label.mobile"/> : </label>
					<div class="col-md-5 mb-3">
						<spring:message code="placeholder.mobile" var="mobilePlaceholder"/>
						<form:input class="form-control" path="mobile" placeholder="${mobilePlaceholder}" required="true"/>
					</div>
				</div>
				<div class="row">
					<c:choose>
						<c:when test="${userRole eq 'admin'}">
							<label class="col-md-3 control-label"><spring:message code="label.role"/> :</label>
							<div class="col-md-5 mb-3">
								<form:select class="form-control" path="roleId">
									<option value=""><spring:message code="dropdown.default.role"/></option>
									<c:forEach items="${roles}" var="role">
										<c:choose>
											<c:when test="${isNew}">
												<form:option value="${role.id}">${role.name}</form:option>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${fn:contains(role.id, userForm.role.id)}">
														<option selected="selected" value="${role.id}">${role.name}</option>
													</c:when>
													<c:otherwise>
														<option value="${role.id}">${role.name}</option>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
							</div>
						</c:when>
						<c:otherwise>
							<form:hidden path="roleId" value="${userForm.role.id}"/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<div class="card-footer text-right">
				<form:button value="Save" class="btn btn-sm btn-primary">
					<i class="fa fa-save"></i>
					<c:choose>
						<c:when test="${isNew}"> <spring:message code="label.save"/></c:when>
						<c:otherwise> <spring:message code="label.update"/></c:otherwise>
					</c:choose>
				</form:button>
			</div>
		</form:form>
	</div>
</div>