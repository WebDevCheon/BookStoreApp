<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
				<c:if test = "${bigclass eq 'novel'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'economy'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<option value="economy">경제/경영</option>
    					<option value="novel">소설</option>
    					<option value="humanity">인문</option>
   						<option value="religion">종교</option>
   						<option value="science">과학</option>
   						<option value="politics">정치/사회</option>
   						<option value="children">어린이</option>
   						<option value="computer">컴퓨터/IT</option>
						<option value="cook">요리</option>
   						<option value="textbook">교과서/참고서</option>
   						<option value="foreign">외국어</option>
   						<option value="cartoon">만화</option>
   						<option value="magazine">잡지</option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'humanity'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="humanity">인문</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'religion'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
					   	<sf:option value="religion">종교</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'science'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="science">과학</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'politics'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="politics">정치/사회</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'children'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="children">어린이</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'computer'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="computer">컴퓨터/IT</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'cook'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="cook">요리</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'textbook'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="textbook">교과서/참고서</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'foreign'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="foreign">외국어</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'cartoon'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="cartoon">만화</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="magazine">잡지</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'magazine'}">
				<td>
					<sf:select path="bigclass" style = "padding-bottom:3px;" id="bigclass" onchange = "moveurl()">
    					<sf:option value="magazine">잡지</sf:option>
    					<sf:option value="novel">소설</sf:option>
    					<sf:option value="economy">경제/경영</sf:option>
    					<sf:option value="humanity">인문</sf:option>
   						<sf:option value="religion">종교</sf:option>
   						<sf:option value="science">과학</sf:option>
   						<sf:option value="politics">정치/사회</sf:option>
   						<sf:option value="children">어린이</sf:option>
   						<sf:option value="computer">컴퓨터/IT</sf:option>
						<sf:option value="cook">요리</sf:option>
   						<sf:option value="textbook">교과서/참고서</sf:option>
   						<sf:option value="foreign">외국어</sf:option>
   						<sf:option value="cartoon">만화</sf:option>
					</sf:select>
				</td>
				</c:if>
</body>
</html>