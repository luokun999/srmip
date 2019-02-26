package com.kingtake.project.entity.price;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.core.annotation.log.FieldDesc;
import org.jeecgframework.core.annotation.log.LogEntity;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 合同价款计价书--试验类计算书
 * @author onlineGenerator
 * @date 2015-08-20 11:11:36
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_pm_contract_price_trial", schema = "")
@LogEntity("合同价款计价书--试验类计算书")
@SuppressWarnings("serial")
public class TPmContractPriceTrialEntity implements java.io.Serializable {
	/**试验地点*/
	@Excel(name="试验地点")
	@FieldDesc("试验地点")
	private java.lang.String trialAddress;
	/**参试人员单位/部门*/
	@Excel(name="参试人员单位/部门")
	@FieldDesc("参试人员单位/部门")
	private java.lang.String trialDepart;
	/**报价栏*/
	@Excel(name="报价栏")
	@FieldDesc("报价栏")
	private Double priceAmount;
	/**审核栏*/
	@Excel(name="审核栏")
	@FieldDesc("审核栏")
	private Double auditAmount;
	/**所属父类别*/
	@Excel(name="所属父类别")
	@FieldDesc("所属父类别")
	private java.lang.String parentTypeid;
	/**备注*/
	@Excel(name="备注")
	@FieldDesc("备注")
	private java.lang.String memo;
	/**是否可添加子项*/
	@Excel(name="是否可添加子项")
	@FieldDesc("是否可添加子项")
	private java.lang.String addChildFlag;
	/**主键*/
	@FieldDesc("主键")
	private java.lang.String id;
	/**合同价_主键*/
	@Excel(name="合同价_主键")
	@FieldDesc("合同价_主键")
	private java.lang.String tpId;
	/**序号*/
	@Excel(name="序号")
	@FieldDesc("序号")
	private String serialNum;
	/**类别id*/
	@Excel(name="类别id")
	@FieldDesc("类别id")
	private java.lang.String typeId;
	/**类别名称（对应表格中的'项目'列）*/
	@Excel(name="类别名称（对应表格中的'项目'列）")
	@FieldDesc("类别名称（对应表格中的'项目'列）")
	private java.lang.String typeName;
	/**报价说明*/
	@Excel(name="报价说明")
	@FieldDesc("报价说明")
	private java.lang.String priceExplain;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  试验地点
	 */
	@Column(name ="TRIAL_ADDRESS",nullable=true,length=150)
	public java.lang.String getTrialAddress(){
		return this.trialAddress;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  试验地点
	 */
	public void setTrialAddress(java.lang.String trialAddress){
		this.trialAddress = trialAddress;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  参试人员单位/部门
	 */
	@Column(name ="TRIAL_DEPART",nullable=true,length=150)
	public java.lang.String getTrialDepart(){
		return this.trialDepart;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  参试人员单位/部门
	 */
	public void setTrialDepart(java.lang.String trialDepart){
		this.trialDepart = trialDepart;
	}
	/**
	 *方法: 取得Double
	 *@return: Double  报价栏
	 */
	@Column(name ="PRICE_AMOUNT",nullable=true,scale=2,length=10)
	public Double getPriceAmount(){
		return this.priceAmount;
	}

	/**
	 *方法: 设置Double
	 *@param: Double  报价栏
	 */
	public void setPriceAmount(Double priceAmount){
		this.priceAmount = priceAmount;
	}
	/**
	 *方法: 取得Double
	 *@return: Double  审核栏
	 */
	@Column(name ="AUDIT_AMOUNT",nullable=true,scale=2,length=10)
	public Double getAuditAmount(){
		return this.auditAmount;
	}

	/**
	 *方法: 设置Double
	 *@param: Double  审核栏
	 */
	public void setAuditAmount(Double auditAmount){
		this.auditAmount = auditAmount;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属父类别
	 */
	@Column(name ="PARENT_TYPEID",nullable=true,length=32)
	public java.lang.String getParentTypeid(){
		return this.parentTypeid;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属父类别
	 */
	public void setParentTypeid(java.lang.String parentTypeid){
		this.parentTypeid = parentTypeid;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注
	 */
	@Column(name ="MEMO",nullable=true,length=300)
	public java.lang.String getMemo(){
		return this.memo;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注
	 */
	public void setMemo(java.lang.String memo){
		this.memo = memo;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否可添加子项
	 */
	@Column(name ="ADD_CHILD_FLAG",nullable=true,length=1)
	public java.lang.String getAddChildFlag(){
		return this.addChildFlag;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否可添加子项
	 */
	public void setAddChildFlag(java.lang.String addChildFlag){
		this.addChildFlag = addChildFlag;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=32)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主键
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  合同价_主键
	 */
	@Column(name ="T_P_ID",nullable=true,length=32)
	public java.lang.String getTpId() {
		return tpId;
	}

	public void setTpId(java.lang.String tpId) {
		this.tpId = tpId;
	}
	
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  序号
	 */
	@Column(name = "SERIAL_NUM", nullable = true, length = 10)
	public String getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  类别id
	 */
	@Column(name ="TYPE_ID",nullable=true,length=32)
	public java.lang.String getTypeId() {
		return typeId;
	}

	public void setTypeId(java.lang.String typeId) {
		this.typeId = typeId;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  类别名称（对应表格中的'项目'列）
	 */
	@Column(name ="TYPE_NAME",nullable=true,length=30)
	public java.lang.String getTypeName() {
		return typeName;
	}

	public void setTypeName(java.lang.String typeName) {
		this.typeName = typeName;
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  报价说明
	 */
	@Column(name ="PRICE_EXPLAIN",nullable=true,length=200)
	public java.lang.String getPriceExplain(){
		return this.priceExplain;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  报价说明
	 */
	public void setPriceExplain(java.lang.String priceExplain){
		this.priceExplain = priceExplain;
	}
}