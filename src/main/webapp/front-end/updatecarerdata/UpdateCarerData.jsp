<%@page import="com.file.model.FileVO"%>
<%@page import="com.file.model.FileService"%>
<%@page import="com.careskills.model.CareSkillsVO"%>
<%@page import="com.carermem.model.CarerMemDAOImpl"%>
<%@page import="com.carermem.model.CarerMemDAO"%>
<%@page import="com.carermem.model.CarerMemVO"%>
<%@page import="com.carermem.model.CarerMemService"%>
<%@page import="com.member.model.vo.MemberVO"%>
<%@page import="com.member.model.dao.impl.MemberDaoImpl"%>
<%@page import="com.member.model.dao.MemberDao"%>
<%@page import="com.carermemapply.model.*"%>
<%@page import="com.skill.model.*"%>
<%@page import="com.bank.model.*"%>
<%@page import="java.util.List"%>
<%@page import="com.common.model.service.JWTokenUtils"%>
<%@page import="com.utils.DecodeCookieUtil"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
BankDAOImpl bankDaoImpl = new BankDAOImpl();
List<BankVO> list1 = bankDaoImpl.getAll();
pageContext.setAttribute("list1", list1);
%>
<%
SkillDAOImpl skillDaoImpl = new SkillDAOImpl();
List<SkillVO> list2 = skillDaoImpl.getAll();
pageContext.setAttribute("list2", list2);
%>
<%
CarerMemApplyVO carerMemApplyVo = (CarerMemApplyVO) request.getAttribute("carerMemApplyVo");
%>
<%
CarerMemVO carerMemVo2 = (CarerMemVO) request.getAttribute("carerMemVo2");
%>
<%
Integer carerID = (int) DecodeCookieUtil.getMemId(request);

CarerMemService cmSvc = new CarerMemService();
CarerMemVO carerMemVo = cmSvc.selectOneCarer(carerID);
pageContext.setAttribute("carerMemVo", carerMemVo);
%>
<%
SkillService sSvc = new SkillService();
List<SkillVO> skillList = sSvc.getOneCarerSkills(carerID);
pageContext.setAttribute("skillList", skillList);
%>

<jsp:useBean id="photoresult" scope="request" type="java.util.List<FileVO>" />

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>????????????????????? - DailyWarm</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="../assets/healthcare.png" />
<!-- Bootstrap Icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic"
	rel="stylesheet" type="text/css" />
