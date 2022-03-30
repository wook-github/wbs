<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script>
$(document).ready(function() {
	subMenuChangeEventHandler();
	menuInvokeEvent();
});


function subMenuChangeEventHandler() {

	// Navigation Bar
	$("#lnb ul.depth2 > li > a").on("click", function(){
		var lnbLiCrt = $(this).parent('li');
		var lnbLiPrv = lnbLiCrt.siblings('li.on');

		if ($(this).parent('li').children('ul.depth3').length != 0) {
			lnbLiCrt.find('ul.depth3 li').removeClass('on');
			lnbLiCrt.find('ul.depth3 li:eq(0)').addClass('on');
			$(this).parent('li').children('ul.depth3').slideDown(300, function() {
				$(this).parent('li').addClass('on');
				$(this).parent('li').siblings('li.on').removeClass('on');
			});
		} else {
			$('#lnb ul.depth3').hide();

			$(this).parent('li').addClass('on');
			$(this).parent('li').siblings('li.on').removeClass('on');
		}

		if ($(this).parent('li').siblings('li.on').children('ul.depth3').length != 0) {
			$(this).parent('li').siblings('li.on').children('ul.depth3').slideUp(300);
		}

		var mMenuId = $(this).data("mmenuid");
		var sMenuId = $(this).data("smenuid");

		moveSubmenu(mMenuId + "" + sMenuId);
	});

	$('#lnb ul.depth3 > li > a').on("click", function() {
		$(this).parent('li').addClass('on');
		$(this).parent('li').siblings('li.on').removeClass('on');

		var mMenuId = $(this).data("mmenuid");
		var sMenuId = $(this).data("smenuid");

		moveSubmenu(mMenuId + "" + sMenuId);
	});
}



//기반시설통합관리시스템 탭 메뉴 화면 이동.
function moveSubmenu(menuInx){
	if (menuInx == "111") {		// 데이터관리 > 건설안전데이터
		location.href=g3way.csfi.common.contextPath + "/dat/cns/cnsMa.do";
	} else if (menuInx == "121") {		// 데이터관리 > 건설안전 통계
		location.href=g3way.csfi.common.contextPath + "/dat/cns/statsMa.do";
	} else if (menuInx == "131") {		// 데이터관리  > 시설안전데이터
		location.href=g3way.csfi.common.contextPath + "/dat/fcs/dtBrMa.do";
	} else if (menuInx == "141") {		// 데이터관리 > 시설안전 통계
		location.href=g3way.csfi.common.contextPath + "/dat/fcs/stBrMa.do";
	} else if (menuInx == "211") {		// 모델관리 > 건설안전 예측모델
		location.href=g3way.csfi.common.contextPath + "/mdl/cns/mdlCnsMa.do";
	} else if (menuInx == "221") {		// 모델관리 > 시설안전 예측모델
		location.href=g3way.csfi.common.contextPath + "/mdl/fcs/mdlFcsMa.do";
	} else if (menuInx == "311") {		// 분석·예측 > 성능분석
		location.href=g3way.csfi.common.contextPath + "/ans/cns/ansCnsMa.do";
	} else if (menuInx == "312") {		// 분석·예측 > 비용분석
		location.href=g3way.csfi.common.contextPath + "/ans/cns/ansCnsAcdnt.do";
	} else if (menuInx == "321") {		// 분석·예측 > 소요예산예측분석
		location.href=g3way.csfi.common.contextPath + "/ans/fcs/ansFcsMa.do";
	} else if (menuInx == "322") {		// 분분석·예측 > 사용자별
		location.href=g3way.csfi.common.contextPath + "/ans/fcs/ansFcsAcdnt.do";
	} else if (menuInx == "911") {		// 시스템 관리 > 사용자 관리
		location.href=g3way.csfi.common.contextPath + "/sys/usr/cmUser.do";
	} else if (menuInx == "921") {		// 시스템관리 > 공통코드 관리
		location.href=g3way.csfi.common.contextPath + "/sys/cmn/cmCode.do";
	} else if (menuInx == "931") {		// 시스템관리 > 모델이력관리
		location.href=g3way.csfi.common.contextPath + "/sys/mdl/cmMdlMa.do";
	}
}


function menuInvokeEvent() {
	var mMenuId = "";
	var sMenuId = "";
	var depth3Yn = "N";

	var targetsel = $(".depth2 a[data-url='" + this.location.pathname + "']");

	/*
	if(targetsel.length == 0){
		$("#lnb").hide();
	}
	else {
		mMenuId = $(targetsel).data('mmenuid');
		sMenuId = $(targetsel).data('smenuid');
		depth3Yn = $(targetsel).closest("ul").is('.depth3') ? "Y": "N";

		topMenuset(mMenuId, sMenuId, depth3Yn);
	}
	 */
}


