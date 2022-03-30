<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="sub_wrap">

	<div class="inner">

	 	<div id="divBoard" class="sub_section">

	 		<div class="board_list">

	 			<div class="box-search">

					<div class="box-search-keyword">
						<label class="blind" for="selGubun">검색 구분</label>
						<select id ="selGubun" name="selGubun"  title="검색 구분">
							<option value="0">제목+내용</option>
							<option value="1">제목</option>
							<option value="2">내용</option>
						</select>
						<label class="blind" for="keyword">검색어</label>
						<input type="search" id="keyword" name="keyword" title="검색어" placeholder="검색어 입력" class = "searchkeyword">
						<button type="button" id="btnSearch" title="검색">검색</button>
					</div>

				</div>

		 		<div id="divTotalPage" class="totalPage"></div>

				<table id="tblList" class="wbs-list-tb">
					<caption>게시판 목록</caption>
					<colgroup>
						<col  style="width:10%;" />
						<col  style="width:50%;" />
						<col  style="width:15%;" />
						<col  style="width:15%;" />
						<col  style="width:10%;" />
					</colgroup>

					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>첨부파일</th>
						</tr>
					</thead>
					<tbody>
						<tr class="nohover">
							<td colspan="5">&nbsp;</td>
						</tr>
					</tbody>
				</table>

				<div class="list_bottom">
					<button type="button" id="btnAdd" class="bp_btn" title="등록">등록</button>
				</div>

				<div id="divPaginator" class="paging"></div>

			</div>

			<!-- 게시판 상세정보 -->
			<div id="divSyBbsDetail"></div>

		</div>

	</div>

</div>

<script>
var _cPage 	= 1;
var _rows 	= 10;
var _pager = null;


$(document).ready(function() {
	wook.wbs.common.movePageEventHandler();
	wook.wbs.common.keyEvent();

	invokeEvent();
	//searchPage(1);
});

/*=======================
invoke event
=========================*/
function invokeEvent() {
	changeEventHandler();

	// 게시판 검색
	$("#btnSearch").click(function() {
		if($("#keyword").val() == null || $("#keyword").val() == "") {
			$("#selGubun option:eq(0)").prop("selected", true);
		}
		searchPage(1);
	});

	// 게시판 등록
	$("#btnAdd").click(function(){
		$("#tblList tbody tr").removeClass("selected");
		getBorardUpdate("", $("#bbsSe").val(), "C");
	});
}

//change Event Handler
function changeEventHandler() {
}

// 게시판 목록 serachPage
function searchPage(cPage) {
	_cPage = cPage;
	searchBoardList(cPage);
}

function searchBoardList(cPage) {
	_cPage = cPage;
	$("#divPaginator").html("");
	$("#divTotalPage").html("");
	selectBoardList(cPage);

}