<!-- SimpleLightbox plugin CSS-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../css/styles.css" rel="stylesheet" />
</head>
<body>

	<!-- Navigation ????????? -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top1 py-3" id="mainNav">
        <div class="container px-4 px-lg-0">
            <a class="navbar-brand" href="../Carer.jsp">Daily Warm</a>
            <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ms-auto my-2 my-lg-0">

                    <!-- ?????? -->
                    <li class="nav-item"><a class="nav-link" href="../Carer.jsp">??????</a></li>
                    <!-- ???????????? -->
                    <li class="nav-item">
      <a class="nav-link" 
       href="<%=request.getContextPath()%>/front-end/updatecarerdata/showCarerData.do?action=showCarerData&carerID=<%=carerID%>">??????????????????</a>
     </li>
                    <!-- ???????????? -->
                    <li class="nav-item"><a class="nav-link" href="../careRequest/requestSearch.jsp">????????????</a></li>
                    <!-- ???????????? -->
                    <li class="nav-item"><a class="nav-link" href="../careordermgt/CareOrderMgt.jsp">????????????</a></li>
                    <!-- ?????????????????? -->
                    <li class="nav-item"><a class="nav-link" href="../member/setMemData.html">??????????????????</a></li>
                    <!-- ?????? -->
                    <li class="nav-item"><a class="nav-link" href="../mailbox/noticeCenter.jsp">??????</a></li>
                    <!-- ?????? -->
                    <li class="nav-item dropdown">
                        <a class="nav-link" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            <i class="fas fa-user-circle fa-2x "></i>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" id="switchAcct" href="../afterlogin.jsp" >????????????</a></li>
                            <li><a class="dropdown-item" id="logout">??????</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
	<header>
	
	</header>
	<!-- Services ???????????? -->
	<div style="height: 70px"></div>
	<section class="page-section bg-primary" id="services">

		<div class="container px-md-5">

				<div class="col-md-7 col-lg-8">

					<%-- ???????????? --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color: red">?????????????????????:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color: red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>

					<form class="needs-validation" METHOD="post"
						ACTION="showCarerData.do" enctype="multipart/form-data">
						<div class="row g-3">

							

							<h4 class="mb-3"><font size="6"><b>??????????????????</b></font></h4>
							<hr class="my-4">

							<div>
								<label for="carerAcct" class="form-label"><font size="4.5" color="#7a472c"><b>??????</b></font></label>
								<input type="text" class="form-control" id="carerAcct" style="width:41%;"
									value="${carerMemVo.carerAcct}" readonly>
							</div>
							<div class="col-sm-8">
							<br>
								<label for="serviceTpye" class="form-label"><font size="4.5" color="#7a472c"><b>????????????&nbsp;&nbsp;</b></font></label>
								
								<input type="radio" name="serviceTpye" id="home" value="0"
									${(carerMemVo.serviceType == 0) ? 'checked' : ''}> 
								<label for="home">????????????</label>
								
								<input type="radio" name="serviceTpye" id="hospital" value="1"
									${(carerMemVo.serviceType == 1) ? 'checked' : ''}>
								<label for="hospital">????????????</label> 
								
								<input type="radio" name="serviceTpye" id="all" value="2"
									${(carerMemVo.serviceType == 2) ? 'checked' : ''}> 
								<label for="all">??????</label>
							</div>

							<div class="col-md-5">
								<label for="country" class="form-label"><font size="4.5" color="#7a472c"><b>????????????</b></font></label> 
								<select class="form-select" id="county" required>
									<option value="">???????????????</option>
								</select>
							</div>
							<div class="col-md-5">
								<label for="district" class="form-label"><font size="4.5" color="#7a472c"><b>????????????</b></font></label> 
								<select class="form-select" id="district" name="district" required>
									<option value="">???????????????</option>
								</select>
							</div>

							<div class="col-sm-8">
								<label><font size="4.5" color="#7a472c"><b>???????????????(????????????)</b></font></label><br>
								<c:forEach var="SkillVO" items="${list2}">
									<c:if test="${SkillVO.skillType == '0'}">
										<label> 
											<input type="checkbox" name="commSkill"
											value="${SkillVO.skillNo}" id="${SkillVO.skillNo}">${SkillVO.skillName}
										</label><br>
									</c:if>
								</c:forEach>
							</div>
							<br>
							<div class="col-sm-8">
								<label><font size="4.5" color="#7a472c"><b>???????????????(????????????)</b></font></label><br>
								<c:forEach var="SkillVO" items="${list2}">
									<c:if test="${SkillVO.skillType == '1'}">
										<label> <input type="checkbox" name="ProSkill"
											value="${SkillVO.skillNo}" id="${SkillVO.skillNo}">${SkillVO.skillName}
										</label><br>
									</c:if>
								</c:forEach>
							</div>
							
							<hr class="my-4">

							<div class="col-sm-7">
								<h4 class="mb-3"><font size="6"><b>????????????</b></font></h4>

								<label for="priceHour" class="form-label"><font size="4.5" color="#7a472c"><b>??????12???????????????</b></font></label> 
								<input type="text" class="form-control" id="priceHour"
									name="priceHour" placeholder="" value="${carerMemVo.priceHour.intValue()}" required>
									 
								<label for="priceHalfDay" class="form-label"><font size="4.5" color="#7a472c"><b>12-24???????????????</b></font></label> 
								<input type="text" class="form-control" id="priceHalfDay"
									name="priceHalfDay" placeholder="" value="${carerMemVo.priceHalfday.intValue()}" required>
									 
								<label for="priceDay" class="form-label"><font size="4.5" color="#7a472c"><b>24?????????????????????</b></font></label> 
								<input type="text" class="form-control" id="priceDay" name="priceDay"
									placeholder="" value="${carerMemVo.priceDay.intValue()}" required>
							</div>

							<div class="col-sm-7">
								<label for="intro" class="form-label"><font size="4.5" color="#7a472c"><b>????????????</b></font></label>
								<textarea class="wishContent" id="intro" name="intro" maxlength="500" placeholder="??????????????????500??????"
									valign="top" align="left" style="width: 550px; height: 200px; word-break: break-all">${carerMemVo.intro}
								</textarea>
								<span class="wordsNum">???????????????: 0/500</span>
							</div>

							<hr class="my-4">

							<h4 class="mb-3"><font size="6"><b>????????????</b></font></h4>
							
								<table border="1"; border-collapse:collapse>
									<tr>
										<th><font size="4.5" color="#7a472c"><b>????????????</b></font></th>
										<th><font size="4.5" color="#7a472c"><b>??????</b></font></th>
									</tr>
									<c:forEach var="fileVo" items="${photoresult}">
										<tr>
											<td><font size="4.5" color="#7a472c"><b>${fileVo.fileTypeName}</b></font><br>
												<input type="hidden" name="${fileVo.fileTypeNo}" value="${fileVo.fileTypeNo}">
												<input type="file" accept="image/*" onchange="showImg(this)" name="photo${fileVo.fileTypeNo}" />
											</td>
											<td>
												<img src="data:image/jpg;base64, ${fileVo.applyFileContent}"
													width="300" height="225" id="${fileVo.fileTypeNo}" />
											</td>
										</tr>
									</c:forEach>
								</table>
						</div>

						<hr class="my-4">

						<h4 class="mb-3"><font size="6"><b>????????????</b></font></h4>

						<div class="row gy-3">
							<div class="col-md-7">
								<label for="bankCode" class="form-label"><font size="4.5" color="#7a472c"><b>????????????</b></font></label> 
								<select class="form-select" id="bankCode" name="bankCode" required>
									
									<c:forEach var="BankVO" items="${list1}">
										<option value="${BankVO.bankCode}" ${(carerMemVo.bankCode == BankVO.bankCode) ? 'selected' : '' }>${BankVO.bankCode}-${BankVO.bankName}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="col-sm-7">
							<label for="bankAcct" class="form-label"><font size="4.5" color="#7a472c"><b>????????????</b></font></label> 
							<input type="text" class="form-control" id="bankAcct" name="bankAcct"
								placeholder="" value="${carerMemVo.bankAcct}" required>
						</div>
						
						<input type="hidden" name="carerID" class="form-label"
								value="${carerMemVo.carerID}">
						
						<br> <br> <br> 
						<input type="hidden" name="action" value="update"> 
						<input type="submit" value="???????????????????????????" class="w-100 btn btn-primary btn-lg">
					</form>
				</div>
				<hr class="my-4">
			</div>
	</section>

	<!-- Footer -->
	<footer class="bg-light py-5">
		<div class="container px-4 px-lg-5">
			<div class="small text-center text-muted">Copyright &copy; 2021
				- Daily Warm</div>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- SimpleLightbox plugin JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
	<!-- Core theme JS-->
	<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="../js/scripts.js"></script>
	<script src="./UpdateCarerData.js"></script>
	<script src="../js/utility.js"></script>
 	<script src="../js/afterLogin.js"></script>
	
	<script type="text/javascript">
		// ????????????
		function showImg(item) {
			let img = item.parentElement.nextElementSibling.firstElementChild;
			img.src = URL.createObjectURL(item.files[0]);
			img.width = 300;
			img.height = 225;
		}
		
		// ????????????????????????
		<c:forEach var="SkillVO" items="${skillList}">
  			document.querySelector('#${SkillVO.skillNo}').setAttribute('checked', true);
  		</c:forEach>
  		
  		// ???????????? ??????????????????????????????
		var checkStrLengths = function (str, maxLength) {
		    var maxLength = maxLength;
		    var result = 0;
		    if (str && str.length > maxLength) {
		        result = maxLength;
		    } else {
		        result = str.length;
		    }
		    return result;
		}

		//????????????
		$(".wishContent").on('input propertychange', function () {

		    //??????????????????
		    var userDesc = $(this).val();

		    //????????????
		    var len;
		    if (userDesc) {
		        len = checkStrLengths(userDesc, 500);
		    } else {
		        len = 0
		    }

		    //????????????
		    $(".wordsNum").html('???????????????: ' + len + '/500');
		});
		
	</script>

	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
</body>

</html>