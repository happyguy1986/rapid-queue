<%@page import="com.google.code.rapid.queue.metastore.model.*" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/simpletable" prefix="simpletable"%>
<%@ include file="/commons/taglibs.jsp" %>

<rapid:override name="head">
	<title>Exchange 维护</title>
	
	<script src="${ctx}/js/rest.js" ></script>
	<link href="<c:url value="/widgets/simpletable/simpletable.css"/>" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<c:url value="/widgets/simpletable/simpletable.js"/>"></script>
	
	<script type="text/javascript" >
		$(document).ready(function() {
			// 分页需要依赖的初始化动作
			window.simpleTable = new SimpleTable('queryForm',${page.paginator.page},${page.paginator.pageSize},'${pageRequest.sortColumns}');
		});
	</script>
</rapid:override>

<rapid:override name="content">
	<form id="queryForm" name="queryForm" method="get" style="display: inline;">
	<div class="queryPanel">
		<fieldset>
			<legend>搜索</legend>
			<table>
				<tr>	
					<td class="tdLabel">vhostName</td>		
					<td>
						<input value="${query.vhostName}" id="vhostName" name="vhostName" maxlength="200"  class=""/>
					</td>
					<td class="tdLabel">exchangeName</td>		
					<td>
						<input value="${query.exchangeName}" id="exchangeName" name="exchangeName" maxlength="30"  class=""/>
					</td>
				</tr>				
				<tr>	
					<td class="tdLabel">备注</td>		
					<td>
						<input value="${query.remarks}" id="remarks" name="remarks" maxlength="200"  class=""/>
					</td>
					<td class="tdLabel">持久模式</td>		
					<td>
						<input value="${query.durableType}" id="durableType" name="durableType" maxlength="30"  class=""/>
					</td>
					<td class="tdLabel">是否自动删除</td>		
					<td>
						<input value="${query.autoDelete}" id="autoDelete" name="autoDelete" maxlength="3"  class="validate-integer max-value-2147483647"/>
					</td>
					<td class="tdLabel">自动删除的时过期时长，单位毫秒</td>		
					<td>
						<input value="${query.autoDeleteExpires}" id="autoDeleteExpires" name="autoDeleteExpires" maxlength="19"  class="validate-integer "/>
					</td>
				</tr>	
				<tr>	
					<td class="tdLabel">类型</td>		
					<td>
						<input value="${query.type}" id="type" name="type" maxlength="30"  class=""/>
					</td>
					<td class="tdLabel">当前交换机大小</td>		
					<td>
						<input value="${query.size}" id="size" name="size" maxlength="10"  class="validate-integer max-value-2147483647"/>
					</td>
					<td class="tdLabel">半持久模式:内存元素大小</td>		
					<td>
						<input value="${query.memorySize}" id="memorySize" name="memorySize" maxlength="10"  class="validate-integer max-value-2147483647"/>
					</td>
					<td class="tdLabel">交换机的大小</td>		
					<td>
						<input value="${query.maxSize}" id="maxSize" name="maxSize" maxlength="10"  class="validate-integer max-value-2147483647"/>
					</td>
				</tr>	
				<tr>	
					<td class="tdLabel">创建时间</td>		
					<td>
						<input value="<fmt:formatDate value='${query.createdTimeBegin}' pattern='yyyy-MM-dd'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="createdTimeBegin" name="createdTimeBegin"   />
						<input value="<fmt:formatDate value='${query.createdTimeEnd}' pattern='yyyy-MM-dd'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="createdTimeEnd" name="createdTimeEnd"   />
					</td>
					<td class="tdLabel">操作人员</td>		
					<td>
						<input value="${query.operator}" id="operator" name="operator" maxlength="50"  class=""/>
					</td>
					<td class="tdLabel">最后更新时间</td>		
					<td>
						<input value="<fmt:formatDate value='${query.lastUpdatedTimeBegin}' pattern='yyyy-MM-dd'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="lastUpdatedTimeBegin" name="lastUpdatedTimeBegin"   />
						<input value="<fmt:formatDate value='${query.lastUpdatedTimeEnd}' pattern='yyyy-MM-dd'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="lastUpdatedTimeEnd" name="lastUpdatedTimeEnd"   />
					</td>
				</tr>	
			</table>
		</fieldset>
		<div class="handleControl">
			<input type="submit" class="stdButton" style="width:80px" value="查询" onclick="getReferenceForm(this).action='${ctx}/exchange/index.do'"/>
			<input type="button" class="stdButton" style="width:80px" value="新增" onclick="window.location = '${ctx}/exchange/add.do?vhostName=${query.vhostName}'"/>
		<div>
	
	</div>
	
	<div class="gridTable">
	
		<simpletable:pageToolbar paginator="${page.paginator}">
		显示在这里是为了提示你如何自定义表头,可修改模板删除此行
		</simpletable:pageToolbar>
	
		<table width="100%"  border="0" cellspacing="0" class="gridBody">
		  <thead>
			  
			  <tr>
				<th style="width:1px;"> </th>
				
				<!-- 排序时为th增加sortColumn即可,new SimpleTable('sortColumns')会为tableHeader自动增加排序功能; -->
				<th sortColumn="vhost_name" >虚拟host</th>
				<th sortColumn="exchange_name" >交换机名称</th>
				<th sortColumn="remarks" >备注</th>
				<th sortColumn="durable_type" >持久模式</th>
				<th sortColumn="size" >当前交换机大小</th>
				<th sortColumn="memory_size" >半持久模式:内存元素大小</th>
				<th sortColumn="max_size" >交换机最大大小</th>
				<th sortColumn="enabled" >是否激活</th>
				<!-- 
				<th sortColumn="auto_delete" >是否自动删除</th>
				<th sortColumn="auto_delete_expires" >自动删除的时过期时长，单位毫秒</th>
				<th sortColumn="type" >类型: topic,fanout,direct</th>
				<th sortColumn="created_time" >创建时间</th>
				<th sortColumn="operator" >操作人员</th>
				<th sortColumn="last_updated_time" >最后更新时间</th>
				 -->
	
				<th>操作</th>
			  </tr>
			  
		  </thead>
		  <tbody>
		  	  <c:forEach items="${page.itemList}" var="item" varStatus="status">
		  	  
			  <tr class="${status.count % 2 == 0 ? 'odd' : 'even'}">
				<td>${page.paginator.startRow + status.index}</td>
				
				<td><c:out value='${item.vhostName}'/>&nbsp;</td>
				<td><c:out value='${item.exchangeName}'/>&nbsp;</td>
				<td><c:out value='${item.remarks}'/>&nbsp;</td>
				<td><c:out value='${item.durableType}'/>&nbsp;</td>
				<td><c:out value='${item.size}'/>&nbsp;</td>
				<td><c:out value='${item.memorySize}'/>&nbsp;</td>
				<td><c:out value='${item.maxSize}'/>&nbsp;</td>
				<td><c:out value='${item.enabled}'/>&nbsp;</td>

				<!-- 
				<td><c:out value='${item.autoDelete}'/>&nbsp;</td>
				<td><c:out value='${item.autoDeleteExpires}'/>&nbsp;</td>
				<td><c:out value='${item.type}'/>&nbsp;</td>
				<td><fmt:formatDate value='${item.createdTime}' pattern='yyyy-MM-dd'/>&nbsp;</td>
				<td><c:out value='${item.operator}'/>&nbsp;</td>
				<td><fmt:formatDate value='${item.lastUpdatedTime}' pattern='yyyy-MM-dd'/>&nbsp;</td>
				 -->				
				<td>
					<a href="${ctx}/binding/index.do?exchangeName=${item.exchangeName}&vhostName=${item.vhostName}">管理binding</a>&nbsp;&nbsp;
					<a href="${ctx}/exchange/show.do?exchangeName=${item.exchangeName}&vhostName=${item.vhostName}">查看</a>&nbsp;&nbsp;
					<a href="${ctx}/exchange/edit.do?exchangeName=${item.exchangeName}&vhostName=${item.vhostName}">修改</a>&nbsp;&nbsp;
					<a href="${ctx}/exchange/delete.do?exchangeName=${item.exchangeName}&vhostName=${item.vhostName}" onclick="doRestDelete(this,'你确认删除?');return false;">删除</a>
				</td>
			  </tr>
			  
		  	  </c:forEach>
		  </tbody>
		</table>
	
		<simpletable:pageToolbar paginator="${page.paginator}">
		显示在这里是为了提示你如何自定义表头,可修改模板删除此行
		</simpletable:pageToolbar>
		
	</div>
	</form>
</rapid:override>

<%-- jsp模板继承,具体使用请查看: http://code.google.com/p/rapid-framework/wiki/rapid_jsp_extends --%>
<%@ include file="base.jsp" %>

