<%@ page language="java" import="java.util.*,com.kingtake.common.constant.ProjectConstant,com.kingtake.project.entity.manage.TPmProjectEntity,com.kingtake.common.constant.SrmipConstants"
  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.legendFont {
	font-size: 12px;
	font-weight: bold;
}
</style>
<title>项目基本信息表</title>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<%
  request.setAttribute("no", SrmipConstants.NO);
  request.setAttribute("projectStatusMap", ProjectConstant.projectStatusMap);
%>
<script type="text/javascript">
  /**
   * 检测项目编号唯一性
   */
  function checkNo() {
    var flag = true;
    var projectNo = $("#projectNo").val();
    var id = $("#id").val();

    if (projectNo) {
      $.ajax({
        type : 'post',
        url : 'tPmProjectController.do?checkProjectNo',
        async : false,
        data : {
          projectNo : projectNo,
          id : id
        },
        success : function(result) {
          result = $.parseJSON(result);
          console.info(result);
          flag = result.success;
        }
      });
    }
    if (!flag) {
      $.Showmsg("项目编号不能重复!");
    }
    return flag;
  }

  function callback(data) {
    $.messager.alert('提示',data.msg);
  }

  $(function() {

    var projectType = $("#projectType").val();
    $("#projectType").combotree({
      url : 'tPmProjectController.do?getProjectType&projectTypeId='+projectType,
      onLoadSuccess : function() {
        var projectType = $("#projectType").val();
        if (projectType != "") {
          $("#projectType").combobox('setValue', projectType);
        } 
      },
      onChange : function() {
        var projectType = $("#projectType").combobox('getValue');
        $("#projectTypeId").val(projectType);
        $.ajax({
          async : false,
          cache : false,
          type : 'POST',
          url : 'tBProjectTypeController.do?getFundType',// 请求的action路径
          dataType : 'json',
          data : {
            'id' : projectType
          },
          success : function(data) {
            var fund = data.fund;
            var approval = data.approval;
            var office = data.office;
            $("#feeTypeName").val(fund.fundsName);
            $("#feeType").val(fund.id);
            $("#planContractFlagName").val(approval.name);
            $("#planContractFlag").val(approval.code);
          }
        });
      }
    });

    <!--------------------------项目组成员---------------------------------------->
    $("#tPmProjectMemberListtb").find("div[name='searchColums']").append($("#tempSearchColums div[name='searchColums']").html());       
    
    $('#modelBackground').combobox({    
	    url:'tBCodeTypeController.do?typeCombo&codeType=1&code=XHBJ',    
	    valueField:'NAME',    
	    textField:'NAME',
	    onLoadSuccess : function() {
	    	var modelBackgroundStr = $('#modelBackgroundStr').val();
	        if(modelBackgroundStr != ""){
	        	$('#modelBackground').combobox('setValue', modelBackgroundStr);
	        }
	    }
	});  
    
    
    if($("#parentProjectId").val() == ""){
    	$('#parentProjectLabel').attr('style', 'display:none;');
    }
    
  //无效化所有表单元素，只能进行查看
	$(":input").attr("disabled","true");
	$(":input").css("background-color","#FFFFCC");
	//隐藏选择框和清空框
	$("a[icon='icon-search']").css("display","none");
	$("a[icon='icon-redo']").css("display","none");
	$("a[icon='icon-save']").css("display","none");
	$("a[icon='icon-ok']").css("display","none");
	//隐藏下拉框箭头
	$(".combo-arrow").css("display","none");
	//隐藏添加附件
	$("#filediv").parent().css("display","none");
	//隐藏附件的删除按钮
	$(".jeecgDetail").parent().css("display","none");
	//隐藏easyui-linkbutton
	$(".easyui-linkbutton").css("display","none");
  });

  function godetail(id) {
    createdetailwindow('项目基本信息', 'tPmProjectController.do?goUpdateForResearchGroup&load=detail&id=' + id, "1100px", "600px");
  }

  function setValue() {
      var managerDepartCode = $("#manageDepartCode").val();
      if(managerDepartCode!=""){
         var manageDepart=$("#manageDepartCode").find("option:selected").text();
         $("#manageDepart").val(manageDepart);
      }
    
	
	var budgetAmount = $('#budgetAmount').numberbox('getValue');
	if(budgetAmount == ""){
		$('#budgetAmount').numberbox('setValue', 0);
	}
  }
  
  function selectProject(value) {
		if (value == 1) {
			$('#merge').attr('style', 'display:blank;');
			$('#mergePName').attr('datatype', '*');
		} else {
			$('#merge').attr('style', 'display:none;');
			$('#mergePName').removeAttr('datatype');
			$('#mergePId').val('');
			$('#mergePName').val('');
		}
	}
  
  function selectSchoolCooperation(value) {
		if (value == 1) {
			$('#parentProjectLabel').attr('style', 'display:blank;');
		} else {
			$('#parentProjectLabel').attr('style', 'display:none;');
			$('#parentProjectId').val('');
			$('#parentProjectName').val('');
		}
	}
  
  function uidChange(){
  	var uid = $('#projectManagerId').val();
	var orgid = $('#orgId').val();
	$.ajax({
		type : 'post',
		async : false,
		url:'tPmProjectMemberController.do?findInfoById',
		data:{'uid':uid,'orgid':orgid},
		success : function(data) {
			var d = $.parseJSON(data);
			var user = d.attributes.user;
			var departId = d.attributes.departId;
			var departName = d.attributes.departName;
			var departPid = d.attributes.departPid;
			var departPname = d.attributes.departPname;
			$('#managerPhone').val(user.officePhone ? user.officePhone : user.mobilePhone);
			$("#developerDepartId").val(departId = '' ? '' : departId);
			$("#devDepartDepartname").combotree('setValue', departName = '' ? '' : departName);
			$("#dutyDepartId").val(departPid = '' ? '' : departPid);
			$("#dutyDepartDepartname").combotree('setValue', departPname = '' ? '' : departPname);
		}
	});
  }
  
