<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="container col-lg-5">
	<div class="card">
		<div class="card-header">
			<strong>
				<i class="fa fa-lock"></i> <spring:message code="label.change.password"/>
			</strong>
		</div>
		<div class="card-body">
			<div class="row">
				<label class="col-md-3 control-label"><spring:message code="label.current.password"/> : </label>
				<div class="col-md-5 mb-3">
					<spring:message code="placeholder.current.password" var="currentPwdPlaceholder"/>
					<input class="form-control" name="oldPassword" placeholder="${currentPwdPlaceholder}" required="true"/>
				</div>
			</div>
				
			<div class="row">	
				<label class="col-md-3 control-label"><spring:message code="label.new.password"/> : </label>
				<div class="col-md-5 mb-3">	
					<spring:message code="placeholder.new.password" var="newPwdPlaceholder"/>
					<input class="form-control" name="newPassword" placeholder="${newPwdPlaceholder}" required="true"/>
				</div>
			</div>
				
			<div class="row">
				<label class="col-md-3 control-label"><spring:message code="label.retype.new.password"/> : </label>
				<div class="col-md-5 mb-3">
					<spring:message code="placeholder.retype.new.password" var="retypePwdPlaceholder"/>
					<input class="form-control" name="c_newPassword" placeholder="${retypePwdPlaceholder}" required="true"/>
				</div>
			</div>
		</div>			
		<div class="card-footer text-right">
			<button class="btn btn-sm btn-primary">
				<i class="fa fa-save"></i> <spring:message code="label.save"/>
			</button>
		</div>
	</div>
</div>