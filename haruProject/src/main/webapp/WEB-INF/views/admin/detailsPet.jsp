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

    <title>동물 상세</title>
    
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >동물 상세</h1>
                    
					<div class="modal_l_detail">
		       			 <form class="js-pro-container" action="updatePet" id="pet-update-form" method="post" onsubmit="return updateValidateForm()">
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
					        			<td class="sub-title">번호</td>
					        			<td>
					        				${pet.petno }
					        				<input type="hidden" value="${pet.petno }" name="petno">
					        			</td>
					        			<td class="sub-title">종</td>
					        			<td>
					        				<select class="species-bcd" style="width: 120px;" name="petspecies_bcd" required="required">
					        					<option value="0" disabled>선택</option>
					        					<c:forEach var="b" items="${bcd }">
					        						<option value="${b.bcd}" ${pet.petspecies_bcd == String.valueOf(b.bcd) ? 'selected="selected"' : ''}>${b.species }</option>
					        					</c:forEach>
					        				</select>
					        				<select class="species-mcd" style="width: 223px" name="petspecies_mcd" required="required">
					        				</select>
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">보호자</td>
					        			<td>${pet.mname }</td>
					        			<td class="sub-title">담당의</td>
					        			<td>
					        				<select class="incharge-vet" name="ano">
					        					<option value="0">-</option>
					        					<c:forEach var="v" items="${vet }">
					        						<option value="${v.ANO }" ${v.ANO eq pet.ano ? 'selected' : '' }>${v.ANAME }</option>
					        					</c:forEach>
					        				</select>
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">이름 <span class="haru-required">*</span></td>
					        			<td>
					        				<input class="haru-pro-price" name="petname" type="text" required="required"
					        						value="${pet.petname }"
					        				>
					        			</td>
					        			<td class="sub-title">몸길이(cm)</td>
					        			<td>
					        				<input class="haru-pro-brand" name="petheight" type="text" 
					        						value="${pet.petheight }">
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">생년월일</td>
					        			<td colspan="3">
					        				<input class="haru-pro-quantity" name="petbirth" type="date" style="border: 1px solid var(--haru); border-radius: 15px; padding-inline: 1rem"
					        						value="${pet.petbirth }">
					        			</td>
					        		</tr>
					        		<tr class="pet-gender-radio-div">
					        			<td class="sub-title">성별</td>
					        			<td>
					        				<label for="male">수컷					        				
					        					<input type="radio" name="gender1" value="1" id="male" ${pet.gender1 eq 1 ? 'checked' : ''} >
					        				</label>
					        				<label for="female">암컷
						        				<input type="radio" name="gender1" value="2" id="female" ${pet.gender1 eq 2 ? 'checked' : ''} >				        				
					        				</label>
					        			</td>
					        			<td class="sub-title">중성화 여부</td>
					        			<td>
					        				<label for="ok"><i class="fa-solid fa-o"></i>
						        				<input type="radio" name="gender2" value="1" id="ok" ${pet.gender2 eq 1 ? 'checked' : ''}>				        				
					        				</label>
					        				<label for="no"><i class="fa-solid fa-x"></i>
						        				<input type="radio" name="gender2" value="2" id="no" ${pet.gender2 eq 2 ? 'checked' : ''}>					        				
					        				</label>
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">등록일</td>
					        			<td>
					        				<fmt:formatDate value="${pet.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
					        			</td>
					        			<td class="sub-title">최종 수정일</td>
					        			<td class="pro-update-date">
					        				<fmt:formatDate value="${pet.update_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
					        			</td>
					        		</tr>
					        		
					        	</table>
					        	
					        	<div style="margin-top: 2rem;">
						        	<div style="font-weight: 500">특이사항</div>
									<textarea name="petspecial">${pet.petspecial }</textarea>					        	
					        	</div>
					        	
					        	<div style="margin-top: 2rem;">
					        		<div style="display: flex; align-items: center; justify-content: space-between;">
							        	<div style="font-weight: 500">몸무게</div>
										<div>
											<input type="text" style="width: 200px;" class="add-weight-input">
											<button type="button" onclick="addWeight()"
													style="color: white; background: var(--haru); border-radius: 5px; border: none; outline: none; padding: 4px;">몸무게 추가</button>
										</div>					        		
					        		</div>
									<canvas id="pet-weight-chart"></canvas>			        	
					        	</div>
					        	
					        	<div style="margin-top: 3rem;">
					        		<div class="title">예약 내역</div>
					        		<div onclick="location.href='/admin/reservation?search4=${pet.petno}'" style="cursor: pointer; color: blue">
					        			예약 내역 보러가기 <i class="fa-regular fa-hand-pointer fa-rotate-90"></i>
					        		</div>
					        	</div>
					        	
				        	</div>
				        	
					   </form>	
					</div>
					
			        <!-- 모달 버튼 -->
			        <div class="modal_l-content-btn">
			        	<button type="button" id="modal_close_btn" class="to_list pro_reg" onclick="location.href='/admin/pets'">목록으로</button>
			        	<button type="submit" class="update_btn" form="pet-update-form">수정하기</button>
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
			return confirm('이대로 수정하시겠습니까?');
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
	 	
    	
		
    	// JSP에서 가져온 데이터를 JavaScript 배열로 변환
        var arr = '${labels}';  // X축 (날짜)
        var labels = arr.replace(/\[|\]/g, '').split(', ').map(item => item.trim());
        var dataValues = ${weight};  // Y축 (값)
        const ctx = document.getElementById('pet-weight-chart').getContext('2d');
    	
    	$(()=>{
            // 차트 생성
            buildChart();
    	})
    	
    	/* 몸무게 추가 */
    	function addWeight() {
    		var weight = $('.add-weight-input').val();
    		if(weight!=null || weight != '') {
    			
    			//몸무게 추가 api 호출
    			let url = `<%=request.getContextPath()%>/api/add-weight`;
    			
    			$.ajax({
				url: url,
				method: 'post',
				contentType:"application/json",
				data: JSON.stringify({
					memno: ${pet.memno},
					petno: ${pet.petno},
					petweight: weight
				}),
				success: function(data) {
					console.log(data);
					
					if(data) {
						var today = new Date();
						var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
						labels.push(date);
						dataValues.push(weight);
						
						buildChart()
						$('.add-weight-input').val('');
					}
					
				}
			})
    		}
    		
    	}
    
        function buildChart() {
    		new Chart(ctx, {
                type: 'line',  // 라인 차트
                data: {
                    labels: labels,  // X축 (날짜)
                    datasets: [{
                        label: '몸무게',
                        data: dataValues,  // Y축 데이터
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.1 // 곡선 효과
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    },
                    scales: {
                        x: {  // X축 설정
                            title: {
                                display: true,
                                text: '날짜'
                            }
                        },
                        y: {  // Y축 설정
                            title: {
                                display: true,
                                text: '값'
                            },
                            beginAtZero: true
                        }
                    }
                }
            });
    	}
        

    </script>

</body>
</html>