//来源单位自动联想
  function sourceUnitParse(data){
  	var d = $.parseJSON(data);
  	var parsed = [];
      	$.each(d,function(index,row){
      		parsed.push({data:row,result:row,value:row.NAME});
      	});
  	return parsed;
  }

  function sourceUnitFormatItem(data) {
  	return data.NAME;	  
  }

  function sourceUnitCallBack(data) {
  	$("#sourceUnit").val(data.NAME);
  }
</script>
</head>
<body>
  <div id="eLayout" class="easyui-layout" fit="false" style="height: 1000px;width: 1300px;margin: 0 auto;">
    <div id="rCenter" region="center">
      <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td align="center" bgcolor="#E5EFFF"><b>${tPmProjectPage.projectName}-项目基本信息表</b></td>
          <td align="right" width="5%" bgcolor="#E5EFFF"><input id="applying" value="${applying }" type="hidden" /> </td>
        </tr>
      </table>
      <t:formvalid postonce="false" formid="formobj" dialog="true" layout="table" action="tPmProjectController.do?doUpdate" tiptype="showValidMsg" beforeSubmit="setValue" callback="@Override callback">
        <input id="id" name="id" type="hidden" value="${tPmProjectPage.id }">
        <input id="approvalStatus" name="approvalStatus" type="hidden" value="${tPmProjectPage.approvalStatus }">
        <fieldset style="border-style: solid none none none; border-top: 3px double #CACACA;">
          <legend onclick="show_hide('baseData','showTxt')">
            <span class="legendFont" style="color: #A52A2A">基本信息</span>
          </legend>
          <div align="left">
            <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td align="right" width="90px"><label class="Validform_label"> 项目名称: </label> <font color="red">*</font></td>
                <td class="value" colspan="3"><input id="projectName" name="projectName" type="text" datatype="*2-30" style="width: 722px" class="inputxt" value='${tPmProjectPage.projectName}'>
                  <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">项目名称</label></td>
                <td align="right" width="95px"><label class="Validform_label"> 项目密级:</label><font color="red">*</font></td>
                <td class="value"><t:codeTypeSelect id="secretDegree" name="secretDegree" type="select" code="XMMJ" codeType="0" defaultVal="${tPmProjectPage.secretDegree}"
                    extendParam="{style:'width:150px'}"></t:codeTypeSelect> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">项目密级</label></td>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 项目编号: </label></td>
                <td class="value"><input id="projectNo" name="projectNo" type="text" ignore="ignore" datatype="s2-20" style="width: 160px" class="inputxt" validType="T_PM_PROJECT,PROJECT_NO,ID"
                  value='${tPmProjectPage.projectNo}' readonly="readonly"> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">项目编号</label></td>
                <td align="right" width="105px"><label class="Validform_label"> 会计编码: </label></td>
                <td class="value"><input id="accountingCode" name="accountingCode" type="text" datatype="s2-250" ignore="ignore" style="width: 160px" class="inputxt"
                  value='${tPmProjectPage.accountingCode}'> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">会计编码</label></td>
                <td align="right"><label class="Validform_label"> 重大专项 : </label></td>
                <td class="value"><c:if test="${empty tPmProjectPage.greatSpecialFlag }">
                    <t:codeTypeSelect id="greatSpecialFlag" name="greatSpecialFlag" code="SFBZ" codeType="0" type="radio" defaultVal="0"></t:codeTypeSelect>
                  </c:if> <c:if test="${!empty tPmProjectPage.greatSpecialFlag }">
                    <t:codeTypeSelect id="greatSpecialFlag" name="greatSpecialFlag" code="SFBZ" codeType="0" type="radio" defaultVal="${tPmProjectPage.greatSpecialFlag}"></t:codeTypeSelect>
                  </c:if> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">是否重大专项 </label></td>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 依据文号: </label></td>
                <td class="value"><input id="accordingNum" name="accordingNum" type="text" style="width: 100px" class="inputxt" readonly="readonly" value="${tPmProjectPage.accordingNum}">
                  <t:choose url="tOSendReceiveRegController.do?selectReg" tablename="tOSendReceiveRegList" width="800px" height="450px" icon="icon-search" title="收发文列表" textname="mergeFileNum"
                    inputTextname="accordingNum" isclear="true"></t:choose> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">依据文号</label></td>
                <td align="right"><label class="Validform_label"> 负&nbsp;责&nbsp;人: </label> <font color="red">*</font></td>
                <td class="value"><input id="projectManager" name="projectManager" type="text" datatype="*2-16" style="width: 160px" class="inputxt" datatype="s2-16"
                  value='${tPmProjectPage.projectManager}' readonly="readonly"> <input id="projectManagerId" name="projectManagerId" type="hidden" value="${tPmProjectPage.projectManagerId}">
                  <input id="orgId" name="orgId" type="hidden"> <t:chooseUser icon="icon-search" title="人员列表" textname="id,realName,departId" isclear="true"
                    inputTextname="projectManagerId,projectManager,orgId" idInput="projectManagerId" mode="single" fun="uidChange"></t:chooseUser> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">负责人</label></td>
                <td align="right"><label class="Validform_label"> 承研部门: </label> <font color="red">*</font></td>
                <td class="value"><input name="devDepartDepartname" id="devDepartDepartname" value="${tPmProjectPage.devDepart.departname}"> <script type="text/javascript">
                              //选择承研单位时，将承研单位的父单位加入责任单位
                              $(function() {
                                $('#devDepartDepartname').combotree({
                                  url : 'departController.do?getDepartTree&lazy=false',
                                  width : '165',
                                  height : '27',
                                  multiple : false,
                                  onSelect : function(record) {
                                    $("#developerDepartId").val(record.id);
                                    var tree = $('#devDepartDepartname').combotree('tree');
                                    var parent = tree.tree('getParent', record.target);
                                    $("#dutyDepartId").val(parent.id);
                                    $("#dutyDepartDepartname").combotree('setValue', parent.text);
                                  }
                                });
                              });
                            </script> <input id="developerDepartId" name="devDepart.id" type="hidden" value="${tPmProjectPage.devDepart.id}"> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">承研部门</label></td>                
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 责任部门: </label></td>
                <td class="value"><t:departComboTree name="" id="dutyDepartDepartname" idInput="dutyDepartId" lazy="false" value="${tPmProjectPage.dutyDepart.departname}" width="150"></t:departComboTree>
                  <input id="dutyDepartId" name="dutyDepart.id" type="hidden" class="inputxt" value='${tPmProjectPage.dutyDepart.id}'> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">责任部门</label></td>
                <td align="right"><label class="Validform_label"> 负责人电话: </label> <font color="red">*</font></td>
                <td class="value"><input id="managerPhone" name="managerPhone" type="text" style="width: 160px" class="inputxt" value='${tPmProjectPage.managerPhone}' datatype="*1-30"> <span
                  class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">负责人电话</label></td>
                <td align="right"><label class="Validform_label"> 起始日期: </label> <font color="red">*</font></td>
                <td class="value"><input id="beginDate" name="beginDate" type="text" datatype="date" style="width: 145px" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}'})"
                  value='<fmt:formatDate value='${tPmProjectPage.beginDate}' 
                  type="date" pattern="yyyy-MM-dd"/>'> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">起始日期</label></td>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 联&nbsp;系&nbsp;人&nbsp;: </label> <font color="red">*</font></td>
                <td class="value"><input id="contact" name="contact" type="text" datatype="s2-16" style="width: 160px" class="inputxt" value='${tPmProjectPage.contact}'> <span
                  class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">联系人</label></td>
                <td align="right"><label class="Validform_label"> 联系人电话: </label> <font color="red">*</font></td>
                <td class="value"><input id="contactPhone" name="contactPhone" type="text" style="width: 160px" class="inputxt" value='${tPmProjectPage.contactPhone}' datatype="*1-30"> <span
                  class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">联系人电话</label></td>
                <td align="right"><label class="Validform_label"> 截止日期: </label> <font color="red">*</font></td>
                <td class="value"><input id="endDate" name="endDate" type="text" datatype="date" style="width: 145px" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}'})"
                  value='<fmt:formatDate value='${tPmProjectPage.endDate}' 
                  type="date" pattern="yyyy-MM-dd"/>'> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">截止日期</label></td>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 项目状态:</label> <font color="red">*</font></td>
                <td class="value"><input type="text" style="width: 160px" class="inputxt" readonly="readonly" value='${projectStatusMap[tPmProjectPage.projectStatus]}'> <input
                  id="projectStatus" name="projectStatus" type="hidden" class="inputxt" value='${tPmProjectPage.projectStatus}'> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">项目状态</label></td>
                <td align="right"><label class="Validform_label"> 原会计编码:</label></td>
                <td class="value" colspan="3"><input id="oldAccountingCode" name="oldAccountingCode" type="text" datatype="s2-250" ignore="ignore" style="width: 160px" class="inputxt"
                  value='${tPmProjectPage.oldAccountingCode}'> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">原会计编码</label></td>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 项目简介:</label> <font color="red">*</font></td>
                <td colspan="5" class="value"><textarea id="projectAbstract" name="projectAbstract" type="text" datatype="*" style="width: 94%; height: 80px;" class="inputxt">${tPmProjectPage.projectAbstract}</textarea>
                  <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">项目简介</label></td>
              </tr>
            </table>
          </div>
        </fieldset>

        <fieldset style="border-style: solid none none none; border-top: 3px double #CACACA;">
          <legend onclick="show_hide('baseData','showTxt')">
            <span class="legendFont" style="color: #228B22">其他信息</span>
          </legend>
          <div>
            <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="formtable">
              <tr>
                <td align="right"><label class="Validform_label"> 项目类型: <font color="red">*</font></label></td>
                <td class="value"><input id="projectType" name="projectType.id" style="width: 165px; height:27px;" value="${tPmProjectPage.projectType.id}"> <input id="projectTypeId" type="hidden"
                  value="${tPmProjectPage.projectType.id}" datatype="*"> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">项目类型</label></td>
                <td align="right"><label class="Validform_label"> 经费类型: <font color="red">*</font></label></td>
                <td class="value"><input id="feeTypeName" type="text" style="width: 150px" class="inputxt" readonly value="${tPmProjectPage.feeType.fundsName}" datatype="*"> <input
                  id="feeType" name="feeType.id" type="hidden" value="${tPmProjectPage.feeType.id}"> <span class="Validform_checktip"></span> <label class="Validform_label"
                  style="display: none;">经费类型</label></td>
                <td align="right"><label class="Validform_label"> 计划合同标志: <font color="red">*</font></label></td>
                <td class="value"><input type="text" id="planContractFlagName" readonly style="width: 140px" class="inputxt" class="inputxt" value="${planContractFlag}" datatype="*"> <input
                  type="hidden" id="planContractFlag" name="planContractFlag" value="${tPmProjectPage.planContractFlag}"> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">计划合同标志</label></td>
              </tr>
              <tr>
