<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
	$(document).ready(function (){
		$("#loginBtn").click(function (){
			if(!$("#id").val()){
				alert("아이디를 입력하세요");
				return;
			}else if(!$("#pass").val()){
				alert("비밀번호를 입력하세요");
				return;
			}else{
				var id = $("#id").val();
				var pass = $("#pass").val();
				$.ajax({
					type: "POST"
					,url: "user/login"
					,data: {
						id: id
						,pass: pass
					}
					,success:function(){
						alert("로그인 성공");
						$("#loginModal").modal("hide");
					}
				});
			}
		});//login
		$("#backBtn").click(function(){
			$("#loginModal").modal("hide");
		});//backBtn 로그인 모달 닫기 
		$("#registBtn").click(function (){ //회원 가입 ** user.xml수정
			if(!$("#userid").val()){
				alert("아이디를 입력하세요");
				return;
			}else if(!$("#username").val()){
				alert("이름을 입력하세요");
				return;
			}else if(!$("#userpass").val()){
				alert("비밀번호를 입력하세요");
				return;
			}else if(!$("#useremail").val()){
				alert("이메일을 입력하세요");
				return;
			}else{
				var id = $("#userid").val();
				var name = $("#username").val();
				var pass = $("#userpass").val();
				var email = $("#useremail").val();
				var data = {
						id : id
						,name: name
						,pass: pass
						,email: email
				}
				console.log("가입 버튼 클릭!!!!!!!"+data);
				$.ajax({
					type: "POST"
					,url: "user/register"
					,dataType: "text"
					,data: {
						id : id
						,name: name
						,pass: pass
						,email: email
					}
					,success:function(){
						alert("회원가입 완료");
						$("#registModal").modal("hide");
					}
				});
			}
		});//regist cancelBtn
		$("#cancelBtn").click(function(){
			$("#registModal").modal("hide");
		});//회원가입취소
		
		$("#modifyBtn").click(function (){	//수정 후 새로고침하면 로그아웃됨
			if(!$("#modipass").val()){
				alert("변경할 비밀번호를 입력하세요");
				return;
			}else{
				var id = "${userinfo.id}";
				var pass = $("#modipass").val();
				console.log("가입 버튼 클릭!!!!!!!"+id+pass);
				$.ajax({
					type: "PUT"
					,url: "user/passChange"
					,data: {
						id: id
						,pass: pass
					}
					,success:function(){
						alert("회원 수정 완료");
						$("#modifyModal").modal("hide");
					}
				});
			}
		}); //비밀번호 변경
		$("#deleteBtn").click(function(){
			if(confirm("탈퇴 하시겠습니까?")){
				let id = "${userinfo.id}";
				$.ajax({
					type: "DELETE"
					,url: 'user/' +id
					,contentType:'application/json;charset=utf-8'
					,success:function(){
						alert("탈퇴 완료");
						$("#modifyModal").modal("hide");
					}
				});
			}
		});//회원 탈퇴
	});//end
