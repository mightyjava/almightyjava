<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="${path}/js/jquery.save.js"></script>

<div class="container col-lg-10">
	<div class="card">
		<div class="card-header">
			<strong>
				<c:choose>
					<c:when test="${isNew}"><i class="fa fa-plus-circle fa-lg"></i></c:when>
					<c:otherwise><i class="fa fa-edit fa-lg"></i></c:otherwise>
				</c:choose> <spring:message code="label.category"/>
			</strong>
		</div>
		<form:form method="post" class="form-horizontal" action="${path}/category/add" commandName="categoryForm" id="submitCategoryForm">
			<form:hidden path="id"/>
			<div class="card-body">
				<div class="row">
					<label class="col-md-2 control-label"><spring:message code="label.category.name"/> : </label>
					<div class="col-md-4 mb-3">
						<spring:message code="placeholder.category.name" var="categoryNamePlaceholder"/>
						<form:input class="form-control" path="name" placeholder="${categoryNamePlaceholder}" required="true"/>
					</div>
					
					<label class="col-md-2 control-label"><spring:message code="label.category.active.status"/> : </label>
					<div class="col-md-4 mb-3">
						<select class="form-control" name="activeStatus" required="true">
							<option value=""><spring:message code="dropdown.default.status"/></option>
							<c:choose>
								<c:when test="${isNew}">
									<option value="true"><spring:message code="label.category.active"/></option>
									<option value="false"><spring:message code="label.category.inactive"/></option>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${categoryForm.activeStatus}">
											<option value="true" selected="selected"><spring:message code="label.category.active"/></option>
											<option value="false"><spring:message code="label.category.inactive"/></option>
										</c:when>
										<c:otherwise>
											<option value="true"><spring:message code="label.category.active"/></option>
											<option value="false" selected="selected"><spring:message code="label.category.inactive"/></option>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</select>
					</div>
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