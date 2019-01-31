<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<input type="hidden" id="loginUserRole" value='${user.role.name}'/>
<input type="hidden" id="loginUserId" value='${user.id}'/>
<c:set var="userRole" value="${user.role.name}" scope="session"/>

<c:if test="${pageContext.request.userPrincipal.name != null}">
    <form id="logoutForm" method="POST" action="${path}/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
</c:if>

<nav class="navbar sticky-top navbar-expand-lg bg-dark navbar-dark fixed-top" role="navigation">
	
	<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    
    <a class="navbar-brand" href="javascript:void(0);">
    	<strong><spring:message code="label.brand"/></strong>
    </a>
    
    <div class="collapse navbar-collapse justify-content-between" id="navbar">
        
        <div class="navbar-nav">
            <a href="${path}" class="nav-link active">
            	<i class="fa fa-home"></i> <spring:message code="label.header.home"/>
            </a>
            <a href="javascript:void(0);" id="homeList"></a>
            <c:if test="${user.role.name eq 'admin'}">
            	<a href="javascript:void(0);" class="nav-link" id="userList">
            		<i class="fa fa-user"></i> <spring:message code="label.user.list"/>
            	</a>
            	<a href="javascript:void(0);" class="nav-link" id="addressList">
            		<i class="fa fa-address-book"></i> <spring:message code="label.address.list"/>
            	</a>
            	<a href="javascript:void(0);" class="nav-link" id="categoryList">
            		<i class="fa fa-tags"></i> <spring:message code="label.category.list"/>
            	</a>
            	<a href="javascript:void(0);" class="nav-link" id="videoList">
            		<i class="fa fa-youtube-play"></i> <spring:message code="label.video.list"/>
            	</a>
            	<a href="javascript:void(0);" class="nav-link" id="blogList">
            		<i class="fa fa-rss-square"></i> <spring:message code="label.blog.list"/>
            	</a>
            </c:if>
        </div>
        
        <div class="navbar-nav">
			<ul class="navbar-nav ">
                <li class="nav-item dropdown">
                
                    <a href="javascript:void(0);" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                		<spring:message code="label.welcome"/> <label>${user.fullName}</label> <i class="fa fa-user fa-lg"></i> 
            		</a>
            		
                    <div class="dropdown-menu" aria-labelledby="navDropDownLink">
                    	<c:if test="${user.role.name eq 'user'}">
	                        <a class="dropdown-item" href="javascript:void(0);" id="userProfile">
				                <label><i class="fa fa-id-badge"></i> <spring:message code="label.user.profile"/></label>
	                        </a>
	                        <a class="dropdown-item" href="javascript:void(0);" id="userAddress">
				                <label><i class="fa fa-address-card-o"></i> <spring:message code="label.address"/></label>
	                        </a>
	                    </c:if>
                        <a class="dropdown-item" href="javascript:void(0);" id="changePassword">
			                <label><i class="fa fa-lock"></i> <spring:message code="label.change.password"/></label>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="javascript:void(0);" class="dropdown-item" onclick="document.forms['logoutForm'].submit()"><i class="fa fa-sign-out"></i> <spring:message code="label.logout"/></a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>