//상위 메뉴를 이용하지 않고 화면 이동시 상단 네비게이션 설정함수
function topMenuset(mMenuId, sMenuId, depth3Yn){
	// header부분의 메인 클릭 시
	if ( mMenuId != undefined ) {
		// header부분 on 변경
		$(".header__menu ul#gnb li").find("a").removeClass("on");
		$(".header__menu ul#gnb li").find("a[data-mmenuid='" + mMenuId + "']").eq(0).addClass("on");
	}

 	// header부분의 메인 클릭 시
	if ( mMenuId != undefined && sMenuId != undefined) {
		// header부분 on 변경
		$(".header__menu ul#gnb li.has-depth2 ul.depth2 li").find("a").removeClass("on");
		$(".header__menu ul#gnb li.has-depth2 ul.depth2 li").find("a[data-mmenuid='" + mMenuId + "'][data-smenuid='" + parseInt(sMenuId.toString().substr(0,1)) + "']").addClass("on");
	}

	var title	= $('header ul#gnb > li > a.on').text();

	$("#lnb ul#nav" + mMenuId).show();
 	$("#lnb div.title").text(title);

 	$("#lnb ul#nav" + mMenuId + " > li").find("a[data-mmenuid='" + mMenuId + "'][data-smenuid^='" + sMenuId.toString().substr(0, 1) + "']").eq(0).parent("li").addClass("on");

 	// Depth 3
 	$("#lnb ul#nav" + mMenuId + " > li").find("a[data-mmenuid='" + mMenuId + "'][data-smenuid='" + sMenuId + "']").parent("li").addClass("on");
}


//main
function main() {
	window.top.location.href = "<c:url value='/main.do'/>";
}
</script>
<div id="lnb">
	<div class="title h2">데이터관리</div>
	<!-- 1. 모델개발 -->
	<ul id="nav1" class="depth2">
		<li>
			<a href="javascript:;" data-mmenuid="1" data-smenuid="11">건설안전데이터</a>
		</li>
		<li>
			<a href="javascript:;" data-mmenuid="1" data-smenuid="21">건설안전 통계</a>
		</li>
		<li>
			<a href="javascript:;" data-mmenuid="1" data-smenuid="31">시설안전데이터</a>
		</li>
		<li>
			<a href="javascript:;" data-mmenuid="1" data-smenuid="41">시설안전 통계</a>
		</li>
	</ul>

	<!-- 2. 모델관리 -->
	<ul id="nav2" class="depth2" style="display:none;">
		<li>
			<a href="javascript:;" data-mmenuid="2" data-smenuid="11" data-url ="<c:url value = '/mdl/cns/mdlCnsMa.do'/>">건설안전 예측모델</a>
		</li>
		<li>
			<a href="javascript:;" data-mmenuid="2" data-smenuid="21" data-url ="<c:url value = '/mdl/fcs/mdlFcsMa.do'/>">시설안전 예측모델</a>
		</li>
	</ul>

	<!-- 3. 분석·예측 -->
	<ul id="nav3" class="depth2" style="display:none;">
		<li>
			<a href="javascript:;" data-mmenuid="3" data-smenuid="11" data-url ="<c:url value = '/ans/cns/ansCnsMa.do'/>">건설안전</a>
			<ul class="depth3">
				<li><a href="javascript:;" data-mmenuid="3" data-smenuid="11"  data-url ="<c:url value = '/ans/cns/ansCnsMa.do'/>">위험성 분석</a></li>
				<li><a href="javascript:;" data-mmenuid="3" data-smenuid="12"  data-url ="<c:url value = '/ans/cns/ansCnsAcdnt.do'/>">건설사고 예측</a></li>
			</ul>
		</li>
		<li>
			<a href="javascript:;" data-mmenuid="3" data-smenuid="21" data-url ="<c:url value = '/ans/fcs/ansFcsMa.do'/>">시설안전</a>
			<ul class="depth3">
				<li><a href="javascript:;" data-mmenuid="3" data-smenuid="21"  data-url ="<c:url value = '/ans/fcs/ansFcsMa.do'/>">주요부재<br>상태등급 예측</a></li>
				<li><a href="javascript:;" data-mmenuid="3" data-smenuid="22"  data-url ="<c:url value = '/ans/fcs/ansFcsAcdnt.do'/>">보수비용 분석</a></li>
			</ul>
		</li>
	</ul>

	<!-- 9. 시스템관리 -->
	<ul id="nav9" class="depth2" style="display:none;">
		<li>
			<a href="javascript:;" data-mmenuid="9" data-smenuid="11" data-url ="<c:url value = '/sys/usr/cmUser.do'/>">사용자 관리</a>
		</li>
		<li>
			<a href="javascript:;" data-mmenuid="9" data-smenuid="21" data-url ="<c:url value = '/sys/cmn/cmCode.do'/>">공통코드 관리</a>
		</li>
		<li>
			<a href="javascript:;" data-mmenuid="9" data-smenuid="31" data-url ="<c:url value = '/sys/mdl/cmMdlMa.do'/>">모델이력관리</a>
		</li>
	</ul>
</div>

