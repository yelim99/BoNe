<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<script>
	alert('${exception.message}');
	history.back();
</script>    
