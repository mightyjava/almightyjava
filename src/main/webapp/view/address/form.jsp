<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<script type="text/javascript" src="${path}/js/jquery.save.js"></script>

<div class="container col-lg-8">
	<div class="card">
		<div class="card-header">
			<strong>
				<c:choose>
					<c:when test="${isNew}"><i class="fa fa-plus-circle fa-lg"></i></c:when>
					<c:otherwise><i class="fa fa-edit fa-lg"></i></c:otherwise>
				</c:choose> <spring:message code="label.address"/>
			</strong>
		</div>
		<form:form method="post" class="form-horizontal" action="${path}/address/add" commandName="addressForm" id="submitAddressForm">
			<form:hidden path="id"/>
			<div class="card-body">
				<div class="row">
					<label class="col-md-2 control-label"><spring:message code="label.address.line"/> : </label>
					<div class="col-md-10 mb-3">
						<spring:message code="placeholder.addressline" var="addresslinePlaceholder"/>
						<form:textarea class="form-control" path="addressLine" placeholder="${addresslinePlaceholder}" required="true"/>
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label"><spring:message code="label.address.type"/> : </label>
					<div class="col-md-4 mb-3">
						<form:select class="form-control" path="addressType">
							<option value=""><spring:message code="dropdown.default.type"/></option>
							<c:forEach items="${addressTypes}" var="addressType">
								<form:option value="${addressType}">${addressType}</form:option>
							</c:forEach>
						</form:select>
					</div>
					<label class="col-md-2 control-label"><spring:message code="label.country"/> : </label>
					<div class="col-md-4 mb-3">
						<spring:message code="placeholder.country" var="countryPlaceholder"/>
						<form:input class="form-control" path="country" placeholder="${countryPlaceholder}" required="true"/>
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label"><spring:message code="label.state"/> : </label>
					<div class="col-md-4 mb-3">
						<spring:message code="placeholder.state" var="statePlaceholder"/>
						<form:input class="form-control" path="state" placeholder="${statePlaceholder}" required="true"/>
					</div>
					<label class="col-md-2 control-label"><spring:message code="label.city"/> : </label>
					<div class="col-md-4 mb-3">
						<spring:message code="placeholder.city" var="cityPlaceholder"/>
						<form:input class="form-control" path="city" placeholder="${cityPlaceholder}" required="true"/>
					</div>
				</div>
				<div class="row">
					<label class="col-md-2 control-label"><spring:message code="label.pincode"/> : </label>
					<div class="col-md-4 mb-3">
						<spring:message code="placeholder.pinCode" var="pinCodePlaceholder"/>
						<form:input class="form-control" path="pinCode" placeholder="${pinCodePlaceholder}" required="true"/>
					</div>
					<c:choose>
						<c:when test="${userRole eq 'admin'}">
							<label class="col-md-2 control-label"><spring:message code="label.user"/> :</label>
							<div class="col-md-4 mb-3">
								<form:select class="form-control" path="userId">
									<option value=""><spring:message code="dropdown.default.user"/></option>
									<c:forEach items="${users}" var="user">
										<c:choose>
											<c:when test="${isNew}">
												<form:option value="${user.id}">${user.fullName}</form:option>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${fn:contains(user.id, addressForm.user.id)}">
														<option selected="selected" value="${user.id}">${user.fullName}</option>
													</c:when>
													<c:otherwise>
														<option value="${user.id}">${user.fullName}</option>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
							</div>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${isNew}">
									<form:hidden path="userId" value="${user.id}"/>
								</c:when>
								<c:otherwise>
									<form:hidden path="userId" value="${addressForm.user.id}"/>
								</c:otherwise>
							</c:choose>
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