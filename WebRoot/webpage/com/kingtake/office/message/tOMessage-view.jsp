<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>系统消息</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="webpage/com/kingtake/project/manage/addTab.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
  });
 </script>
 </head>
 <body style="overflow-x: hidden;">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="tOMessageController.do?doUpdate">
					<input id="id" name="id" type="hidden" value="${tOMessagePage.id }">
					<input id="senderId" name="senderId" type="hidden" value="${tOMessagePage.senderId }">
					<input id="delFlag" name="delFlag" type="hidden" value="${tOMessagePage.delFlag }">
					<input id="delTime" name="delTime" type="hidden" value="${tOMessagePage.delTime }">
	<table cellpadding="0" cellspacing="1" style="margin:auto;width:600px;">
		<tr>
			<td align="right" width="50px">
				<label class="Validform_label">发送人:</label>
			</td>
			<td class="value">
		     	 <input id="senderName" name="senderName" type="text" style="width: 150px" class="inputxt"  
					               
					                value='${tOMessagePage.senderName}'>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">发送人</label>
			</td>
			<td align="right">
				<label class="Validform_label">发送时间:</label>
			</td>
			<td class="value">
					  <input id="sendTime" name="sendTime"  datatype="*" type="text" style="width: 150px" 
		      						class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					                value='<fmt:formatDate value='${tOMessagePage.sendTime}' type="date" pattern="yyyy-MM-dd HH:mm:ss"/>'>   
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">发送时间</label>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="Validform_label">标&nbsp;&nbsp;&nbsp;题:</label>
			</td>
			<td class="value" colspan="3">
		     	<input id="title" name="title" type="text"  style="width:464px;" class="inputxt" value='${tOMessagePage.title}'   datatype="byterange" max="200" min="1">
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">标题</label>
			</td>
			
		</tr>
		<tr>
			<td align="right">
				<label class="Validform_label">内&nbsp;&nbsp;&nbsp;容:</label>
			</td>
			<td class="value" colspan="3">
				<p id="content" style="width:467px;border-style: solid solid solid solid;border-color:#CCCCCC;border-width: 1px;line-height:25px;"  name="content" datatype="byterange" max="2000" min="1">${tOMessagePage.content}</p>
<!-- 				<span class="Validform_checktip"></span> -->
<!-- 				<label class="Validform_label" style="display: none;">内容</label> -->
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="Validform_label">接收人:</label>
			</td>
			<td class="value" colspan="3">
				<input id="receverid" name="receverid" type="hidden" value="${receverid}">
				<input style="width: 464px;" id="recevername" name="recevername" type="text" value="${recevername}" readonly="readonly"  datatype="*">
<%-- 				<t:chooseUser icon="icon-search" title="人员列表" textname="id,realName" isclear="true" inputTextname="receverid,recevername" idInput="receverid"></t:chooseUser> --%>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">接收人</label>
			</td>
		</tr>
			</table>
			<%-- <div style="width: auto;height: 200px;">
				增加一个div，用于调节页面大小，否则默认太小
				<div style="width:800px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				 <t:tab href="tOMessageController.do?tOMessageReadList&id=${tOMessagePage.id}" icon="icon-search" title="系统消息接收人" id="tOMessageRead"></t:tab>
				</t:tabs>
			</div> --%>
			</t:formvalid>
			<!-- 添加 附表明细 模版 -->
		<table style="display:none">
		<tbody id="add_tOMessageRead_table_template">
			<tr>
			 <td align="center"><div style="width: 25px;" name="xh"></div></td>
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
				  <td align="left">
					  	<input name="tOMessageReadList[#index#].receiverName" maxlength="50" 
					  		type="text" class="inputxt"  style="width:120px;" >
					  <label class="Validform_label" style="display: none;">接收人姓名</label>
				  </td>
				  <td align="left">
					  	<input name="tOMessageReadList[#index#].readFlag" maxlength="1" 
					  		type="text" class="inputxt"  style="width:120px;" >
					  <label class="Validform_label" style="display: none;">阅读标志</label>
				  </td>
				  <td align="left">
							<input name="tOMessageReadList[#index#].readTime" maxlength="0" 
					  		type="text" class="Wdate" onClick="WdatePicker()"  style="width:120px;" >  
					  <label class="Validform_label" style="display: none;">阅读时间</label>
				  </td>
			</tr>
		 </tbody>
		</table>
 </body>
 <script src = "webpage/com/kingtake/office/message/tOMessage.js"></script>	