<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn"	uri="http://java.sun.com/jsp/jstl/functions" %>
<script>

$(document).ready(function(){
	headerInvokeEvent();
	$.ajaxSetup({
		beforeSend	:	function(xhr, settings) {
			xhr.setRequestHeader("AJAX", "Yes");
		},
		statusCode : {
			200: function() {
				fnLoadingEnd();
	        },
			302: function() {
				fnLoadingEnd();
				main();
	        },
			404: function(a, status, c) {
				fnLoadingEnd();
				var message = "요청한 페이지가 없습니다.";
				if(this.type == "POST"){
					message = "요청 주소가 잘못됐습니다."
				}

				if(this.url == "<c:url value='/cm/messageBox.do'/>" && status == "error"){
					$.modal.close();
					alert('서버에서 오류가 발생했습니다. 잠시 후 다시 시도해 주시기 바랍니다.');
				}
				else {
					wook.wbs.common.messageBox(null, "페이지 오류", message, null);
				}
		    },
		    406: function() {
		    	fnLoadingEnd();
	        	wook.wbs.common.messageBox(null, "권한없음", "해당 기능에 대한 권한이 없습니다.", null , 'N');

	        },
			500: function() {
				fnLoadingEnd();
				var message = "요청한 페이지에 오류가 발생했습니다.";
				if(this.type == "POST"){
					message = "요청한 페이지에 오류가 발생했습니다."
				}
				wook.wbs.common.messageBox(null, "페이지 오류", message, null);
		    }
	    }
	});
});

//main
function main() {
	window.top.location.href = "<c:url value='/main.do'/>";
}

// logout

function login() {
	window.top.location.href = "<c:url value='/login/login.do'/>";
}

function logout() {
	window.location.href = "<c:url value='/login/logout.do'/>";
}

function modifyMember() {
	//window.location.href  ="<c:url value='/login/memberInfo/modifyMemberCheck.do'/>";
}

//메인페이지 링크 클릭 이벤트
function menuLinkMove(mMenuId, sMenuId){
	var mMenuId = $(this).data('mMenuId'.toLowerCase());
	var sMenuId = $(this).data('sMenuId'.toLowerCase());
	changeSubmenu(mMenuId, sMenuId);
}

//Header Invoke Event
function headerInvokeEvent() {
	topMenuEventHandler();				// Top Menu

	//로그아웃 버튼 이벤트
	//header.jsp 등록된 이벤트 호출
	$("#btnHeaderLogOut").on('click', logout);

	//개인정보 수정 버튼 이벤트
	//header.jsp 등록된 이벤트 호출
	$("#btnHeaderModifyMember").on('click', modifyMember);
}

//Top Menu Event Handler
function topMenuEventHandler() {
	$(".swiper-slide").on({
		mouseenter: function(){
			$(this).addClass('on')

		},
		mouseleave: function(){
			$(this).removeClass('on')
		}
	});

	$(".wrap-items > ul > li > a").on({
		mouseenter: function(){
			$(this).addClass('on')

		},
		mouseleave: function(){
			$(this).removeClass('on')
		}
	});

	$('.header__menu #gnb > li').each(function() {
		if ($(this).find('ul.depth2').length) {
			$(this).addClass('has-depth2');
		}
	});


	// 클릭한 menu의 메인페이지
	$('.header__menu #gnb > li > a').on('click', function(e) {
		$(this).parent().siblings().children("a").removeClass("on");
		$('.header__menu #gnb > li.has-depth2 > ul.depth2 > li').children().removeClass("on");
		$(this).addClass("on");
		$(this).siblings().children("li").find('a').eq(0).addClass('on')
		var mMenuId = $(this).data("mmenuid");
		var sMenuId = $(this).data("smenuid");

		changeSubmenu(mMenuId, sMenuId);
	});


	// 클릭한 menu로 이동
	$('header #gnb ul.depth2 > li > a').on('click', function(e) {
		$('.header__menu #gnb > li.has-depth2 > a').removeClass("on");
		$(this).parent().parent().parent().siblings().children("a").removeClass("on");
		$(this).parent().parent().parent().children("a").addClass("on");
		$('.header__menu #gnb > li.has-depth2 > ul.depth2 > li').children().removeClass("on");
		$(this).addClass("on");
		var mMenuId = $(this).data("mmenuid");
		var sMenuId = $(this).data("smenuid");

		changeSubmenu(mMenuId, sMenuId);
	});
}

function fnLoadingStart() {
	fnLoadingEnd();
	var backHeight = $(document).height(); //뒷 배경의 상하 폭
	var backWidth = window.document.body.clientWidth; //뒷 배경의 좌우 폭
	var backGroundCover = "<div id='back'></div>"; //뒷 배경을 감쌀 커버
	var loadingBarImage = ''; //가운데 띄워 줄 이미지
	loadingBarImage += "<div id='loadingBar'>";
	loadingBarImage += " <img src='<c:url value='/resources/images/common/loading.gif'/>' width = 100 height =100 />"; //로딩 바 이미지
	loadingBarImage += "</div>";
	$('body').append(backGroundCover).append(loadingBarImage);
	$('#back').css({ 'width': backWidth, 'height': backHeight, 'opacity': '0.3','z-index': '9999'});
	$('#back').show();
	$('#loadingBar').show();
}

function fnLoadingEnd() {
	$('#back, #loadingBar').hide();
	$('#back, #loadingBar').remove();
}


//기반시설분석시스템 탭 메뉴 화면 이동.
function changeSubmenu(mMenuId, sMenuId){

	if ( sMenuId == undefined || sMenuId == 0 ) {
		$('#lnb ul#nav' + mMenuId).children('li:eq(0)').children().trigger('click');
	} else if( sMenuId != undefined && sMenuId.toString().length == 2 ) {
		$('#lnb ul#nav' + mMenuId).find('a[data-mmenuid='+mMenuId+'][data-smenuid='+sMenuId+']').trigger('click');
	} else {
		$('#lnb ul#nav' + mMenuId).find('a[data-mmenuid='+mMenuId+'][data-smenuid='+sMenuId+'1]').trigger('click');
	}

}
</script>
<div class="Artc_header" style="min-height: 0px;">
	<div class="artc">
    	<div class="inner">
        	<h1 class="site-name">
            	<a href="\wbs\main.do" class="link">A to NINE</a>
            </h1>
            <!-- <form method="get" action="\search" class="form-search">
            	<div>
                	<input type="search" name="item" aria-label="검색어 입력란" class="inpt-search" />
                    <button type="submit" aria-label="검색" class="btn-search"></button>
                </div>
            </form> -->
            <div class="header_area">
            	<div class="header_menu">
            		<ul>
						<li>
							<a>패션</a>
						</li>
						<li>
							<a>영화</a>
						</li>
						<li>
							<a>음악</a>
						</li>
					</ul>
            	</div>
            </div>
            <nav class="nav-mine">
            	<a href="\mypage" class="btn-mypage">마이페이지</a>
            </nav>
    	</div>
	</div>
</div>