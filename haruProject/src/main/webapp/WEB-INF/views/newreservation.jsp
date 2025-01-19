 					<!-- DataTales Example -->
                    <div class="card mb-4">
                    
                        
                        <!-- 글 내용 -->
                        <div class="card-body">
                        	<!-- 내용 전체 -->
	                        <div class="board_detail_body">
	                        
	                        	<!-- Page Heading -->
			                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >예약 상세</h1>
					        	<button id="res_status">${appointment_d.status }</button>
					        	
	                        	<!-- 모달 내용 -->       
						        <div class="modal_l_detail">
						        
							        <div class="hr-table-appo-modal">
							        	<table id="hr-table-appo-modal-data">
							        			<tr>
							        				<th>예약 번호</th>
							        				<td>${appointment_d.resno }</td>
							        			</tr>
							        			<tr>
							        				<th>예약 일시</th>
							        				<td><fmt:formatDate value="${appointment_d.rdate}" pattern="yyyy-MM-dd"/></td>
							        				<td><div id="hr-table-empty"></div></td>
							        				<th>진료 소요 시간</th>
							        				<td>
							        					<div>
								        						<select id="medical-time">
										                    		<option value="1">30분</option>
																	<option value="2">60분</option>
																	<option value="3">90분</option>
																	<option value="4">120분</option>
										                    	</select>
									                       	
									                    </div>
									                </td>
							        			</tr>
							        			<tr>
							        				<th><div id="hr-table-empty"></div></th>
							        			</tr>
							        			<tr>
							        				<th>진료 과목</th>
							        				<td>${appointment_d.item }</td>
							        			</tr>
							        			
							        			<tr>
							        				<th>담당의</th>
							        				<td>${appointment_d.aname }</td>
							        			</tr>
							        			<tr>
							        				<th><div id="hr-table-empty"></div></th>
							        			</tr>
							        			
							        			<tr>
							        				<th>보호자</th>
							        				<td>${appointment_d.mname }</td>
							        			</tr>
							
							
							
							        	</table>
							        </div>
							        
							        <p>동물 정보</p>
							        <div class="hr-appo-table">
							        	<table id="hr-appo-table-data" width="100%" cellspacing="0">
							        			<tr>
							        				<td>${appointment_d.petno }</td>
							        				<td>${appointment_d.petname }</td>
							        				<td>${appointment_d.species }&nbsp;/&nbsp;${appointment_d.gender }</td>
							        				<td>${appointment_d.petweight }</td>
							        			</tr>
							        	</table>
							        </div>
						        
							        <p>예약 메모</p>
							        <div id="hr-appo-memo">
							        	<textarea rows="10" cols="125" placeholder="예약 메모를 입력해주세요.">${appointment_d.memo }</textarea>
							        </div>
						        </div>
	                        	
	                        	
	                        	
	                        	<!-- 모달 버튼 -->			        
						        <div class="modal_l-content-btn">
							        <c:if test="${appointment_d.status eq 100 }">
								        <button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
							        	<button type="button" class="update_btn" id="res_cancel" >예약 거절</button>
							        	<button type="button" class="update_btn" id="res_confirm">예약 확정</button>
							        </c:if>
							        <c:if test="${appointment_d.status eq 200 }">
								        <button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
							        	<button type="button" class="update_btn" id="res_change" >예약 변경</button>
							        	<button type="button" class="update_btn" id="res_complete">진료 완료</button>
							        </c:if>
							        <c:if test="${appointment_d.status == 300 or appointment_d.status == 400}">
								        <button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
							        </c:if>			        	
						        </div>
				                        	
	                        </div>
	                                       	
	                        	
                        </div>
                        <!-- end of .card-body -->		
	
                    </div>