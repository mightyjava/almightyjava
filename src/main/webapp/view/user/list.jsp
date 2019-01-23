<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="container col-md-11">
	<div class="card">
		<div class="card-header">
			<c:choose>
				<c:when test="${userRole eq 'admin'}">
					<strong>
						<i class="fa fa-th-list"></i> <spring:message code="label.user.list"/>
					</strong>
					<div class="btn-group pull-right">
						<a href="javascript:void(0);" class="btn btn-outline-secondary btn-sm" onclick="addForm('user')" title='<spring:message code="label.addnew.user"/>'>
							<i class="fa fa-plus-circle fa-lg"></i> <spring:message code="label.user"/>
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<strong>
						<i class="fa fa-id-badge"></i> <spring:message code="label.user.profile"/>
					</strong>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="card-body">
			<table class="table table-bordered table-condensed table-hover table-striped">
				<thead>
					<tr>
						<th><spring:message code="label.fullname"/></th>
						<th><spring:message code="label.userid"/></th>
						<th><spring:message code="label.username"/></th>
						<th><spring:message code="label.email"/></th>
						<th><spring:message code="label.mobile"/></th>
						<c:if test="${userRole eq 'admin'}">
							<th><spring:message code="label.role"/></th>
						</c:if>
						<th><spring:message code="label.edit"/></th>
						<c:if test="${userRole eq 'admin'}">
							<th><spring:message code="label.delete"/></th>
						</c:if>
					</tr>
				</thead>
				
				<tbody>
					<c:choose>
						<c:when test="${users.size() gt 0}">
							<c:forEach items="${users}" var="user">
								<tr>
									<td>${user.fullName}</td>
									<td>${user.userId}</td>
									<td>${user.userName}</td>
									<td>${user.email}</td>
									<td>${user.mobile}</td>
									<c:if test="${userRole eq 'admin'}">
										<td>${user.role.name}</td>
									</c:if>
									<td>
										<a href="javascript:void(0);" onclick="editForm('user', '${user.id}')"><i class="fa fa-edit fa-lg"></i></a>
									</td>
									<c:if test="${userRole eq 'admin'}">
										<td>
											<a href="javascript:void(0);" onclick="deleteData('user', '${user.id}')"><i class="fa fa-trash fa-lg"></i></a>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr align="center">
								<td colspan="8"><spring:message code="label.nousers.available"/></td>
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
							<li class="page-item"><a href="javascript:void(0);" onclick="list('user', '1')" class="page-link"><spring:message code="label.first"/></a></li>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('user', '${current - 1}')" class="page-link"><spring:message code="label.previous"/></a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<c:choose>
							<c:when test="${i eq current}">
								<li class="page-item active"><a href="javascript:void(0);" onclick="list('user', '${i}')" class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a href="javascript:void(0);" onclick="list('user', '${i}')" class="page-link">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${current eq totalPages}">
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.next"/></a></li>
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.last"/></a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('user', '${current + 1}')" class="page-link"><spring:message code="label.next"/></a></li>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('user', '${totalPages}')" class="page-link"><spring:message code="label.last"/></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</c:if>
	</div>
</div>