</script>
<body>
	<div class="container">
		<header id="index_header" class="jumbotron text-center mb-1">
			<h4>Happy House</h4> 
		</header>
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark rounded">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="#">Home</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
						동네 정보
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">APT 매매</a>
						<a class="dropdown-item" href="#">APT 전월세</a>
						<a class="dropdown-item" href="#">주택 매매</a>
						<a class="dropdown-item" href="#">주택 전월세</a>
						<a class="dropdown-item" href="#">상권 정보</a>
						<a class="dropdown-item" href="#">환경 정보</a>
					</div>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Notice</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">News</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Contact</a>
				</li>
			</ul>
			<div class="collapse navbar-collapse justify-content-end">
				<c:if test="${empty userinfo}">
				<ul class="navbar-nav" id ="id_notConfirm">
					<li class="nav-item">
						<a class="nav-link" href="#" data-toggle="modal" data-target="#loginModal">로그인</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#" data-toggle="modal" data-target="#registModal">회원가입</a>
					</li>
				</ul>
				</c:if>
				<c:if test="${!empty userinfo}">
				<ul class="navbar-nav" id="id_Confirm">
					<li class="nav-item">
						<a class="nav-link" href="${root}/user/logout" >로그아웃</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#" data-toggle="modal" data-target="#modifyModal">회원정보 수정</a>
					</li>
				</ul>
				</c:if>
			</div>
		</nav>
		<!-- 로그인 모달 -->
		<div class="container">
			<div class="modal fade" id="loginModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-body">
							<h3>로그인</h3>
							<form id="loginform" class="text-left mb-3">
				                <div class="form-group">
				                    <label for="id">아이디</label>
				                    <input type="text" class="form-control" id="id" name="id">
				                </div>
				                <div class="form-group">
				                    <label for="pass">비밀번호</label>
				                    <input type="password" class="form-control" id="pass" name="pass">
				                </div>
				                <div class="form-group text-center">
				                    <button type="button" id="loginBtn" class="btn btn-outline-warning">로그인</button>
				                    <button type="button" id="backBtn" class="btn btn-outline-primary">취소</button>
				                </div>
				            </form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 회원가입 모달 -->
		<div class="container">
			<div class="modal fade" id="registModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-body">
							<h3>회원가입</h3>
							<form id="registform" class="text-left mb-3">
				                <div class="form-group">
				                    <label for="userid">아이디</label>
				                    <input type="text" class="form-control" id="userid" name="userid">
				                </div>
				                <div class="form-group">
				                    <label for="name">이름</label>
				                    <input type="text" class="form-control" id="username" name="username">
				                </div>
				                <div class="form-group">
				                    <label for="userpass">비밀번호</label>
				                    <input type="password" class="form-control" id="userpass" name="userpass">
				                </div>
				                <div class="form-group">
				                    <label for="useremail">이메일</label>
				                    <input type="text" class="form-control" id="useremail" name="useremail">
				                </div>
				                <div class="form-group text-center">
				                    <button type="button" id="registBtn" class="btn btn-outline-warning">확인</button>
				                    <button type="button" id="cancelBtn" class="btn btn-outline-primary">취소</button>
				                </div>
				            </form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 회원s 수정 모달 -->
		<div class="container">
			<div class="modal fade" id="modifyModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-body">
						<c:if test="${!empty userinfo}">
							<h3><strong>${userinfo.name}</strong>님의 회원정보 수정</h3>
							<form id="modifyform" class="text-left mb-3">
				                <div class="form-group">
				                    <label for="userid">아이디</label>
				                    <input type="text" class="form-control" value="${userinfo.id}">
				                </div>
				                <div class="form-group">
				                    <label for="name">이름</label>
				                    <input type="text" class="form-control" value="${userinfo.name}">
				                </div>
				                <div class="form-group">
				                    <label for="modipass">변경 할 비밀번호</label>
				                    <input type="password" class="form-control" id="modipass" name="modipass">
				                </div>
				                <div class="form-group text-center">
				                    <button type="button" id="modifyBtn" class="btn btn-outline-warning">수정</button>
				                    <button type="button" id="deleteBtn" class="btn btn-outline-primary">회원탈퇴</button>
				                </div>
				            </form>
				        </c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<section id="index_section">
			<div class="card col-sm-12 mt-1" style="min-height: 850px;">
				<div class="card-body">
					시도 : 
					<select id="sido">
						<option value="0">선택</option>
					</select>
					구군 : 
					<select id="gugun">
						<option value="0">선택</option>
					</select>
					읍면동 : 
					<select id="dong">
						<option value="0">선택</option>
					</select>
					<button type="button" id="aptSearchBtn">검색</button>
					<table class="table mt-2">
						<colgroup>
							<col width="100">
							<col width="150">
							<col width="*">
							<col width="120">
							<col width="120">
						</colgroup>	
						<thead>
							<tr>
								<th>번호</th>
								<th>아파트이름</th>
								<th class="text-center">주소</th>
								<th>건축연도</th>
								<th>최근거래금액</th>
							</tr>
						</thead>
						<tbody id="searchResult"></tbody>
					</table>
				<div id="map" style="width:100%;height:500px;"></div> 
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e46a259ae651b46189dba64791c30aed&libraries=services"></script>
				<script type="text/javascript" src="js/map.js"></script>
				<script type="text/javascript">
				let colorArr = ['table-primary','table-success','table-danger'];
				$(document).ready(function(){					
					$.get(root + "/map/sido"   
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});
						}
						, "json"
					);
				});
				$(document).on("change", "#sido", function() {
					$.get(root + "/map/gugun"
							,{sido: $("#sido").val()}
							,function(data, status){
								$("#gugun").empty();
								$("#gugun").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#gugun", function() {
					$.get(root + "/map/dong"
							,{gugun: $("#gugun").val()}
							,function(data, status){
								$("#dong").empty();
								$("#dong").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#dong", function() {
					$.get(root + "/map/apt"
							,{dong: $("#dong").val()}
							,function(data, status){
								$("tbody").empty();
								$.each(data, function(index, vo) {
									let str = `
										<tr class="${colorArr[index%3]}">
											<td>${vo.aptCode}</td>
											<td><a href="" data-toggle="modal" date-target="#aptModal">${vo.aptName}</a></td>
											<td>${vo.sidoName} ${vo.gugunName} ${vo.dongName} ${vo.jibun}</td>
											<td>${vo.buildYear}</td>
											<td>${vo.recentPrice}</td>
										</tr>
									`;
									$("tbody").append(str);
								});
								displayMarkers(data);
							}
							, "json"
					);
				});
				
				$(document).on("click", "#aptSearchBtn", function() {
					var param = { //공공데이터 키
							serviceKey:'2LlEyKxqr1YfX0CBc7emYGAsWH2IYBHaW3/aUCe68sdkVkrNRiRCjvdwbGZ3Z4MqvbUQTa+gMx0sxGXW/4fsrA==',
							pageNo:encodeURIComponent('1'),
							numOfRows:encodeURIComponent('100'),
							LAWD_CD:encodeURIComponent($("#gugun").val()),
							DEAL_YMD:encodeURIComponent('202110')
					};
					$.get('http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'
							,param
							,function(data, status){
								var items = $(data).find('item');
								var jsonArray = new Array();
								items.each(function() {
									var jsonObj	= new Object();
									jsonObj.aptCode = $(this).find('일련번호').text();
									jsonObj.aptName = $(this).find('아파트').text();
									jsonObj.dongCode = $(this).find('법정동읍면동코드').text();
									//법정도읍면동 코드로  법정동코드로 dongName,sidoName,gugunName얻어내기
									//jsonObj.dongName = ;
									//jsonObj.sidoName = ;
									//jsonObj.gugunName = ;
									jsonObj.buildYear = $(this).find('건축년도').text();
									jsonObj.jibun = $(this).find('지번').text();
									jsonObj.recentPirce = $(this).find('거래금액').text();
										
									jsonObj = JSON.stringify(jsonObj);
									//String 형태로 파싱한 객체를 다시 json으로 변환
									jsonArray.push(JSON.parse(jsonObj));
								});
								console.log(jsonArray);
								//displayMarkers(jsonArray);
							}
							, "xml"
					);
					/* var xhr = new XMLHttpRequest();
					var url = 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev';
					var queryParams = '?' + encodeURIComponent('serviceKey') + '='+encodeURIComponent(' API KEY ');
					queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); 
					queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); 
					queryParams += '&' + encodeURIComponent('LAWD_CD') + '=' + encodeURIComponent($("#gugun").val()); 
					queryParams += '&' + encodeURIComponent('DEAL_YMD') + '=' + encodeURIComponent('202110'); 
					xhr.open('GET', url + queryParams);
					xhr.onreadystatechange = function () {
					    if (this.readyState == 4) {
					    	console.log(this.responseXML);
					        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
					    }
					};

					xhr.send(''); */
				});
				</script>
				</div>
			</div>
		</section>
	</div>
</body>