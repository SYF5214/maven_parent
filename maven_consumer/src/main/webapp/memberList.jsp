<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/mystyle.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	<table id="memberTable"></table>
	
	<div id="tabToolBar">
		    <input type="button" class="btn btn-success" value="新增" onclick="addMember()">
		    <input type="button" class="btn btn-default" value="修改" onclick="editMember()">
		    <input type="button" class="btn btn-error"   value="批量删除" onclick="deleteMember()">
	</div>
	
<script type="text/javascript">

//发送ajax请求获取jsp页面内容
function getJspHtml(urlStr){
	//async  (默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。
	//注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
	 var jspHtml = "";
		$.ajax({
			url:urlStr,
			type:'post',
			//同步的ajax
			async:false,
			success:function(data){
				//alert(data);//data--addProduct.jsp页面内容
				jspHtml = data;
			},
			error:function(){
				bootbox.alert("ajax失败");
			}
		});
	return jspHtml;
}

//批量新增  修改 弹框
function  dialog(HTMLurl,submitUrl,title){
	var dialog = bootbox.dialog({
		title: title,
	    message: getJspHtml(HTMLurl),   //调用方法  
	    buttons:{
  				"save":{
				  label: '保存',
				  //自定义样式
				  className: "btn-success",
				  callback: function() {
						$.ajax({
							url:submitUrl,
							type:'post',
							data:$('#member_dialog_form').serialize(),
							success:function(){
									bootbox.alert("保存成功");
							$("#memberTable").bootstrapTable('refresh');
							},
							error:function(){
								bootbox.alert("ajax失败");
							}
						});
				  }
				},
				"unSave":{
					  label: '取消',
					  //自定义样式
					  className: "btn-info",
					  callback: function() {
						 // return false;  //dialog不关闭
					  }
					}
			}
	});
}

//新增
function addMember(){
	dialog("<%=request.getContextPath()%>/member/toMemberDialog.do","<%=request.getContextPath()%>/member/submitMember.do","会员新增")
}

//修改
function editMember(){
	var memberArray = $("[name='chk']:checked");
	var ids = "";
	if(memberArray.length == 0){
		alert("请选择数据！！！")
	}else{
		for (var i = 0; i < memberArray.length; i++) {
			ids += memberArray[i].value;
		}
		dialog("<%=request.getContextPath()%>/member/toMemberDialog.do?ids="+ids,"<%=request.getContextPath()%>/member/submitMember.do","会员修改");
	}
}

//批量删除
function deleteMember(){
	var memberArray = $("[name='chk']:checked");
	var ids = "";
	for (var i = 0; i < memberArray.length; i++) {
		ids += "," + memberArray[i].value;
	}
	ids = ids.substring(1);
	$.ajax({
		url:"<%=request.getContextPath()%>/member/deleteMember.do?ids="+ids,
		type:"post",
		success:function(){
			$("#memberTable").bootstrapTable('refresh');
		},
		error:function(){
			
		}
	})
}

//列表
$(function (){
	$("#memberTable").bootstrapTable({
		 url:"<%=request.getContextPath()%>/member/selectMember.do",	
		 method:"post",
		 striped: true,  			// 斑马线效果     默认false 
		 //只允许选中一行
		 singleSelect:true,
		 //选中行是不选中复选框或者单选按钮
		 clickToSelect:true,
		 showToggle:true,           //是否显示详细视图和列表视图的切换按钮
		 cardView: false,           //是否显示详细视图
		 uniqueId: "id",            //每一行的唯一标识，一般为主键列
		 showColumns: true,         //是否显示所有的列
		 showRefresh: true,         //是否显示刷新按钮
		 minimumCountColumns: 2,    //  最少留两列
		 detailView: false,         //是否显示父子表
		 //发送到服务器的数据编码类型  
		contentType:'application/x-www-form-urlencoded;charset=UTF-8', //数据编码纯文本  offset=0&limit=5
		toolbar:'#tabToolBar',  	//工具定义位置
		columns:[
				{field:'memberId',title:'序号',align:"center",
					formatter:function(value,row,index){   		//格式化当前单元格内容
						return "<input type='checkbox' value="+value+" name='chk'/>";
					}
				},
				{field:'memberName',title:'会员名称',align:"center"},
				{field:'memberAge',title:'会员年龄',align:"center"},
				{field:'memberBirthday',title:'生日',align:"center"},
				{field:'memberSex',title:'性别',align:"center",
					formatter:function(value,row,index){   		//格式化当前单元格内容
						if(value == 1){
							return "男";
						}
						if(value == 2){
							return "女";
						}
					}	
				},
				{field:'memberPhone',title:'手机号码',align:"center"},
				{field:'memberLevel',title:'会员等级',align:"center",
					formatter:function(value,row,index){   		//格式化当前单元格内容
						if(value == 1){
							return "青铜会员";
						}
						if(value == 2){
							return "白银会员";
						}
						if(value == 3){
							return "黄金会员";
						}
						if(value == 4){
							return "钻石会员";
						}
					}		
				},
		         ],
				//传递参数（*）
				queryParams: function(params) {
					var whereParams = {    
					//分页  自定义的参数	默认传 limit(展示几条)	offset（从第几条开始    起始条数）           
					"pageSize":params.limit,
					"start":params.offset,
					//"pro_name":params.search,//精确搜索产品名称
					}
						 return whereParams;
				},
					 //前台--排序字段
					 //sortName:'proPrice',
					 //sortOrder:'desc',
					 //前台--搜索框
					 search:true,
					 //启动回车键做搜索功能
					 searchOnEnterKey:true,
			   	     //分页方式   后台请求的分页方式
					 sidePagination:'server',
					 pagination: true,           //是否显示分页（*）
					 pageNum: 1,                 //每页的记录行数（*）
					 pageSize: 3,                //每页的记录行数（*）
					 pageList: [3,6,9,12],       //可供选择的每页的行数（*）
	})
})

</script>
</body>
</html>