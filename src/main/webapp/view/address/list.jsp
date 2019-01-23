<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="container col-md-11">
	<div class="card">
		<div class="card-header">
			<c:choose>
				<c:when test="${userRole eq 'admin'}">
					<strong>
						<i class="fa fa-th-list"></i> <spring:message code="label.address.list"/>
					</strong>
				</c:when>
				<c:otherwise>
					<strong>
						<i class="fa fa-address-card-o"></i> <spring:message code="label.address"/>
					</strong>
				</c:otherwise>
			</c:choose>
			<div class="btn-group pull-right">
				<a href="javascript:void(0);" class="btn btn-outline-secondary btn-sm" onclick="addForm('address')" title='<spring:message code="label.addnew.address"/>'>
					<i class="fa fa-plus-circle fa-lg"></i> <spring:message code="label.address"/>
				</a>
			</div>
		</div>
		<div class="card-body">
			<table class="table table-bordered table-condensed table-hover table-striped">
				<thead>
					<tr>
						<th><spring:message code="label.address.type"/></th>
						<th><spring:message code="label.address.line"/></th>
						<th><spring:message code="label.country"/></th>         
						<th><spring:message code="label.state"/></th>
						<th><spring:message code="label.city"/></th>
						<th><spring:message code="label.pincode"/></th>
						<c:if test="${userRole eq 'admin'}">
							<th><spring:message code="label.user"/></th>
						</c:if>
						<th><spring:message code="label.edit"/></th>
						<th><spring:message code="label.delete"/></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${addresses.size() gt 0}">
							<c:forEach items="${addresses}" var="address">
								<tr>
									<td>${address.addressType}</td>
									<td>${address.addressLine}</td>
									<td>${address.country}</td>
									<td>${address.state}</td>
									<td>${address.city}</td>
									<td>${address.pinCode}</td>
									<c:if test="${userRole eq 'admin'}">
										<td>${address.user.fullName}</td>
									</c:if>
									<td><a href="javascript:void(0);" onclick="editForm('address', '${address.id}')"><i class="fa fa-edit fa-lg"></i></a></td>
									<td><a href="javascript:void(0);" onclick="deleteData('address', '${address.id}')"><i class="fa fa-trash fa-lg"></i></a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr align="center">
								<td colspan="9"><spring:message code="label.noaddresses.available"/></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<c:if test="${totalElements gt 5}">
			<div class="card-footer">
				<spring:message code="label.showing" arguments="${number+1},${size},${totalElements}"/>
				<ul class="pagination pull-right margin-7">
					<c:choose>
						<c:when test="${current eq 1}">
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.first"/></a></li>
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.previous"/></a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('address', '1')" class="page-link"><spring:message code="label.first"/></a></li>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('address', '${current - 1}')" class="page-link"><spring:message code="label.previous"/></a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<c:choose>
							<c:when test="${i eq current}">
								<li class="page-item active"><a href="javascript:void(0);" onclick="list('address', '${i}')" class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a href="javascript:void(0);" onclick="list('address', '${i}')" class="page-link">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${current eq totalPages}">
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.next"/></a></li>
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.last"/></a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('address', '${current + 1}')" class="page-link"><spring:message code="label.next"/></a></li>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('address', '${totalPages}')" class="page-link"><spring:message code="label.last"/></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</c:if>
	</div>
</div>