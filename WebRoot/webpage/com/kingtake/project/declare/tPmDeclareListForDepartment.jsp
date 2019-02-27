<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding: 1px;">
    <t:datagrid name="tPmDeclareList" checkbox="true" fitColumns="true" actionUrl="tPmDeclareController.do?datagridDepartement&businessCode=declare" idField="id" fit="true" queryMode="group" pagination="false" onDblClick="dblDetail">
      <t:dgCol title="主键" field="id" hidden="true" queryMode="group" width="120"></t:dgCol>
      <t:dgCol title="项目id" field="projectId" hidden="true" ></t:dgCol>
      <t:dgCol title="项目名称" field="projectName" query="true" isLike="true" queryMode="single" width="120"></t:dgCol>
      <t:dgCol title="项目类型" field="projectType" queryMode="group" width="90" align="center"></t:dgCol>
      <t:dgCol title="流程流转状态" field="bpmStatus" hidden="true" queryMode="group" width="120"></t:dgCol>
      <t:dgCol title="流程实例id" field="processInstId" hidden="true" width="120"></t:dgCol>
      <t:dgCol title="申报人姓名" field="submitUser" queryMode="group" width="120"></t:dgCol>
      <t:dgCol title="申报时间" field="submitTime" formatter="yyyy-MM-dd" hidden="true" queryMode="group" width="90" align="center"></t:dgCol>
      <t:dgCol title="任务id" field="taskId" hidden="true" width="40"></t:dgCol>
      <t:dgCol title="任务名称" field="taskName" hidden="true" width="40"></t:dgCol>
      <t:dgCol title="处理人" field="assigneeName" hidden="true" queryMode="group" width="70"></t:dgCol>
      <t:dgCol title="操作" field="opt" width="120" frozenColumn="true"></t:dgCol>
      <t:dgFunOpt title="查看流程" exp="bpmStatus#ne#1" funname="viewHistory(processInstId)" />
      <t:dgConfOpt exp="assigneeName#empty#true" url="activitiController.do?claim&taskId={taskId}" message="确定签收?" title="签收"></t:dgConfOpt>
      <t:dgFunOpt exp="assigneeName#empty#false" funname="openhandleMix(taskId,taskName)" title="办理"></t:dgFunOpt>
      <t:dgFunOpt exp="assigneeName#empty#false" funname="selectEntruster(taskId,taskName)" title="委托"></t:dgFunOpt>
    </t:datagrid>
  </div>
</div>
<script src="webpage/com/kingtake/project/declare/tPmDeclareList.js"></script>
<script type="text/javascript">
    $(document).ready(
            function() {

                //给时间控件加上样式
                $("#tPmDeclareListtb").find("input[name='beginDate_begin']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
                $("#tPmDeclareListtb").find("input[name='beginDate_end']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
                $("#tPmDeclareListtb").find("input[name='endDate_begin']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
                $("#tPmDeclareListtb").find("input[name='endDate_end']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
                $("#tPmDeclareListtb").find("input[name='createDate_begin']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
                $("#tPmDeclareListtb").find("input[name='createDate_end']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
                $("#tPmDeclareListtb").find("input[name='updateDate_begin']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
                $("#tPmDeclareListtb").find("input[name='updateDate_end']").attr("class", "Wdate").attr("style",
                        "height:20px;width:90px;").click(function() {
                    WdatePicker({
                        dateFmt : 'yyyy-MM-dd'
                    });
                });
            });

    //导入
    function ImportXls() {
        openuploadwin('Excel导入', 'tPmDeclareController.do?upload', "tPmDeclareList");
    }

    //导出
    function ExportXls() {
        JeecgExcelExport("tPmDeclareController.do?exportXls", "tPmDeclareList");
    }

    //模板下载
    function ExportXlsByT() {
        JeecgExcelExport("tPmDeclareController.do?exportXlsByT", "tPmDeclareList");
    }
    //提交流程
    function startProcess(id, name) {
        //业务表名
        var tableName = 't_b_pm_declare';
        var businessName = name;
        //流程对应表单URL
        var formUrl = 'tPmDeclareController.do?goUpdateForDepartment';
        dialogConfirm('activitiController.do?startProcess&id=' + id + '&tableName=' + tableName + '&formUrl=' + formUrl
                + '&businessName=' + businessName, '确定提交流程吗？', 'tPmDeclareList');
    }

    //查看流程
    function viewHistory(processInstanceId) {
        var url = "";
        var title = "流程历史";
        url = "activitiController.do?viewProcessInstanceHistory&processInstanceId=" + processInstanceId + "&isIframe"
        addOneTab(title, url);
    }
    
    function dblDetail(rowIndex, rowDate) {
        var title = "查看";
        var width = '100%';
        var height = '100%';
        var url = "tPmDeclareController.do?tPmDeclareForResearchGroup&load=detail&projectId=" + rowDate.projectId;
        createdetailwindow(title, url, width, height);
    }
</script>