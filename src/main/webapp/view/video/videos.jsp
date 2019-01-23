<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:choose>
	<c:when test="${videos.size() gt 0}">
		<c:forEach items="${videos}" var="video">
			<div class="card col-lg-3 col-md-4 col-xs-6 card-design">
				<div class="card-header">
					<b class="card-title" title="${video.title}">
						<c:choose>
							<c:when test="${fn:length(video.title) > 50}">
								${fn:substring(video.title, 0, 50)}...
							</c:when>
							<c:otherwise>
								${video.title}
							</c:otherwise>
						</c:choose>
					</b>
				</div>
				<div class="card-body p-1" style="background-color: rgba(0,0,0,.03);">
					<div class="embed-responsive embed-responsive-4by3 video-size">
						<iframe class="embed-responsive-item img-thumbnail" src="${video.youTubeURL}" allowfullscreen></iframe>
					</div>
				</div>
				<div class="card-footer">
					<c:forEach items="${video.categories}" var="category" varStatus="status">
						<span class="badge badge-pill badge-success">${category.name}</span>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="container h-100">
			<div class="row align-items-center h-100">
				<div class="col-6 mx-auto">
					<div class="jumbotron text-center">
						<h1 class="display-4">
							<spring:message code="label.no.data"/>
						</h1>
						<p class="lead">
							<spring:message code="label.wait"/>
						</p>
					</div>
				</div>
			</div>
		</div>
	</c:otherwise>
</c:choose>
<c:if test="${totalElements gt 5}">
	<div class="col-lg-12 d-flex justify-content-center align-text-bottom">
		<ul class="pagination pull-right margin-10">
			<c:choose>
				<c:when test="${current eq 1}">
					<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.first"/></a></li>
					<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.previous"/></a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a href="javascript:void(0);" onclick="list('home', '1')" class="page-link"><spring:message code="label.first"/></a></li>
					<li class="page-item"><a href="javascript:void(0);" onclick="list('home', '${current - 1}')" class="page-link"><spring:message code="label.previous"/></a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${begin}" end="${end}" var="i">
				<c:choose>
					<c:when test="${i eq current}">
						<li class="page-item active"><a href="javascript:void(0);" onclick="list('home', '${i}')" class="page-link">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a href="javascript:void(0);" onclick="list('home', '${i}')" class="page-link">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${current eq totalPages}">
					<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.next"/></a></li>
					<li class="page-item disabled"><a href="javascript:void(0);" class="page-link"><spring:message code="label.last"/></a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a href="javascript:void(0);" onclick="list('home', '${current + 1}')" class="page-link"><spring:message code="label.next"/></a></li>
					<li class="page-item"><a href="javascript:void(0);" onclick="list('home', '${totalPages}')" class="page-link"><spring:message code="label.last"/></a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</c:if>