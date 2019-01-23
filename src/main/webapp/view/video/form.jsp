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
				</c:choose> <spring:message code="label.video"/>
			</strong>
		</div>
		<form:form method="post" class="form-horizontal" action="${path}/video/add" commandName="videoForm" id="submitVideoForm">
			<form:hidden path="id"/>
			<div class="card-body">
				<div class="row">
					<label class="col-md-2 control-label"><spring:message code="label.video.title"/> : </label>
					<div class="col-md-4 mb-3">
						<spring:message code="placeholder.video.title" var="videoTitlePlaceholder"/>
						<form:input class="form-control" path="title" placeholder="${videoTitlePlaceholder}" required="true" autocomplete="off"/>
					</div>
					
					<label class="col-md-2 control-label"><spring:message code="label.video.url"/> : </label>
					<div class="col-md-4 mb-3">
						<spring:message code="placeholder.video.url" var="videoURLPlaceholder"/>
						<form:input class="form-control" path="youTubeURL" placeholder="${videoURLPlaceholder}" required="true" autocomplete="off"/>
					</div>
				</div>
				<hr/>
				<div class="row">
					<label class="col-md-2 control-label"><spring:message code="label.categories"/> : </label>
					<div class="col-md-4 mb-3">
						<select class="form-control" multiple="multiple" id="leftSelectionId">
							<c:forEach items="${categories}" var="category">
								<option value="${category.id}">${category.name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2 control-label text-center">	
						<button type="button" class="btn btn-sm btn-success btn-100" id="moveLeftBtnId">>> <spring:message code="label.add"/></button>
						<br/><br/>
						<button type="button" class="btn btn-sm btn-danger btn-100" id="moveRightBtnId"><< <spring:message code="label.remove"/></button>
					</div>	
					<div class="col-md-4 mb-3">	
						<select class="form-control" multiple="multiple" name="selectedCategories" required="required" id="rightSelectionId"></select>
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