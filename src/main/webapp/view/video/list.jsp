<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="container col-md-11">
	<div class="card">
		<div class="card-header">
			<strong>
				<i class="fa fa-th-list"></i> <spring:message code="label.video.list"/>
			</strong>
			<div class="btn-group pull-right">
				<a href="javascript:void(0);" class="btn btn-outline-secondary btn-sm" onclick="addForm('video')" title='<spring:message code="label.addnew.video"/>'>
					<i class="fa fa-plus-circle fa-lg"></i> <spring:message code="label.video"/>
				</a>
			</div>
		</div>
		<div class="card-body">
			<table class="table table-bordered table-condensed table-hover table-striped">
				<thead>
					<tr>
						<th><spring:message code="label.video.title"/></th>
						<th><spring:message code="label.video.url"/></th>
						<th><spring:message code="label.categories"/></th>
						<th><spring:message code="label.edit"/></th>
						<th><spring:message code="label.delete"/></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${videos.size() gt 0}">
							<c:forEach items="${videos}" var="video">
								<tr>
									<td>${video.title}</td>
									<td>${video.youTubeURL}</td>
									<td>
										<c:forEach items="${video.categories}" var="category" varStatus="status">
											${category.name}<c:if test="${!status.last}">,</c:if>
										</c:forEach>
									</td>
									<td>
										<a href="javascript:void(0);" onclick="editForm('video', '${video.id}')"><i class="fa fa-edit fa-lg"></i></a>
									<td>
										<a href="javascript:void(0);" onclick="deleteData('video', '${video.id}')"><i class="fa fa-trash fa-lg"></i></a>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr align="center">
								<td colspan="5"><spring:message code="label.novideos.available"/></td>
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
							<li class="page-item"><a href="javascript:void(0);" onclick="list('video', '1')" class="page-link"><spring:message code="label.first"/></a></li>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('video', '${current - 1}')" class="page-link"><spring:message code="label.previous"/></a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<c:choose>
							<c:when test="${i eq current}">
								<li class="page-item active"><a href="javascript:void(0);" onclick="list('video', '${i}')" class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a href="javascript:void(0);" onclick="list('video', '${i}')" class="page-link">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${current eq totalPages}">
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.next"/></a></li>
							<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.last"/></a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('video', '${current + 1}')" class="page-link"><spring:message code="label.next"/></a></li>
							<li class="page-item"><a href="javascript:void(0);" onclick="list('video', '${totalPages}')" class="page-link"><spring:message code="label.last"/></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</c:if>
	</div>
</div>