<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="mMessage">
	<div class="modal-title">
		<div id="msgTitle"><h4></h4></div>
	</div>
	<div class="modal-content">
		<label id="msgContent">&nbsp;</label>
	</div>
	<div class="modal-btn">
		<button type="button" 	id="btnMsgConfirm" 	title="확인">확인</button>
		<button type="button" 	id="btnMsgCancel" 	title="취소">취소</button>
	</div>
</div>

<script>
$(document).ready(function(){
	$("#mMessage #msgTitle h4").html(wook.wbs.common.msgTitle);
	$("#mMessage #msgContent").html(wook.wbs.common.msgContent);

	$("#mMessage #btnMsgConfirm").focus();

	if (wook.wbs.common.callback == null || wook.wbs.common.canselYn == "N") {
		$("#mMessage #btnMsgCancel").hide();
	} else {
		$("#mMessage #btnMsgCancel").show();
	}
	msgBoxInvokeEvent();
});


/*=======================
msgBox invoke event
=========================*/
function msgBoxInvokeEvent() {
	// 확인
 	$("#mMessage #btnMsgConfirm").click(function() {
 		$.modal.close();

 		if (g3way.sidms.common.editObj != null) {
 			g3way.sidms.common.editObj.focus();
 		}

 		if (typeof g3way.sidms.common.callback == 'function') {
 			g3way.sidms.common.callback();
 		}
 	});

	// 취소
 	$("#mMessage #btnMsgCancel").click(function() {
 		$.modal.close();
	});

}
</script>