<!--                 <td align="right"><label class="Validform_label"> 子类型: </label></td> -->
<!--                 <td class="value"><input id="subType" name="subType" type="text" style="width: 160px" class="inputxt" datatype="byterange" max="40" min="0" ignore="ignore" -->
<%--                   value='${tPmProjectPage.subType}'> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">子类型</label></td> --%>
				<td align="right"><label class="Validform_label"> 是否校内协作: </label></td>
            	<td class="value">
            	<c:if test="${empty tPmProjectPage.schoolCooperationFlag}">
            		<t:codeTypeSelect id="schoolCooperationFlag" name="schoolCooperationFlag" code="SFBZ" codeType="0" extendParam="{onclick:'selectSchoolCooperation(this.value);'}" type="radio" defaultVal="0"></t:codeTypeSelect>
            	</c:if>
            	<c:if test="${!empty tPmProjectPage.schoolCooperationFlag}">
            		<t:codeTypeSelect id="schoolCooperationFlag" name="schoolCooperationFlag" code="SFBZ" codeType="0" extendParam="{onclick:'selectSchoolCooperation(this.value);'}" type="radio" defaultVal="${tPmProjectPage.schoolCooperationFlag}"></t:codeTypeSelect>
            	</c:if>
             	<span class="Validform_checktip"></span>
              	<label class="Validform_label" style="display: none;">是否校内协作</label></td>
                <td align="right"><label class="Validform_label"> 分管部门: </label></td>
                <td class="value"><t:codeTypeSelect name="manageDepartCode" type="select" codeType="1" code="FGBM" id="manageDepartCode" labelText="请选择"
                    defaultVal="${tPmProjectPage.manageDepartCode}"></t:codeTypeSelect> <input id="manageDepart" name="manageDepart" value="${tPmProjectPage.manageDepart}" type="hidden"
                  datatype="s2-20" ignore="ignore"> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">分管部门</label></td>
                <td align="right"><label class="Validform_label"> 总经费(元): <font color="red">*</font></label></td>
                <td class="value"><input id="allFee" name="allFee" type="text" class="easyui-numberbox" data-options="min:0,max:100000000000,precision:2,groupSeparator:','"
                  style="width: 140px; text-align: right;" value='${tPmProjectPage.allFee}' datatype="*"> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">总经费</label>
                </td>
              </tr>
              <tr id="parentProjectLabel">
              	<td align="right"><label class="Validform_label"> 所属母项目: </label></td>
                <td class="value" colspan="3"><input id="parentProjectId" name="parentPmProject.id" type="hidden" value="${tPmProjectPage.parentPmProject.id}"> <input
                  id="parentProjectName" type="text" style="width: 330px" class="inputxt" value='${tPmProjectPage.parentProjectName}' readonly="readonly"> 
                  <t:choose url="tPmProjectController.do?projectSelect" width="1000px" height="460px" left="10%" top="10%"
              name="projectList" icon="icon-search" title="项目列表" textname="id,projectName" inputTextname="parentProjectId,parentProjectName"
              isclear="true" fun="parentProjectSelectCallback"></t:choose> <span class="Validform_checktip"></span> <label
                  class="Validform_label" style="display: none;">所属母项目</label></td>
              </tr>
              <tr>
              	<td align="right"><label class="Validform_label"> 预算金额: </label></td>
            <td class="value"><input id="budgetAmount" name="budgetAmount" type="text" class="easyui-numberbox" data-options="min:0,max:100000000000,precision:2,groupSeparator:','"
              style="width: 180px; text-align: right;" value="${tPmProjectPage.budgetAmount}">&nbsp;元 <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">预算金额</label></td>                            
                <td align="right"><label class="Validform_label"> 经费单列: </label></td>
                <td class="value"><input id="feeSingleColumn" name="feeSingleColumn" type="text" style="width: 140px" class="inputxt" value='${tPmProjectPage.feeSingleColumn}'> <span
                  class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">经费单列</label></td>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 计划合同名称: </label></td>
                <td class="value" colspan="3"><input id="planContractName" name="planContractName" datatype="byterange" max="1000" min="0" type="text" style="width: 330px" class="inputxt" value='${tPmProjectPage.planContractName}'>
                  <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">合同计划名称</label></td>
                <td align="right"><label class="Validform_label"> 合同签订日期: </label></td>
                <td class="value"><input id="contractDate" name="contractDate" type="text" ignore="ignore" datatype="date" style="width: 140px" class="Wdate" onClick="WdatePicker()"
                  value='<fmt:formatDate value='${tPmProjectPage.contractDate}' type="date" pattern="yyyy-MM-dd"/>'> <span class="Validform_checktip"></span> <label class="Validform_label"
                  style="display: none;">合同签订日期</label></td>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 计划合同文号: </label></td>
                <td class="value"><input id="planContractRefNo" name="planContractRefNo" type="text" datatype="byterange" max="1000" min="0" style="width: 160px" class="inputxt" value='${tPmProjectPage.planContractRefNo}'> <span
                  class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">计划合同文号</label></td>
                <td align="right"><label class="Validform_label"> 外来编号: </label></td>
                <td class="value"><input id="outsideNo" name="outsideNo" type="text" style="width: 150px" class="inputxt" value='${tPmProjectPage.outsideNo}'> <span
                  class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">外来编号</label></td>
                <td align="right"><label class="Validform_label"> 是否需要鉴定: </label></td>
                <td class="value"><t:codeTypeSelect id="appraisalFlag" name="appraisalFlag" code="SFBZ" codeType="0" type="radio" defaultVal="${tPmProjectPage.appraisalFlag}"></t:codeTypeSelect>
                  <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">是否需要鉴定</label></td>
              </tr>
              <tr>
              	<td align="right">
              	  <label class="Validform_label"> 项目来源: </label>
            	</td>
            	<td class="value">
                  <input id="projectSource" name="projectSource" type="text" style="width: 160px" class="inputxt" value='${tPmProjectPage.projectSource}'>
              	  <span class="Validform_checktip"></span>
                  <label class="Validform_label" style="display: none;">项目来源</label>
            	</td>
                <td align="right"><label class="Validform_label"> 来源单位: <font color="red">*</font></label></td>
                <td class="value">
            	<script type="text/javascript">
            		$(document).ready(function() {
            			$("#sourceUnit").autocomplete("tPmProjectController.do?getAutoSourceUnitList",{
            				max: 50,
            				minChars: 1,
            				width: 150,
            				scrollHeight: 300,
            				matchContains: true,
            				autoFill: false,
            				extraParams:{
            					maxRows : 10,
            					searchField : "name",
            					trem: getsourceUnitTremValue
            				},
            				parse:function(data){
            					return sourceUnitParse.call(this,data);
            				},
            				formatItem:function(row, i, max){
            					return sourceUnitFormatItem.call(this,row, i, max);
            				} 
            			}).result(function (event, row, formatted) {
            				sourceUnitCallBack.call(this,row); 
            			}); 
            		});
            		function getsourceUnitTremValue(){
            			return $("#sourceUnit").val();
            		}
            	</script>
            	<input type="text" id="sourceUnit" name="sourceUnit" style="width:150px;" datatype="byterange" max="2000" min="1" nullmsg="" errormsg="数据不存在,请重新输入" value="${tPmProjectPage.sourceUnit}">
				<span class="Validform_checktip"></span> 
				<label class="Validform_label" style="display: none;">来源单位</label></td>
