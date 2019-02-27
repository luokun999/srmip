<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="tBJgKyList" checkbox="true" fitColumns="false" title="科研价格库" actionUrl="tBJgKyController.do?datagrid" 
  idField="id" fit="true" queryMode="group" onDblClick="dblDetail" sortName="createDate" sortOrder="asc">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="种类"  field="fl"   query="true" isLike="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="名称"  field="mc"   query="true" isLike="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="规格型号"  field="ggxh" query="true" isLike="true"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="计量单位"  field="jldw" query="true" isLike="true"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="单价"  field="dj"    align="right"   queryMode="single"  extendParams="formatter:formatCurrency,"  width="120"></t:dgCol>
   <t:dgCol title="采购单位"  field="cgdw"  query="true" isLike="true"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="采购时间"  field="cgsj" align="center" formatter="yyyy-MM-dd"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="生产厂家"  field="sccj"  query="true" isLike="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="来源"  field="ly"  query="true" isLike="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="来源项目"  field="lyxm"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="备注"  field="beiz"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tBJgKyController.do?doDel&id={id}" />
   <t:dgToolBar title="录入" icon="icon-add" url="tBJgKyController.do?goUpdate" height="500" width="750" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tBJgKyController.do?goUpdate" height="500" width="750" funname="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tBJgKyController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tBJgKyController.do?goUpdate" height="500" width="750" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/com/kingtake/tbjgky/tBJgKyList.js"></script>		
 <script type="text/javascript" src="webpage/common/util.js"></script>  
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#tBJgKyListtb").find("input[name='createDate']").attr("class","Wdate").attr("style","height:20px;width:90px;").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#tBJgKyListtb").find("input[name='updateDate']").attr("class","Wdate").attr("style","height:20px;width:90px;").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
 //双击查看详情
 function dblDetail(rowIndex, rowDate){
	 var title = "查看";
	 var width = 750;
	 var height = 500;
	 var url = "tBJgKyController.do?goUpdate&load=detail&id=" +rowDate.id;
	 createdetailwindow(title,url,width,height);	 
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tBJgKyController.do?upload', "tBJgKyList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tBJgKyController.do?exportXls","tBJgKyList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tBJgKyController.do?exportXlsByT","tBJgKyList");
}
 </script>