// 게시판 목록 조회
function selectBoardList(cPage) {
	$("#divBoardDetail").hide();

	$("#tblList tbody").empty().append(wook.wbs.common.getWaitImg($("#tblList tbody").width(), 5));

	$.ajax({
		url			: 	"<c:url value='/board/getBoardList.do'/>",
		data		:	{
							gubun		: $("#selGubun").val(),							// 검색구분
							keyword		: $("#keyword").val(),							// 검색어
							rows		: _rows,										// 페이지당 항목수
							page		: cPage,										//페이지
						},
		dataType	:	"json",
		type		:	"post",
		success		:	function(data, textStatus){
							var htmlStr = "";
							if (data.result.length > 0) {
								$.each(data.result,function(index,item) {
									var boardSn		= wook.wbs.common.maskFormat(item.boardSn);					/* 게시판순번 */
									var boardSe		= wook.wbs.common.maskFormat(item.boardSe);					/* 게시판구분 */
									var boardSj		= wook.wbs.common.maskFormat(item.boardSj);					/* 게시판제목 */
									var boardCn		= wook.wbs.common.maskFormat(item.boardCn);					/* 게시판내용 */
									var boardFixYn 	= wook.wbs.common.maskFormat(item.boardFixYn);				/* 고정여부 */
									var mdfcnYmd	= wook.wbs.common.dateToString(item.mdfcnYmd);				/* 작성일자 */
									var mdfrId		= wook.wbs.common.dateToString(item.mdfrId);				/* 작성자ID */

									htmlStr += "<tr	";
									htmlStr += "	data-boardsn=" + boardSn + "";
									htmlStr += "	data-boardse=" + boardSe + "";
									htmlStr += ">";
									if ( bbsFixYn == "Y" ) {
										htmlStr += "	<td class='tc' style='color: red; font-weight: bold;'>고정</td>";
									} else {
										htmlStr += "	<td class='tc'>" + item.rownum + "</td>";
									}
									htmlStr += "	<td class='tl'><div class='nowrap' title='" + boardSj + "'>" + boardSj + "</div></td>";
									htmlStr += "	<td class='tc'><div class='nowrap' title='" + mdfrId + "'>" + mdfrId + "</div></td>";
									htmlStr += "	<td class='tc'><div class='nowrap' title='" + mdfcnYmd + "'>" + mdfcnYmd + "</div></td>";
									htmlStr += "	<td></td>";
									htmlStr += "</tr>";
								});
							} else {
								htmlStr = "<tr class='nohover'><td colspan='5' class='tc' style='color:#999999'>검색된 정보가 없습니다.</td></tr>";
							}

							var totalCount = (data.result.length == 0 ? 0 : data.result[0].totalCount);
							_pager = new Pager("divPaginator", "_pager", 1);	// global로 선언해함.  패러미터 :  divPaginator(페이징 div id),  _pager(페이저 객체를 담는 object),  1 (페이저 객체 number)
							_pager.makePaging(_cPage, totalCount, _rows, $("#divTotalPage"));

							$("#tblList tbody").html(htmlStr);

							if (data.result.length > 0) {
								ListEventHandler();
							}
						},
		beforeSend	:	function(XMLHttpRequest) {
							XMLHttpRequest.setRequestHeader("AJAX", "Yes");
						},
		error		: 	function(XMLHttpRequest, textStatus, errorThrown){
							if (XMLHttpRequest.status == 403 || XMLHttpRequest.status == 207) {
								wook.wbs.common.sessionTimeout();
							} else {
								var htmlStr = "<tr class='nohover'><td colspan='5' class='tc' style='color:#999999'>검색된 정보가 없습니다.</td></tr>";
								_pager = new Pager("divPaginator", "_pager", 1);	// global로 선언해함.  패러미터 :  divPaginator(페이징 div id),  _pager(페이저 객체를 담는 object),  1 (페이저 객체 number)
								_pager.makePaging(1, 0, _rows, $("#divTotalPage"));
								$("#tblList tbody").html(htmlStr);
							}
						}
	});
}

// 게시판 상세 정보 화면
function getBoardDetail(dataValue) {
	var bbsSn = dataValue[0];
	var bbsSe = dataValue[1];
	var ansSn = dataValue[2];

	$("#divSyBbsDetail").hide();
	$("#divSyAnsDetail").hide();

	var url = "<c:url value='/sy/syBbsDetail.do'/>";
	url += "?bbsSn=" 	+ bbsSn;
	url += "&bbsSe="	+ bbsSe;
	url += "&ansSn="	+ ansSn;
	$("#divSyBbsDetail").show().load(url);

	if(bbsSe == '03' && ansSn != '') {
		getSyAnsDetail(ansSn);
	}
}

// 답변 상세 정보 화면
function getSyAnsDetail(ansSn) {
	$("#divSyAnsDetail").hide();

	var url = "<c:url value='/sy/syAnsDetail.do'/>";
	url += "?ansSn=" 	+ ansSn;
	$("#divSyAnsDetail").show().load(url);
}


// 게시판 등록(수정) 화면
function getSyBbsUpdate(bbsSn, bbsSe, pageMode) {
	$("#divSyBbsDetail").hide();
	$("#divSyAnsDetail").hide();

	var url = "<c:url value='/sy/syBbsUpdate.do'/>";
	url += "?bbsSn=" + bbsSn;
	url += "&bbsSe=" + bbsSe;
	url += "&pageMode=" + pageMode;
	$("#divSyBbsDetail").show().load(url);
}

// 답변 등록(수정) 화면
function getSyAnsUpdate(ansSn, bbsSn, pageMode) {
	$("#divSyAnsDetail").hide();
	var url = "<c:url value='/sy/syAnsUpdate.do'/>";
	url += "?ansSn=" + ansSn;
	url += "&bbsSn=" + bbsSn;
	url += "&pageMode=" + pageMode;
	$("#divSyAnsDetail").show().load(url);
}
</script>