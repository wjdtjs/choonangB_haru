<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>동물 추가</title>
    
<style type="text/css">
.pet-gender-radio-div label {
	margin-bottom: 0;
	display: inline-flex;
	align-items: center;
}
.pet-gender-radio-div label:nth-of-type(1) {
	margin-right: 10px;
}
.pet-gender-radio-div label input {
	margin-left: 8px;
}
input[type='radio'] {
  -webkit-appearance: none; 
  -moz-appearance: none;
  appearance: none; 
  width: 20px;
  height: 20px;
  border: 1px solid var(--haru); 
  border-radius: 50%;
  outline: none; 
  cursor: pointer;
}
input[type='radio']:checked {
  background-color: var(--haru); 
  border: 3px solid #fff; 
  box-shadow: 0 0 0 1px var(--haru); 
}

textarea {
	margin-top: 1rem;
	width: 100%;
	padding-block: 8px;
	padding-inline: 12px;
	border-radius: 10px;
	border: none;
	background-color: #EFEFEF;
	font-family: "Noto Sans KR", serif;
	resize: vertical;
}

</style>
</head>
<body>

<!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <jsp:include page="components/sideBar.jsp"></jsp:include>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <jsp:include page="components/topBar.jsp"></jsp:include>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid modal_">

                    <!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >동물 추가</h1>
                    
					<div class="modal_l_detail">
		       			 <form class="js-pro-container" action="uploadPet" id="pet-upload-form" method="post" onsubmit="return updateValidateForm()">
				        	<div class="js-pro-info">
				        		<div class="title">동물 정보</div>
					        	<table>
					        		<colgroup>
					        			<col width="10%"/>
					        			<col width="40%"/>
					        			<col width="10%"/>
					        			<col width="40%"/>
					        		</colgroup>
					        		<tr>
					        			<td class="sub-title">종</td>
					        			<td colspan="3">
					        				<select class="species-bcd" style="width: 120px;" name="petspecies_bcd" required="required">
					        					<option value="0" disabled selected>선택</option>
					        					<c:forEach var="b" items="${bcd }">
					        						<option value="${b.bcd}">${b.species }</option>
					        					</c:forEach>
					        				</select>
					        				<select class="species-mcd" style="width: 223px" name="petspecies_mcd" required="required">
					        				</select>
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">보호자</td>
					        			<td style="display: flex;">
					        				<input type="text" name="search1" id="res-mname" style="width: 150px; margin-right: 10px;"
				        								onkeypress="console.log('onkeypress 실행됨'); if (event.key === 'Enter') search_mname(event)"
				        								value="${search1 }" required="required">
					                       	<select id="res-select-mname" name="memno" style="display:none" required>
					                       		<option disabled selected value="0">선택</option>
					                    	</select>
					        			</td>
					        			<td class="sub-title">담당의</td>
					        			<td>
					        				<select class="incharge-vet" name="ano" required="required">
					        					<option value="0">-</option>
					        					<c:forEach var="v" items="${vet }">
					        						<option value="${v.ANO }" >${v.ANAME }</option>
					        					</c:forEach>
					        				</select>
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">이름 <span class="haru-required">*</span></td>
					        			<td>
					        				<input class="haru-pro-price" name="petname" type="text" required="required">
					        			</td>
					        			<td class="sub-title">몸길이(cm)</td>
					        			<td>
					        				<input class="haru-pro-brand" name="petheight" type="text" >
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">생년월일</td>
					        			<td>
					        				<input class="haru-pro-quantity" name="petbirth" type="date" style="border: 1px solid var(--haru); border-radius: 15px; padding-inline: 1rem">
					        			</td>
					        			<td class="sub-title">몸무게(kg)</td>
					        			<td>
					        				<input class="haru-pro-quantity" name="petweight" type="text">
					        			</td>
					        		</tr>
					        		<tr class="pet-gender-radio-div">
					        			<td class="sub-title">성별</td>
					        			<td>
					        				<label for="male">수컷					        				
					        					<input type="radio" name="gender1" value="1" id="male" required="required">
					        				</label>
					        				<label for="female">암컷
						        				<input type="radio" name="gender1" value="2" id="female"  required="required">				        				
					        				</label>
					        			</td>
					        			<td class="sub-title">중성화 여부</td>
					        			<td>
					        				<label for="ok"><i class="fa-solid fa-o"></i>
						        				<input type="radio" name="gender2" value="1" id="ok" required="required">				        				
					        				</label>
					        				<label for="no"><i class="fa-solid fa-x"></i>
						        				<input type="radio" name="gender2" value="2" id="no" required="required">					        				
					        				</label>
					        			</td>
					        		</tr>
					        		
					        	</table>
					        	
					        	<div style="margin-top: 2rem;">
						        	<div style="font-weight: 500">특이사항</div>
									<textarea name="petspecial"></textarea>					        	
					        	</div>
					        	
				        	</div>
				        	
					   </form>	
					</div>
					
			        <!-- 모달 버튼 -->
			        <div class="modal_l-content-btn">
			        	<button type="button" id="modal_close_btn" class="to_list pro_reg" onclick="location.href='/admin/pets'">목록으로</button>
			        	<button type="submit" class="update_btn" form="pet-upload-form">추가하기</button>
			        </div>
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
			<jsp:include page="components/footer.jsp"></jsp:include>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <jsp:include page="components/logOutModal.jsp"></jsp:include>
    
    
    <script type="text/javascript">
    	
	 	/**
	 	 * validation 체크
	 	 */
	   	function updateValidateForm() {
	 		
	 		
			return confirm('이대로 추가하시겠습니까?');
		}
    	
    	
	 // 종 대분류값 가져오기
	   	$(function() {
	   		let selectedValue = $(".species-bcd").val(); // 현재 선택된 값 가져오기
	   		console.log("selectedValue: ", selectedValue);
	   	    if (selectedValue !== "0") { // 값이 0이 아닐 경우 실행
	   	        getMcd();
	   	    }
	   		
	   		$(".species-bcd").change(() => {
	   			console.log("종 대분류값 눌림");
	   			getMcd();
	   		});
	   	});

	   	// controller에서 받아온 pet
	   	let pet = {petspecies_mcd: "${not empty pet ? pet.petspecies_mcd : ''}"};
	   	      
	   	// 종 대분류에 따른 중분류값 가져오기
	   	function getMcd(val) {
	   		let selectedOptionValue = $(".species-bcd option:selected").val();
	   		console.log(selectedOptionValue);
	   		
	   		$('.add-species-mcd').remove();
	   		$('.species-mcd option:eq(0)').prop("selected", true);
	   		
	   		$.ajax({
	   			url: `<%=request.getContextPath()%>/api/add-mcd/`+selectedOptionValue, 
	   			dataType: 'json',
	   			success: function(data) {
	   				let str = "";
	   				$(data).each(function(index,item) {
	   					let selectedMcd = pet && pet.petspecies_mcd == String(item.mcd) ? 'selected="selected"' : '';
	   					str += `<option value="\${item.mcd}" class=".add-species-mcd"  \${selectedMcd}>\${item.species}</option>`;
	   				})
	   				
	   				$('.species-mcd').html(str);
	   				
	   				if(val) {
	   					$('.species-mcd').val(val).prop('selected',true);
	   				}
	   			},
	   			error: function(xhr, status, error) {
	   	            console.error("중분류 데이터를 가져오는 중 오류 발생:", error);
	   	        }
	   		})
	   	}
	   	
	 // ------ 보호자 이름 + 동물 이름
	    // 보호자 이름 입력시 드롭박스 display: none -> block
		function search_mname(e) {
	    	if(e.key === "Enter") {
	    		e.preventDefault(); //enter 쳤을때 form이 submit 되는거 막기
	    		
	    		const searchInput = $("#res-mname").val();
	    		console.log("searchInput(search1) : ", searchInput);
	    		
	    		getMname(searchInput);
	    		
	    		const dropMname = document.getElementById("res-select-mname");
	    		console.log("dropMname(res-select-mname) : ", dropMname);
	    		if (dropMname.style.display === "none") {
					dropMname.style.display = "block";
				} else {
					dropMname.style.display = "none";
				}
	    		
	    		
	    	}
	    }
	    
	    // 보호자 이름 입력시 그에 해당하는 보호자 이름 가져오기
	    function getMname(searchInput) {
	    	console.log("getMname start ,,,");
	    	console.log(searchInput);
	    	
	    	$('.add-res-mname').remove();
	    	$('#res-select-mname option:eq(0)').prop("selected",true);
	    	
	    	$.ajax({
	    		url: `<%=request.getContextPath()%>/api/mname/`+searchInput,
	    		datatype: 'json',
	    		success: function(data) {
	    			console.log("data : ", data);
	    			let str = "";
	    			$(data).each(function(index, item) {
	    				str += `<option value="\${item.MEMNO}" class='.add-res-mname'>\${item.MNAME}&nbsp;(\${item.MTEL})</option>`;    				
	    			})
	    			$('#res-select-mname').html(str);
	    			
	    			if(searchInput) {
	    				$('#res-select-mname').val(searchInput).prop('selected', true);
	    			}
	    		},
	    		error: function(xhr, status, error) {
		            console.error("보호자 이름 데이터를 가져오는 중 오류 발생:", error);
		        }
	    	})
	    }

    </script>

</body>
</html>