<%--                 <td class="value"><input id="sourceUnit" name="sourceUnit" type="text" style="width: 330px" class="inputxt" value='${tPmProjectPage.sourceUnit}' datatype="*"> <span --%>
<!--                   class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">来源单位</label></td> -->
                <td align="right"><label class="Validform_label"> 是否合并其他项目: </label></td>
                <td class="value"><t:codeTypeSelect id="mergeFlag" name="mergeFlag" code="SFBZ" codeType="0" type="radio" defaultVal="0"
                extendParam="{onclick:'selectProject(this.value);'}"></t:codeTypeSelect> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">项目编号</label></td>
              </tr>
              <tr id="merge" style="display: none;">
            	<td align="right"><label class="Validform_label"> 合并项目:<font color="red">*</font></label></td>
            	<td class="value" colspan="3" ><input type="hidden" id="mergePId" name="mergePId"> <textarea wrap="off" id="mergePName" name="mergePName" type="text"
                	style="width: 300px; height: 40px;" class="inputxt" readonly="readonly"></textarea>
              	<t:chooseProject inputId="mergePId" inputName="mergePName" title="合并项目" isclear="true"></t:chooseProject> <%-- <t:choose url="tPmProjectController.do?projectMultipleSelect" name="processtree" icon="icon-search" title="项目列表" textname="id,projectName" inputTextname="mergePId,mergePName" isclear="true"></t:choose> --%></td>
          	  </tr>
              <tr>
                <c:if test="${!empty mergeProjList}">
                  <td align="right" width="15%"><label class="Validform_label"> 合并项目: </label></td>
                  <td colspan="5" class="value">
                    <table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
                      <tr>
                        <td colspan="3" class="value" width="85%"><c:forEach items="${mergeProjList}" var="s">
                            <a href="javascript:godetail('${s.id}');">${s.projectName}</a>
                          </c:forEach></td>
                      </tr>
                    </table>
                  </td>
                </c:if>
              </tr>
              <tr>
                <td align="right"><label class="Validform_label"> 机关主管参谋: </label><font color="red">*</font></td>
                <td class="value"><input type="text" id="officeStaffRealname" readonly style="width: 159px" class="inputxt" value="${officeStaffRealname}" datatype="*"> <input type="hidden" id="officeStaff"
                  name="officeStaff" value='${tPmProjectPage.officeStaff}'> <t:chooseUser icon="icon-search" title="人员列表" isclear="true" mode="single" idInput="officeStaff" textname="id,realName"  inputTextname="officeStaff,officeStaffRealname"></t:chooseUser> 
                  <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">机关主管参谋</label></td>
                <td align="right"><label class="Validform_label"> 院系主管参谋: </label></td>
                <td class="value"><input type="text" id="departStaffRealname" readonly style="width: 150px" class="inputxt" value='${departStaffRealname}'> <input type="hidden"
                  id="departStaff" name="departStaff" value='${tPmProjectPage.departStaff}'> <t:chooseUser icon="icon-search" title="人员列表" isclear="true" mode="single" idInput="departStaff"
                    textname="id,realName" inputTextname="departStaff,departStaffRealname"></t:chooseUser> <span class="Validform_checktip"></span> <label class="Validform_label"
                  style="display: none;">院系主管参谋</label></td>
                 <td align="right"><label class="Validform_label"> 是否需要认款: </label></td>
                 <td class="value">
                 <t:codeTypeSelect id="incomeApplyFlag" name="incomeApplyFlag" code="SFBZ" codeType="0" type="radio" defaultVal="${tPmProjectPage.incomeApplyFlag}" ></t:codeTypeSelect> 
                 <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">是否需要认款</label></td>
              </tr>
              <tr>
          		<td align="right"><label class="Validform_label"> 型号背景: </label></td>
          		<td class="value">
          			<input type="hidden" id="modelBackgroundStr" value='${tPmProjectPage.modelBackground}'>
                	<select id="modelBackground" class="easyui-combobox" name="modelBackground" style="width:200px; height:27px;">   
 
					</select>
            	</td>
            	<td align="right"><label class="Validform_label"> 舰艇舷号: </label></td>
            	<td class="value"><input id="shipNumber" name="shipNumber" type="text" class="easyui-numberbox" datatype="n0-5"
              		style="width: 200px; text-align: right;" value="${tPmProjectPage.shipNumber}"><span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">舰艇舷号</label></td>
              	<td align="right"><label class="Validform_label"> 配套情况: </label></td>
                <td class="value"><t:codeTypeSelect name="matchSituation" type="select" codeType="1" code="PTQK" id="matchSituation" labelText="请选择"
                    defaultVal="${tPmProjectPage.matchSituation}"></t:codeTypeSelect> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">配套情况</label></td>
          	  </tr>
          	  <tr>
          		<td align="right"><label class="Validform_label"> 审批权限: </label><font color="red">*</font></td>
          		<td class="value">
          			<t:codeTypeSelect name="approvalAuthority" type="select" codeType="1" code="SPQX" id="approvalAuthority" labelText="请选择" extendParam="{datatype:'*'}"
              defaultVal="${tPmProjectPage.approvalAuthority}"></t:codeTypeSelect> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">审批权限</label>	
            	</td>
          	   </tr>          	  
            </table>
          </div>
        </fieldset>
      </t:formvalid>
      <!-- -------------------项目组成员-------------华丽的分割线---------------------------------- -->
      <t:datagrid name="tPmProjectMemberList" checkbox="false" fitColumns="true" title="项目组成员" actionUrl="tPmProjectMemberController.do?datagrid&project.id=${tPmProjectPage.id }"
        onDblClick="dblClickDetail" idField="id" fit="true" queryMode="group">
        <t:dgCol title="主键" field="id" hidden="true" queryMode="group" width="120"></t:dgCol>
        <t:dgCol title="姓名" field="name" queryMode="single" isLike="true" query="true" width="120"></t:dgCol>
        <t:dgCol title="性别" field="sex" codeDict="0,SEX" queryMode="group" width="70"></t:dgCol>
        <t:dgCol title="出生年月" field="birthday" formatter="yyyy-MM-dd" queryMode="group" width="110" align="center"></t:dgCol>
        <t:dgCol title="学位" field="degree" codeDict="0,XWLB" query="true" queryMode="single" width="120"></t:dgCol>
        <t:dgCol title="职称职务" field="position" codeDict="0,PROFESSIONAL" queryMode="group" width="120"></t:dgCol>
        <t:dgCol title="任务分工" field="taskDivide" queryMode="group" width="120"></t:dgCol>
        <t:dgCol title="所属单位" field="superUnitName" queryMode="group" width="120"></t:dgCol>
        <t:dgCol title="是否负责人" field="projectManager" codeDict="0,SFBZ" queryMode="group" width="120"></t:dgCol>
        <t:dgToolBar title="查看" width="450" height="370" icon="icon-search" url="tPmProjectMemberController.do?goUpdate" funname="detail"></t:dgToolBar>
      </t:datagrid>
    </div>
  </div>
  </div>
</body>
<script src="webpage/com/kingtake/project/manage/tPmProject.js"></script>
<script type="text/javascript">
//双击查看方法
function dblClickDetail(rowIndex, rowData){
	var title = "查看";
	var url = "tPmProjectMemberController.do?goUpdate&load=detail&id=" + rowData.id;
	createdetailwindow(title,url,null,null);
}

</script>
<script src="webpage/com/kingtake/project/manage/project-edit.js"></script>