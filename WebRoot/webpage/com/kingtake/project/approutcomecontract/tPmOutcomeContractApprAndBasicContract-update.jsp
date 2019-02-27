<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<script type="text/javascript">
  $(function(){
    $.ajax({
      type : 'POST',
      url : "tBCodeTypeController.do?typeCombo",// 请求的action路径
      data : {"codeType":"1", "code":"CGFS"},
      success : function(data) {
          var radioList = $.parseJSON(data);
        var html = "";
        var detailFlag = location.href.indexOf("load=detail")!=-1;
        for(var i=0; i<radioList.length; i++){
          if(i%4 == 0){
            html += '<tr>'
          }
          
          var check = false;
          if(radioList[i].CODE == "${tPmOutcomeContractApprPage.acquisitionMethod}"){
            check = true;
          }
          
          html += '<td style="background-color: white;width:100px;height:25px;">'+
          '<input id="acquisitionMethod" name="acquisitionMethod" type="radio" value="'+radioList[i].CODE + '"';
          
          if(detailFlag){
            html += ' disabled="true" ';
          }
          
          if(check){
            html += ' checked="checked"';
          }
          html += '/>'+radioList[i].NAME+'</td>';
          
          if(i%4 == 3){
            html += '</tr>'
          }
        } 
        $("#typeRadio").html(html);
      }
    });
  
    //如果页面是详细查看页面
    if(location.href.indexOf("load=detail")!=-1){
      //无效化所有表单元素，只能进行查看
      $(":input").attr("disabled","true");
      //隐藏选择框和清空框
      $("a[icon='icon-search']").css("display","none");
      $("a[icon='icon-redo']").css("display","none");
      //隐藏下拉框箭头
      $(".combo-arrow").css("display","none");
      //隐藏添加附件
      $("#filediv").parent().css("display","none");
      //隐藏附件的删除按钮
      $(".jeecgDetail").parent().css("display","none");
      //$(":input").attr("style","border:0;border-bottom:1 solid black;background:white;");
      //将发送蛇皮设为可点
      $(".sendButton").removeAttr("disabled");
    }
    
    var contractType = $("#contractType_hidden").val();
    if(contractType!=""){
        $("#contractType").val(contractType);
    }
    
    loadCgjh();
    
  });
  
  function loadCgjh(){
		var projectId = $("#projectId").val();
		$.ajax({
			url:'tPmOutcomeContractApprController.do?getCgjh',
			data:{projectId:projectId},
			cache:false,
			type:'POST',
			dataType:'json',
			success:function(data){
				cgjhData = data;
				var htmlStr = ""
				htmlStr = htmlStr +'<option value="">请选择</option>';
				for(var i=0;i<data.length;i++){
					htmlStr = htmlStr+'<option value="'+data[i].id+'">'+data[i].planName+'</option>'
				}
				$("#glcgjh").html(htmlStr);
				var cgjhid = $("#cgjh_hidden").val();
				if(cgjhid!=""){
					$("#glcgjh").val(cgjhid);
				}
				$("#glcgjh").change(function(){
					var cgjh = $("#glcgjh").val();
					for(var i=0;i<cgjhData.length;i++){
						if(cgjh==cgjhData[i].id){
							$("#acquisitionMethod").val(cgjhData[i].cgfsStr);
							$("#acquisitionReason").val(cgjhData[i].cgly);
						}
					}
				});
			}
		});
	}
</script>
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" 
	action="tPmOutcomeContractApprController.do?doUpdate" tiptype="1" tipSweep="true">
<link rel="stylesheet" href="webpage/com/kingtake/project/panelUtil/panel.css" type="text/css"></link>
<script type="text/javascript" src="webpage/com/kingtake/project/panelUtil/panel.js"></script>
<script src = "webpage/com/kingtake/apprUtil/apprUtil.js"></script>
<style type="text/css">
.colspanWidth{
	width:505px;
}
</style>

