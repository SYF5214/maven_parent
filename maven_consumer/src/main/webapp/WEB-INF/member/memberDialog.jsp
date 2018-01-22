<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id="member_dialog_form">
	<input type="hidden" name="memberId" value="${member.memberId}">
	<div id="div_table">
		<div class="form-group">
			<label>会员名称</label>
			<input type="text" class="form-control" value="${member.memberName}"  name="memberName">
		</div>
		<div class="form-group">
			<label>会员年龄</label>
			<input type="text" class="form-control" value="${member.memberAge}"  name="memberAge">
		</div>
		<div class="form-group">
			<label>会员性别</label>&nbsp;&nbsp;
			<input type="radio" value="1" name="memberSex" <c:if test="${member.memberLevel == 1}">checked</c:if>>男&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" value="2" name="memberSex" <c:if test="${member.memberLevel == 2}">checked</c:if>>女
		</div>
		
		<div class="form-group">
			<label>会员级别</label>
			<select name="memberLevel" class="form-control">
				<option value="-1">--请选择--</option>
				<option value="1" <c:if test="${member.memberLevel == 1}">selected</c:if>>青铜会员</option>
				<option value="2" <c:if test="${member.memberLevel == 2}">selected</c:if>>白银会员</option>
				<option value="3" <c:if test="${member.memberLevel == 3}">selected</c:if>>黄金会员</option>
				<option value="4" <c:if test="${member.memberLevel == 4}">selected</c:if>>钻石会员</option>
			</select>
		</div>
		<div class="form-group">
			<label>会员电话</label>
			<input type="text" name="memberPhone" value="${member.memberPhone}" class="form-control"/>
		</div>
		<div class="form-group">
		    <label>会员生日</label>
		    <input type="text" class="form-control" name="memberBirthday" value="<fmt:formatDate value='${member.memberBirthday}' pattern='yyyy-MM-dd'/>" onClick="WdatePicker()" />
		</div>
	</div>
</form>
</body>
</html>