<div style="overflow:hidden;width:100%;height:97%">
	<!-- 合同审批表 -->
	<div style="border:1px solid #B8CCE2; cursor:pointer" onclick="apprOrBasic2(this);">
		<div class="table_title" style="font-size:20px;">
			科研采购合同签订审批表
		</div>
		<div class="tool" state="live">
			<a class="collapse expand" href="javascript:void(0)"></a>
			<span>隐藏</span>
		</div>
	</div>
	<div style="overflow-y:auto;height:85%">
		<div style="margin-left:30px;">
			<input id="id" name="id" type="hidden" value="${tPmOutcomeContractApprPage.id}">
			<input id="projectId" name="project.id" type="hidden" 
				value="${tPmOutcomeContractApprPage.project.id}">
			<table style="width:700px;margin:auto;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td colspan="2">
					</td>
					<td style="height:40px;">
						<span style="font-size:12px;">合同编号:<font color="red">*</font></span>
					    <input id="contractCode" name="contractCode" type="text" readonly="true"
					    	datatype="*1-15" errormsg="请在合同审批表-合同编号中填写1-15位任意字符"
					    	ajaxurl="tPmOutcomeContractApprController.do?validformContractCode&id=${tPmOutcomeContractApprPage.id}"
					   		style="font-size:12px; border-style: none none solid none; 
					   			border-color: #CACACA; padding: 2px;width:170px;"  
					   		value="${tPmOutcomeContractApprPage.contractCode}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中合同编号</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							申请单位:<font color="red">*</font>
						</label>
					</td>
					<td class="value" colspan="2">
			     	 	<input id="applyUnit" name="applyUnit" type="text" class="colspanWidth" 
			     	 		datatype="*1-30" errormsg="请在合同审批表-申请单位中填写1-30位任意字符"
			     	 		value="${tPmOutcomeContractApprPage.applyUnit}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中申请单位</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							项目名称:<font color="red">*</font>
						</label>
					</td>
					<td class="value" colspan="2">
				     	<input id="projectnameSubjectcode" name="projectnameSubjectcode" type="text" class="colspanWidth" 
				     		readonly="readonly"	value="${tPmOutcomeContractApprPage.projectnameSubjectcode}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中项目名称</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							合同名称:<font color="red">*</font>
						</label>
					</td>
					<td class="value" colspan="2">
				     	<input id="contractName" name="contractName" type="text" class="colspanWidth" 
				     		datatype="*1-50" errormsg="请在合同审批表-合同名称中填写1-50位任意字符"
				     		value="${tPmOutcomeContractApprPage.contractName}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中合同名称</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							对方单位:<font color="red">*</font>
						</label>
					</td>
					<td class="value" colspan="2">
			     	 	<input id="approvalUnit" name="approvalUnit" type="text" class="colspanWidth" 
			     	 		datatype="*1-30" errormsg="请在合同审批表-对方单位中填写1-30位任意字符"
			     	 		value="${tPmOutcomeContractApprPage.approvalUnit}">
                        <input id="approvalUnitId" name="approvalUnitId" type="hidden" value="${tPmOutcomeContractApprPage.approvalUnitId}">
                        <t:choose url="tPmQualitySupplierController.do?supplierList" icon="icon-search" title="选择供方" isclear="true" tablename="tPmQualitySupplierList" hiddenid="approvalUnitId" inputTextname="approvalUnitId,approvalUnit" textname="id,supplierName" left="30%" top="30%" width="850px" ></t:choose>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中对方单位</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							合同第三方:
						</label>
					</td>
					<td class="value" colspan="2">
				     	<input id="theContractThird" name="theContractThird" type="text" class="colspanWidth" 
				     		datatype="*1-30" errormsg="请在合同审批表-合同第三方中填写1-30位任意字符" ignore="ignore" 
				     		value="${tPmOutcomeContractApprPage.theContractThird}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中合同第三方</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							起止时间:<font color="red">*</font>
						</label>
					</td>
					<td class="value" colspan="3">
						<input id="startTime" name="startTime" type="text" style="width:180px; height: 23px;" 
	   						class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}'})" 
	   						datatype="date" errormsg="请在合同审批表-开始时间中填写正确日期格式"
	   						value='<fmt:formatDate value="${tPmOutcomeContractApprPage.startTime}" type="date" pattern="yyyy-MM-dd" />'
	   						>    
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中开始时间</label>
					  <label class="Validform_label">&nbsp至&nbsp</label>
				    <input id="endTime" name="endTime" type="text" style="width:180px" 
  						class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}'})" 
  						datatype="date" errormsg="请在合同审批表-截止时间中填写正确日期格式"
  						value='<fmt:formatDate value="${tPmOutcomeContractApprPage.endTime}" type="date" pattern="yyyy-MM-dd" />'
  						>    
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中截止时间</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							总&nbsp;经&nbsp;费:<font color="red">*</font>
						</label>
					</td>
					<td class="value">
				     	<input id="totalFunds" name="totalFunds" type="text" datatype="*"
				     		style="width:165px;text-align:right;" class="easyui-numberbox"
				     		data-options="min:0,max:99999999.99,precision:2,groupSeparator:','"
				     		value="${tPmOutcomeContractApprPage.totalFunds}" >元
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中总经费</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							业&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务&nbsp;<br>
							主&nbsp;管&nbsp;部&nbsp;门:
						</label>
					</td>
					<td class="value">
				     	<input id="busiManageDepart" name="busiManageDepart" type="text" style="width:180px" class="inputxt" 
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同审批表-业务主管部门中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.busiManageDepart}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中业务主管部门</label>
					</td>
				</tr>

          <tr>
            <td align="right"><label class="Validform_label">合同标的:<font color="red">*</font></label></td>
            <td class="value" colspan="2"><textarea id="contractObject" name="contractObject" style="height: 50px;" datatype="*1-2000" errormsg="请在合同审批表-合同标的中填写1-2000位任意字符" class="colspanWidth">${tPmOutcomeContractApprPage.contractObject}</textarea>
              <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">合同审批表中合同标的</label></td>
          </tr>
          
          <tr>
            <td align="right"><label class="Validform_label">合同依据:<font color="red">*</font></label></td>
            <td class="value" colspan="2"><textarea id="contractBasis" name="contractBasis" style="height: 50px;" datatype="*1-500" errormsg="请在合同审批表-合同依据中填写1-500位任意字符" class="colspanWidth">${tPmOutcomeContractApprPage.contractBasis}</textarea>
              <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">合同审批表中合同依据</label></td>
          </tr>

          <tr>
            <td align="right"><label class="Validform_label"> 合同类型:<font color="red">*</font>
            </label></td>
            <td class="value"><input id="contractType_hidden" type="hidden" value="${tPmOutcomeContractApprPage.contractType }"> <!-- <select id="contractType" name="contractType" style="width:180px;">
				     		<option value="3">生产订货类合同</option>
				     		<option value="4">研究(制)类合同</option>
				     		<option value="5">采购类合同</option>
				     	</select> --> <t:codeTypeSelect name="contractType" type="select" codeType="1" code="HTLB" id="contractType" defaultVal="${tPmOutcomeContractApprPage.contractType }"></t:codeTypeSelect> <span
              class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">合同类型</label></td>
          </tr>
          <tr>
                    <td align="right">
                        <label class="Validform_label">关联采购计划:</label>
                    </td>
                    <td class="value" colspan="2">
                    <input type="hidden" id="cgjh_hidden" value="${tPmOutcomeContractApprPage.glcgjhId }">
                    <select id="glcgjh" name="glcgjhId" >
                    </select>
                    <span class="Validform_checktip"></span>
                    <label class="Validform_label" style="display: none;">关联采购计划</label>
                    </td>
          </tr>

          <tr>
            <td align="right"><label class="Validform_label">关联进账来源:</label> </td>
            <td class="value" colspan="2"><input id="relateIncomeSource" name="relateIncomeSource" type="text" style="width: 490px;" value="${tPmOutcomeContractApprPage.relateIncomeSource}"
              datatype="*0-250"><br /> <label style="font-size: 12px; color: red">其他需要说明事项</label> <span class="Validform_checktip"></span> <label
              class="Validform_label" style="display: none;">关联进账来源</label></td>
          </tr>
          <!-- 合同其他信息 -->
				<tr>
					<td align="right">
						<label class="Validform_label">
							采购方式:
						</label>
					</td>
					<td class="value" colspan="2">
					   <input id="acquisitionMethod" name="acquisitionMethod" type="text" readonly="readonly" style="width:150px;"  value="${tPmOutcomeContractApprPage.acquisitionMethod}" >
					   <span class="Validform_checktip"></span>
					   <label class="Validform_label" style="display: none;">采购方式</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							采购理由:
						</label>
					</td>
					<td class="value" colspan="2">
				     	<textarea id="acquisitionReason" name="acquisitionReason"  style="height:50px;" class="colspanWidth"
				     		datatype="*0-150" errormsg="请在采购理由中填写1-150位任意字符" cols="3" rows="3" readonly="readonly" >${tPmOutcomeContractApprPage.acquisitionReason}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">采购理由</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							询&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价&nbsp;<br>
							小&nbsp;组&nbsp;成&nbsp;员:
						</label>
					</td>
					<td class="value" colspan="2">
				     	<textarea id="inquiryMember" name="inquiryMember"  style="height:50px;" 
				     		datatype="*1-100" ignore="ignore" errormsg="请在合同审批表-询价小组成员中填写1-100位任意字符"
				     		class="colspanWidth">${tPmOutcomeContractApprPage.inquiryMember}</textarea><br>
				     	<t:chooseUser icon="icon-search" title="人员列表" isclear="true"  idInput="receiveUseIds"
							textname="realName" inputTextname="inquiryMember" ></t:chooseUser>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中询价小组成员</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							技术规范或&nbsp;<br>技术规格书:
						</label>
					</td>
					<td class="value">
				     	<t:codeTypeSelect id="technicalManual" name="technicalManual" type="select"  labelText="---请选择---"
				     		codeType="1" code="HTPSZT" defaultVal="${tPmOutcomeContractApprPage.technicalManual}"></t:codeTypeSelect>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中技术规范或技术规格书</label>
					</td>
					<td class="value">
						<label class="Validform_label">
							质量保证大纲:
						</label>
						<t:codeTypeSelect id="qualityCetifyFlag" name="qualityCetifyFlag" type="select"  labelText="---请选择---"
							codeType="1" code="HTPSZT" defaultVal="${tPmOutcomeContractApprPage.qualityCetifyFlag}"></t:codeTypeSelect>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中质量保证大纲</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							标准化大纲:
						</label>
					</td>
					<td class="value" colspan="2">
				     	<t:codeTypeSelect id="standardOutline" name="standardOutline" type="select"  labelText="---请选择---"
				     		codeType="1" code="HTPSZT" defaultVal="${tPmOutcomeContractApprPage.standardOutline}"></t:codeTypeSelect>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中标准化大纲</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							附&nbsp;&nbsp;&nbsp;&nbsp;件<img alt="请上传合同扫描件等相关辅助材料" title="请上传合同扫描件等相关辅助材料" src="plug-in\easyui1.4.2\themes\icons\tip.png">:
						</label>
					</td>
	     				<td colspan="3" class="value">
	     					<input type="hidden" value="${tPmOutcomeContractApprPage.attachmentCode}" id="bid" name="attachmentCode" />
				        <table id="fileShow" style="max-width:505px;">
				        	<c:forEach items="${tPmOutcomeContractApprPage.certificates}" var="file" varStatus="idx">
					            <tr style="height: 30px;">
						            <td><a href="javascript:void(0);" >${file.attachmenttitle}</a>&nbsp;&nbsp;&nbsp;</td>
						            <td style="width:40px;"><a href="commonController.do?viewFTPFile&fileid=${file.id}&subclassname=org.jeecgframework.web.system.pojo.base.TSFilesEntity&gzip=0" title="下载">下载</a></td>
						            <td style="width:40px;"><a href="javascript:void(0)" class="jeecgDetail" onclick="delFTPFile('commonController.do?delFTPFile&id=${file.id}',this)">删除</a></td>
					            </tr>
				            </c:forEach>
				        </table>
						<div>
							<div class="form" id="filediv"></div>
							<t:upload name="fiels" id="file_upload"  buttonText="添加文件" 
	      	                   formData="bid,projectId" auto="true" dialog="false" onUploadSuccess="uploadSuccess" fileSizeLimit="2GB"
								uploader="commonController.do?saveUploadFilesToFTP&businessType=tPmOutcomeContractAppr" ></t:upload>
						</div>
     				</td>
	   			</tr>
	   			<tr>
					<td align="right">
						<label class="Validform_label">
							合同正本:
						</label>
					</td>
	     			<td colspan="2" class="value">
				        <table style="max-width:515px;">
				            <c:forEach items="${tPmOutcomeContractApprPage.contractBook}" var="file" varStatus="idx">
					            <tr style="height: 30px;">
						            <td><a href="javascript:void(0);" >${file.attachmenttitle}</a>&nbsp;&nbsp;&nbsp;</td>
						            <td style="width:40px;"><a href="commonController.do?viewFTPFile&fileid=${file.id}&subclassname=org.jeecgframework.web.system.pojo.base.TSFilesEntity&gzip=0" title="下载">下载</a></td>
						            <td style="width:40px;"><a href="javascript:void(0)" class="jeecgDetail" onclick="delFTPFile('commonController.do?delFTPFile&id=${file.id}',this)">删除</a></td>
					            </tr>
				            </c:forEach>
				        </table>
	     				</td>
	   			</tr>
	   			<tr>
					<td colspan="2">
					</td>
					<td style="height:40px;">
						<span style="font-size:12px; margin-left:100px;">签订时间:</span>
					    <input id="contractSigningTime" name="contractSigningTime" type="text" 
				      		class="Wdate" onClick="WdatePicker()" 
				      		datatype="date" ignore="ignore" errormsg="请在合同审批表-签订时间中填写正确日期格式"
				      		style="font-size:12px; border-style: none none solid none; 
					   			border-color: #CACACA; padding: 2px;width:100px; text-align:center;"
					   		value='<fmt:formatDate value="${tPmOutcomeContractApprPage.contractSigningTime}" 
				      			pattern="yyyy-MM-dd" type="date" />'> 
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同审批表中签订时间</label>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 合同基本信息表 -->
	<div style="border:1px solid #B8CCE2; cursor:pointer" onclick="apprOrBasic2(this);">
		<div class="table_title" style="font-size:20px;" onclick="apprOrBasic2(this);">
			合同基本信息
		</div>
		<div class="tool" state="dead">
			<a class="collapse" href="javascript:void(0)"></a>
			<span>展开</span>
		</div>
	</div>
	<div style="overflow-y:auto;height:85%;display:none;">
		<div style="margin-left:30px;">
			<input id="rid" name="rid" type="hidden" 
				value="${tPmOutcomeContractApprPage.tpmContractBasics[0].rid}">
			<input id="inOutContractid" name="inOutContractid" type="hidden" 
				value="${tPmOutcomeContractApprPage.tpmContractBasics[0].inOutContractid}">
			<table style="width:700px; margin:auto; text-align:center" 
				cellpadding="0" cellspacing="1" class="formtable">
				<thead>
					<tr style="font-weight:bold;">
						<td></td>
						<td class="value">甲方</td>
						<td class="value">乙方</td>
					</tr>
				</thead>
				<tr>
					<td align="right">
						<label class="Validform_label">
							法人单位名称:
						</label>
					</td>
					<td class="value">
				     	<input id="unitNameA" name="unitNameA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-法人单位名称(甲方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].unitNameA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中法人单位名称(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							法人单位名称(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="unitNameB" name="unitNameB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合合同基本信息-法人单位名称(乙方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].unitNameB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中法人单位名称(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							法定代表人职务:
						</label>
					</td>
					<td class="value">
				     	<input id="unitPositionA" name="unitPositionA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-法定代表人职务(甲方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].unitPositionA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中法定代表人职务(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							法定代表人职务(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="unitPositionB" name="unitPositionB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-法定代表人职务(乙方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].unitPositionB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中法定代表人职务(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							法定代表人姓名:
						</label>
					</td>
					<td class="value">
				     	<input id="nameA" name="nameA" type="text" style="width: 150px" class="inputxt"  
			            	value="${tPmOutcomeContractApprPage.tpmContractBasics[0].nameA}"
			            	datatype="*1-18" ignore="ignore" errormsg="请在合同基本信息-法定代表人姓名(甲方)中填写1-18位任意字符">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中法定代表人姓名(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							法定代表人姓名(乙方):<font color="red">*</font>
						</label>
					</td> -->
					<td class="value">
				     	<input id="nameB" name="nameB" type="text" style="width: 150px" class="inputxt"  
							datatype="*1-18" ignore="ignore" errormsg="请在合同基本信息-法定代表人姓名(乙方)中填写1-18位任意字符"
							value="${tPmOutcomeContractApprPage.tpmContractBasics[0].nameB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中法定代表人姓名(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							代理单位名称:
						</label>
					</td>
					<td class="value">
				     	<input id="agencyUintNameA" name="agencyUintNameA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-代理单位名称(甲方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].agencyUintNameA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中代理单位名称(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							代表单位名称(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="agencyUnitNameB" name="agencyUnitNameB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-代表单位名称(乙方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].agencyUnitNameB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中代表单位名称(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							代理人职务:
						</label>
					</td>
					<td class="value">
				     	<input id="agencyUnitPositionA" name="agencyUnitPositionA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-代理人职务(甲方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].agencyUnitPositionA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中代理人职务(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							代理人职务(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="agencyUnitPositionB" name="agencyUnitPositionB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-代理人职务(乙方)中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].agencyUnitPositionB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中代理人职务(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							代理人姓名:
						</label>
					</td>
					<td class="value">
				     	<input id="agencyNameA" name="agencyNameA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-18" ignore="ignore" errormsg="请在合同基本信息-代理人姓名(甲方)中填写1-18位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].agencyNameA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中代理人姓名(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							代理人姓名(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="agencyNameB" name="agencyNameB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-18" ignore="ignore" errormsg="请在合同基本信息-代理人姓名(乙方)中填写1-18位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].agencyNameB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中代理人姓名(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							单位地址:
						</label>
					</td>
					<td class="value">
				     	<input id="addressA" name="addressA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-100" ignore="ignore" errormsg="请在合同基本信息-单位地址(甲方)中填写1-100位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].addressA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中单位地址(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							单位地址(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="addressB" name="addressB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-100" ignore="ignore" errormsg="请在合同基本信息-单位地址(乙方)中填写1-100位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].addressB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中单位地址(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							邮政编码:
						</label>
					</td>
					<td class="value">
				     	<input id="postalcodeA" name="postalcodeA" type="text" style="width: 150px" class="inputxt"
				     		datatype="p" ignore="ignore" errormsg="请在合同基本信息-邮政编码(甲方)中填写正确邮政编码格式"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].postalcodeA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中邮政编码(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							邮政编码(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="postalcodeB" name="postalcodeB" type="text" style="width: 150px" class="inputxt"
				     		datatype="p" ignore="ignore" errormsg="请在合同基本信息-邮政编码(乙方)中填写正确邮政编码格式"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].postalcodeB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中邮政编码(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							联系电话:
						</label>
					</td>
					<td class="value">
				     	<input id="telA" name="telA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" 
				     		ignore="ignore" errormsg="请在合同基本信息-联系电话(甲方)中填写正确的电话号码格式"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].telA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中联系电话(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							联系电话(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="telB" name="telB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-30" 
				     		ignore="ignore" errormsg="请在合同基本信息-联系电话(乙方)中填写正确的电话号码格式"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].telB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中联系电话(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							账户名称:
						</label>
					</td>
					<td class="value">
				     	<input id="accountNameA" name="accountNameA" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-50" ignore="ignore" errormsg="请在合同基本信息-账户名称(甲方)中填写1-50位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].accountNameA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中账户名称(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							帐户名称(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="accountNameB" name="accountNameB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-50" ignore="ignore" errormsg="请在合同基本信息-帐户名称(乙方)中填写1-50位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].accountNameB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中帐户名称(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							开户银行:
						</label>
					</td>
					<td class="value">
				     	<input id="bankA" name="bankA" type="text" style="width: 150px" class="inputxt"
				     		 datatype="*1-50" ignore="ignore" errormsg="请在合同基本信息-开户银行(甲方)中填写1-50位任意字符"
				     		 value="${tPmOutcomeContractApprPage.tpmContractBasics[0].bankA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中开户银行(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							开户银行(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="bankB" name="bankB" type="text" style="width: 150px" class="inputxt" 
				     		 datatype="*1-50" ignore="ignore" errormsg="请在合同基本信息-开户银行(乙方)中填写1-50位任意字符"
				     		 value="${tPmOutcomeContractApprPage.tpmContractBasics[0].bankB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中开户银行(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							帐&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:
						</label>
					</td>
					<td class="value">
				     	<input id="accountIdA" name="accountIdA" type="text" style="width: 150px" class="inputxt" 
				     		 datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-帐号(甲方)中填写1-30位任意字符"
				     		 value="${tPmOutcomeContractApprPage.tpmContractBasics[0].accountIdA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中帐号(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							帐号(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="accountIdB" name="accountIdB" type="text" style="width: 150px" class="inputxt"
				     		 datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-帐号(乙方)中填写1-30位任意字符"
				     		 value="${tPmOutcomeContractApprPage.tpmContractBasics[0].accountIdB}">	
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中帐号(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							签字地点:
						</label>
					</td>
					<td class="value">
				     	<input id="signAddressA" name="signAddressA" type="text" style="width: 150px" class="inputxt"
				     		 datatype="*1-100" ignore="ignore" errormsg="请在合同基本信息-签字地点(甲方)中填写1-100位任意字符"
				     		 value="${tPmOutcomeContractApprPage.tpmContractBasics[0].signAddressA}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中签字地点(甲方)</label>
					</td>
					<!-- <td align="right">
						<label class="Validform_label">
							签字地点(乙方):
						</label>
					</td> -->
					<td class="value">
				     	<input id="signAddressB" name="signAddressB" type="text" style="width: 150px" class="inputxt"
				     		datatype="*1-100" ignore="ignore" errormsg="请在合同基本信息-签字地点(乙方)中填写1-100位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].signAddressB}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中签字地点(乙方)</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							第&nbsp;三&nbsp;方:
						</label>
					</td>
					<td class="value" colspan="2">
				     	<input id="theThird" name="theThird" type="text" style="width: 435px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-第三方中填写1-30位任意字符"
			            	value="${tPmOutcomeContractApprPage.tpmContractBasics[0].theThird}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中第三方</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							甲方合同<br>履行监督单位:
						</label>
					</td>
					<td class="value" colspan="2">
				     	<input id="monitorUnit" name="monitorUnit" type="text" style="width: 435px" class="inputxt"
				     		datatype="*1-30" ignore="ignore" errormsg="请在合同基本信息-甲方合同履行监督单位中填写1-30位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].monitorUnit}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中甲方合同履行监督单位</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							总军事代表:
						</label>
					</td>
					<td class="value" colspan="3">
				     	<input id="militaryDeputy" name="militaryDeputy" type="text" style="width: 435px" class="inputxt" 
				     		datatype="*1-15" ignore="ignore" errormsg="请在合同基本信息-总军事代表中填写1-15位任意字符"
				     		value="${tPmOutcomeContractApprPage.tpmContractBasics[0].militaryDeputy}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">合同基本信息中总军事代表</label>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</t:formvalid>
<script src = "webpage/com/kingtake/common/upload/fileUpload.js"></script>