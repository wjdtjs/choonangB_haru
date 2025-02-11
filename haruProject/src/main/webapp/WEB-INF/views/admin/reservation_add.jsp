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

    <title>예약 추가</title>
</head>

<style>
.modal_ p {
	color: black;
	padding: 12px 24px;
	font-size: 18px;
	font-weight: bold;
	margin: 0;
}

/* 제목 제외 컨텐츠 */
#hr-res {
	display: flex;
}

/* 달력 */
#hr-res-left {
	width:400px;
	height: 100%;
	margin: 0;
	padding: 0;
}


/* 내용 */

#hr-res-right {
	display: flex;
	flex-direction: column;
	margin-left: 40px;
}

#hr-res-right p {
	margin-left: 8px;
	font-size: 16px;
}

.hr-table-res-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-res-modal #hr-table-res-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px 12px;
	width: 200px;
}
.hr-table-res-modal #hr-table-res-modal-data td {
	color: black;
}
.hr-table-res-modal #hr-table-res-modal-data tr {
	margin: 4px;
	padding: 8px 0;
	display: block;
}


.hr-res-table {
	margin: 16px 20px;
}

#hr-res-table-data {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	font-size: 20px;
	text-align: center;
	color: black;
	font-weight: bold; 
	margin: 20px autos;
}

#hr-res-table-data td {
	padding: 12px;
}
	
#hr-table-empty {
	padding: 8px;
}

#hr-res-memo {
	margin: 0 24px;
}

#hr-res-memo textarea {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	padding: 16px;
	border: white;
}

#hr-table-res-modal-data select {
	border: 1px solid #0C808D;
	border-radius: 12px;
	color: black;
	font-size: 14px;
	width: 160px;
	height: 30px;
	padding: 2px 0px 2px 12px;
	margin: 0 12px;
}

#res_input {
	width: 136px;
	height: 28px;
	margin: 4px 12px;
	border: 1px solid var(--haru);
	border-radius: 12px;
	padding: 0 12px;
}


/* 예약 날짜 */
table#calendar {
    width: 100%;
    height: 300px;
    border: none;
    text-align: center;
    color: black;
}

#calendar td {
    border-radius: 12px;
	border: none;
	padding: 8px;
	height: 50px;
	
	background-clip: content-box;
}


#cal_time_table td{
	text-align: center;
}

#cal_time_table button {
    width: 85%;
    margin: 8px;
    border: 1px solid var(--haru);
    background-color: white;
    border-radius: 16px;
    height: 28px;
}

.selected_time {
  background-color: var(--haru) !important;
  color: white; /* 버튼 텍스트를 가독성 있게 하려면 추가 */
}

.selected-date {
	background-color: var(--haru);
	color: white;
}

.disabled-btn {
	background-color: #D9D9D9 !important;
	color: white !important;
	border: none !important;
}

#cal_time_table > tbody > tr:nth-child(3) > td {
	padding-top: 12px;
}

/* 보호자 이름 */
input#res-mname {
    width: 160px;
    height: 30px;
    margin: 0 12px;
    border: 1px solid var(--haru);
    border-radius: 12px;
    padding: 0 12px;
}


</style>

<script type="text/javascript">
	// 달력
	var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
    var date = new Date();//today의 Date를 세어주는 역할
    var disabledDates = [];
    var diff = 0;			//현재 날짜와 달력의 개월 차이
    
 	let selectedDateGlobal = null;
    let selected_vet = 0;
    
 	/**
 	 * 이전달
 	 */
 	function prevCalendar() {
 	    // 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
 	    //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
 	    //getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함

 	     //오늘 기준 달 이전 달은 그리지 않음
 	    if(diff != 0) {
 			$(".cal-prev-btn").css('display', 'block');
 			$(".cal-next-btn").css('display', 'block');
 		    today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
 			selectDoctor();
 			diff--;
 		} 
 		if(diff == 0) {
 			$(".cal-prev-btn").css('display', 'none');
 		}
 	}

 	/**
 	 * 다음달
 	 */
 	function nextCalendar() {
 	    // 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
 	    //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
 	    //getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
 	       
 	    //오늘 기준 최대 6개월까지만 그려줌	
 	    if(diff < 5) {
 			$(".cal-prev-btn").css('display', 'block');
 			$(".cal-next-btn").css('display', 'block');
 		    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
 		    
 		    selectDoctor();
 		    diff++;
 		} 
 		if(diff == 5) {
 			$(".cal-next-btn").css('display', 'none');
 		}
 	}
	
    function buildCalendar(disabledDates) {
    	console.log("buildCalendar start ,,,");
    	console.log("buildCalendar disabledDates ->", disabledDates);
    	
        var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
        var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
        var tbCalendar = document.getElementById("calendar");
        var tbCalendarYM = document.getElementById("tbCalendarYM");		// 제목(연도, 월) 작성

        tbCalendarYM.innerHTML = `\${today.getFullYear()}년 \${today.getMonth() + 1}월`;

        // 기존 열 제거
        while (tbCalendar.rows.length > 2) {
            tbCalendar.deleteRow(tbCalendar.rows.length - 1);
        }

        var row = null;
        row = tbCalendar.insertRow();
        var cnt = 0;

        // 빈 칸 채우기
        for (let i = 0; i < doMonth.getDay(); i++) {
            const cell = row.insertCell();
            cnt++;
        }

        // 날짜 채우기
        for (let i = 1; i <= lastDate.getDate(); i++) {
            const currentDay = i; // `i` 값을 고정시켜 저장
            const cell = row.insertCell();
            cell.innerHTML = i;
            cnt++;

            if (cnt % 7 == 1) {
                cell.innerHTML = "<font color=red>" + i + "</font>";
            }
            if (cnt % 7 == 0) {
                cell.innerHTML = "<font color=blue>" + i + "</font>";
                row = tbCalendar.insertRow();
            }

            if (
                today.getFullYear() == date.getFullYear() &&
                today.getMonth() == date.getMonth() &&
                i == date.getDate()
            ) {
                cell.bgColor = "#FAF58C";
            }
            
            const dateStr = `\${today.getFullYear()}-\${String(today.getMonth() + 1).padStart(2, "0")}-\${String(currentDay).padStart(2, "0")}`;
            console.log("dateStr ->", dateStr);
            
         	// value 배열의 날짜를 YYYY-MM-DD 형식으로 변환
            const dateValue = disabledDates.map(date => {
                const d = new Date(date);
                return `\${d.getFullYear()}-\${String(d.getMonth() + 1).padStart(2, "0")}-\${String(d.getDate()).padStart(2, "0")}`;
            });
            
            
         	// 비활성화 날짜 처리         	
            if (dateValue.includes(dateStr)) {
            	console.log("disabledDates dateValue start ,,,");
                cell.style.backgroundColor = "lightgray";
                cell.style.pointerEvents = "none"; // 클릭 비활성화
                cell.style.opacity = "0.6"; // 시각적 효과
            } else {
                // 날짜 클릭 이벤트 추가
                cell.addEventListener("click", async function () {
                	// 두 자리 수로 맞추기 위한 함수 (ex: 1 -> 01)
                	const padZero = (num) => (num < 10 ? `0\${num}` : `\${num}`);
                	
                	// yy/MM/dd로 변환
                    const selectedDate = `\${today.getFullYear()}-\${padZero(today.getMonth() + 1)}-\${padZero(currentDay)}`;
                    selectedDateGlobal = selectedDate
                    alert("선택된 날짜: " + selectedDateGlobal);

                    // 선택된 날짜 표시
                    const selectedTd = document.querySelector(".selected-date");
                    if (selectedTd) {
                        selectedTd.classList.remove("selected-date");
                    }
                    cell.classList.add("selected-date");
                    
                    enableAllButtons();		// 모든 시간 버튼 활성화
                    
                    // 시간 선택 버튼 보이면서 모든 시간 가져오기 + 예약 테이블에서 선택한 날짜에 해당하는 start_time, rtime 불러와서 해당하는 시간 비활성화 처리
                    console.log(selectedDate);
                    const disabledTimes = await getDisabledTimes(selectedDate);		// 날짜에 따른 예약 불가능 시간 가져오기
                	
                    console.log("disabledTimes : ",disabledTimes);
                    // start_time, rtime/30 불러오기
                    disabledTimes.forEach((item) => {
                    	const stime = item.start_time;
                    	const dtime = (item.rtime)/30;
                    	console.log("start_time(stime) : ",stime,"rtime(dtime) : ",dtime);
	                    // 불가능시간과 rtime/30한 값을 넣어 예약 불가능한 시간 버튼 비활성화
	                    disableButtonsFromValue(stime, dtime);
                    })                    
                    
                    $('#cal_time').css("display", "block");		// 날짜 선택 시에 시간 선택 버튼 보이게
                    
                    
                });
            }

        }
    }
    
    // 비활성화 날짜 불러오기
    async function getDisabledDates(docValue) {
    	var current_m = today.getMonth()+1;
    	try {
    		console.log("getDisabledDates docValue ->"+docValue);
    		console.log("getDisabledDates api url ->", `/api/disabled-dates?ano=\${docValue}&month=\${current_m}`);
            const response = await fetch(`/api/disabled-dates?ano=\${docValue}&month=\${current_m}`, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json",
                },
            });
            if (!response.ok) {
                throw new Error("Failed to fetch disabled dates");
            }
            const data = await response.json();
            console.log("getDisabledDates data ->", data);
            return data || [];
        } catch (error) {
            console.error("Error fetching disabled dates:", error);
            return [];
        }
    }
    
    /**
     * 병원/의사 정기 휴무 불러오기
     */
    async function getRegularDisabledDates(docValue) {
    	var lastdate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
        var formatted_lastdate = lastdate.getFullYear()%100 + '/' + ('0' + (lastdate.getMonth() + 1)).slice(-2) + '/' + ('0' + lastdate.getDate()).slice(-2); // "YYYY-MM" 형태
        
        try {
    		console.log("getRegularDisabledDates docValue ->"+docValue);
            const response = await fetch(`/api/vet-regular-holiday?ano=\${docValue}&formattedDateEnd=\${formatted_lastdate}`, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json",
                },
            });
            if (!response.ok) {
                throw new Error("Failed to fetch disabled dates");
            }
            const data = await response.json();
            console.log("getRegularDisabledDates data -> ", data)
            
            return data || [];
        } catch (error) {
            console.error("Error fetching disabled dates:", error);
            return [];
        }
    }
    
    
    // 선생님 선택시 진료 불가능 날짜 받아오기
    $(document).ready(function () {
    	$('#res-doc').change(async function() {
    		const selectedValue = $(this).val();	// 선택된 선생님 val 가져오기
    		console.log("selectedValue ->"+selectedValue);
    		selected_vet = selectedValue;
    		selectDoctor();
    		
//     		if (selectedValue && selectedValue != "0") {
// 				const dDates = await getDisabledDates(selectedValue);
// 				const dDates2 = await getRegularDisabledDates(selectedValue);
//     			console.log("if selectedValue ->"+selectedValue);
//     			console.log("if dDates ->"+dDates);
    			
//     			disabledDates = [];
//     			if(dDates) {
//     				for (var i = 0; i < dDates.length; i++) {
//     					disabledDates.push(dDates[i].schdate);
//     				}
//     			}
//     			if(dDates2) {
//     				for (var i = 0; i < dDates2.length; i++) {
//     					if(dDates2[i].persoffdays) {
//     						for(var j = 0; j < dDates2[i].persoffdays.length; j++) {
//     							disabledDates.push(dDates2[i].persoffdays[j]);			
//     						}					
//     					}
//     					if(dDates2[i].newoff) {
//     						for(var j = 0; j < dDates2[i].newoff.length; j++) {
//     							disabledDates.push(dDates2[i].newoff[j]);			
//     						}					
//     					}
//     				}			
//     			}
				
// 				if (disabledDates) {
// 					console.log("disabledDates ->",disabledDates);
// 					console.log("buildCalendar ready,,,");
// 					buildCalendar(disabledDates);					// 진료 불가능 날짜 적용된 달력 함수 호출
// 					$('#res-calendar').css("display", "block");		// 달력 보이게
// 				}
// 			}
    	})
    })
    
    
    /**
	 * 진료 불가능 날짜 받아오기
	 */
	async function selectDoctor() {
		console.log("selectedValue ->"+selected_vet);
		
	//	if (selected_vet && selected_vet != "0") {
			const dDates = await getDisabledDates(selected_vet);
			const dDates2 = await getRegularDisabledDates(selected_vet);
			console.log("if selectedValue ->"+selected_vet);
	//		console.log("if dDates ->"+dDates);
			
			disabledDates = [];
			if(dDates) {
				for (var i = 0; i < dDates.length; i++) {
					disabledDates.push(dDates[i].schdate);
				}
			}
			if(dDates2) {
				for (var i = 0; i < dDates2.length; i++) {
					if(dDates2[i].persoffdays) {
						for(var j = 0; j < dDates2[i].persoffdays.length; j++) {
							disabledDates.push(dDates2[i].persoffdays[j]);			
						}					
					}
					if(dDates2[i].newoff) {
						for(var j = 0; j < dDates2[i].newoff.length; j++) {
							disabledDates.push(dDates2[i].newoff[j]);			
						}					
					}
				}			
			}
			console.log("disabledDates ->", disabledDates);
			
			if (disabledDates) {
	//			console.log("disabledDates ->",disabledDates);
				console.log("buildCalendar ready,,,");
				buildCalendar(disabledDates);					// 진료 불가능 날짜 적용된 달력 함수 호출
				$('#res-calendar').css("display", "block");		// 달력 보이게
			}
	//	}
	}
    

    
    // 날짜 선택에 따른 시간들 불러오기
    // 선택한 날짜에 따른 시간 불러오기 전에 모든 버튼 활성화
    function enableAllButtons() {
    	document.querySelectorAll(".cal_time_btn").forEach((button) => {
    		console.log("enableAllButtons() start ,,,");
    		 button.disabled = false; // 버튼 활성화
    	     button.classList.remove("disabled-btn", "selected_time"); // 관련 클래스 제거
    	     button.style.backgroundColor = ""; // 스타일 초기화
    	     button.style.color = ""; // 텍스트 색 초기화
    	     button.style.pointerEvents = "";
    	});
    }
    
    // 선택한 날짜에 따른 비활성화 시간 불러오기
    async function getDisabledTimes(selectedDate) {
    	try {
    		const docValue = document.querySelector("#res-doc").value;
    		console.log("getDisabledTimes selected ano : ", docValue);
    		console.log("getDisabledTimes docValue ->"+docValue);
    		console.log("getDisabledTimes api url ->", `/api/disabled-times?rdate=\${selectedDate}&ano=\${docValue}`);
    		    		
    		const response = await fetch(`/api/disabled-times?rdate=\${selectedDate}&ano=\${docValue}`, {
    			method:"GET",
    			headers: {
    				"Content-Type": "application/json",
    			},
    		});
    		
    		if(!response.ok) {
    			throw new Error("Failed to fetch disabled times");
    		}
    		
    		const data = await response.json();
    		console.log("getDisabledTimes data ->", data);
    		return data || [];
		} catch (error) {
			console.error("Error fetching disabled times:", error);
            return [];
		}
    }
    
    // 불러온 비활성화 시간에 따른 버튼 비활성화
    function disableButtonsFromValue(startValue, count) {
    	const buttons = Array.from(document.querySelectorAll(".cal_time_btn"));
    	// 기준이 될 버튼 인덱스 찾기
    	const startIndex = buttons.findIndex((button) => button.value === startValue);
    	if (startIndex === -1) {
            console.error("해당 value를 가진 버튼을 찾을 수 없습니다:", startValue);
            return;
        }
    	
    	// 기준 인덱스부터 count 만큼 버튼 비활성화
        for (let i = startIndex; i < startIndex + count && i < buttons.length; i++) {
            buttons[i].disabled = true; // 버튼 비활성화
            buttons[i].classList.add("disabled-btn"); // 시각적 효과를 위한 클래스 추가 (선택 사항)
        }
    }
    
    
        
    // 시간 선택
    document.addEventListener("DOMContentLoaded", () => {
    	const cal_btn = document.querySelectorAll(".cal_time_btn");
    	
        cal_btn.forEach((button) => {
        	button.addEventListener("click", (e) => {
        		// 기존에 선택된 버튼이 있다면 선택 해제 -> 최대 한 개의 버튼만 선택 가능
        		const previouslySelected = document.querySelector(".cal_time_btn.selected_time");
                if (previouslySelected && previouslySelected !== button) {
                    previouslySelected.classList.remove("selected_time");
                }
                
        		const isSelected = button.classList.toggle("selected_time");	// 버튼 색 변경
        		const cal_btn_val = e.target.value;				// 버튼 value 가져오기
        		console.log("cal_btn_val : ", cal_btn_val);        		

                if (isSelected) {
                    // 버튼이 선택된 상태
                    console.log(`버튼 선택됨: \${button.value}`);
                    $('.select-rtime-div').css("display", "flex"); // 진료 소요 시간 드롭다운 표시
                } else {
                    // 버튼이 해제된 상태
                    console.log(`버튼 해제됨: \${button.value}`);
                    $('.select-rtime-div').css("display", "none"); // 진료 소요 시간 드롭다운 숨김
                }
				
        	});
        });
	});
    
    // 진료 소요 시간 선택    
    document.addEventListener("DOMContentLoaded", () => {
	    const numberInput = document.querySelector("#res-select-rtime");
	
	    // 값 변경 시 이벤트 처리
	    numberInput.addEventListener("input", (e) => {
	        const currentValue = e.target.value; // 현재 입력된 값 가져오기
	        console.log(`현재 입력된 값: \${currentValue}`);
	        
	        // 선택된 버튼 시간
	       const selectedButton = document.querySelector(".cal_time_btn.selected_time");
			
	        let selectedValue;
			if (selectedButton) {
			    selectedValue = selectedButton.value; // 버튼의 value 값 가져오기
			    console.log(`선택된 버튼의 value: \${selectedValue}`);
			} else {
			    console.log("선택된 버튼이 없습니다.");
			}
	        console.log(`현재 선택된 예약 시간: \${selectedValue}, 현재 입력된 진료 소요 시간:\${currentValue}`);
	        
	        const num = currentValue/30;
	        console.log("selectedValue : ", selectedValue, "num : ", num);
	        
	        // 기존 상태 초기화
	        resetButtonStates();

	        // 새롭게 비활성화 버튼 적용
	        buttonChangeFromRtime(selectedValue, num);
	    });
	});
    
 	// 기존 버튼 상태 초기화 함수
    function resetButtonStates() {
        const buttons = document.querySelectorAll(".cal_time_btn");
        buttons.forEach((button) => {
            // button.disabled = false; // 모든 버튼 활성화
            // button.classList.remove("selected_time"); // 클래스 초기화
            
            button.disabled = false; // 버튼 활성화
   	    	button.classList.remove("disabled-btn", "selected_time"); // 관련 클래스 제거
   	    	button.style.backgroundColor = ""; // 스타일 초기화
   	    	button.style.color = ""; // 텍스트 색 초기화
   	    	button.style.pointerEvents = "";
        });
    }
    
 	// 진료 소요 시간 변경에 따른 style 변화
    function buttonChangeFromRtime(startValue, count) {
    	const buttons = Array.from(document.querySelectorAll(".cal_time_btn"));
    	// 기준이 될 버튼 인덱스 찾기
    	const startIndex = buttons.findIndex((button) => button.value === startValue);
    	if (startIndex === -1) {
            console.error("해당 value를 가진 버튼을 찾을 수 없습니다:", startValue);
            return;
        }
    	
    	// 기준 인덱스부터 count 만큼 버튼 비활성화
        for (let i = startIndex; i < startIndex + count && i < buttons.length; i++) {
            buttons[i].disabled = true; // 버튼 비활성화
            buttons[i].classList.add("selected_time"); // 시각적 효과를 위한 클래스 추가 (선택 사항)
        }
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
    		url: `${contextPath}/api/mname/`+searchInput,
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
    
    // 보호자 이름 선택에 따른 동물 이름 가져오기 (동물이름 + 생년월일)
    $(function() {
    	$('#res-select-mname').change(() => {
    		console.log("보호자 이름 선택됨");
    		getPetname();
    	})
    })

    function getPetname(val) {
    	console.log("getPetname start ,,,");
		let memno = $("#res-select-mname option:selected").val();
    	console.log("memno : ", memno);
    	
    	$('.add-res-petname').remove();
    	$('#res-select-petname option:eq(0)').prop("selected", true);
    	
    	$.ajax({
    		url: `${contextPath}/api/petname/`+memno,
    		datatype: 'json',
    		success: function(data) {
    			console.log("data : ", data);
    			let str = "";
    			$(data).each(function(index, item) {
    				str += `<option value="\${item.PETNO}" class='.add-res-petname'>\${item.PETNAME}&nbsp;(\${item.PETBIRTH})</option>`;    				
    			})
    			$('#res-select-petname').html(str);
    			
    			if(memno) {
    				$('#res-select-petname').val(memno).prop('selected', true);
    			}
    		},
    		error: function(xhr, status, error) {
	            console.error("동물 이름 데이터를 가져오는 중 오류 발생:", error);
	        }
    	})
    	
    	
    }
    
   

	// ------ 예약 항목 > 선택된 대분류 값에 따른 중분류 값 가져오기
     /**
      * 대분류 선택 시 중분류 값 가져오기
      */
	$(function() {
		$("#res-content").change(() => {
			console.log("눌림");
			getMcd();
		});
	});
	
	/**
	 * 중분류 값 가져오기
	 */
	function getMcd(val) {
		let selectedOptionValue = $("#res-content option:selected").val();
		console.log(selectedOptionValue);
		
		$('.add-res-mcd').remove();
		$('#res-detail option:eq(0)').prop("selected", true);
		
		$.ajax({
			url: `${contextPath}/api/res-mcd/`+selectedOptionValue,
			dataType: 'json',
			success: function(data){
				
				let str = "";
				$(data).each(function(index, item) {
					str += `<option value="\${item.MCD}" class='.add-res-mcd'>\${item.CONTENT}</option>`;
				})
				
				$('#res-detail').html(str);
				
				if(val) {
					$('#res-detail').val(val).prop('selected', true);
				}
			},
			error: function(xhr, status, error) {
	            console.error("중분류 데이터를 가져오는 중 오류 발생:", error);
	        }
			
		})
	}
	
	
	
	// 예약 추가하기
	function validateForm() {
// 		$('.update_btn').click(function() {

			var sendData = $('form').serialize();
			// sendData에 1차로 들어오는 데이터: rtime, ano, mtitle_bcd, mtitle_mcd, petno, memo
			console.log("sendData : ", sendData);
			// 추가로 넣어줘야 할 것들: rdate, start_time				
            const rdate = selectedDateGlobal;
			const start_time = document.querySelector(".cal_time_btn.selected_time").value;
			const now = new Date();
			const resno = now.getTime();
			
			console.log("rdate : ", rdate, " start_time : ", start_time, "resno : ", resno);
			
			sendData = sendData + ('&rdate='+rdate) + ('&start_time='+start_time) + ('&resno='+resno);
			
			console.log("sendData : ", sendData);
			alert("sendData :"+ sendData);
			
			$('input:hidden[name=resno]').val(resno);
			$('input:hidden[name=rdate]').val(rdate);
			$('input:hidden[name=start_time]').val(start_time);
				
// 				location.href = "/admin/insertReservation?"+sendData;

			let result = confirm("예약을 추가하시겠습니까?") ;
			return result;
			
// 		})
	}
	
	
	document.getElementById("pro-update-form").addEventListener("keydown", function(event) {
		  if (event.key === "Enter" && event.target.tagName === "INPUT") {
		    event.preventDefault();
		  }
		});
	
</script>

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
                <form action="insertReservation" method="POST" onsubmit="return validateForm();" id="pro-update-form">             
                	<input type='hidden' name='resno' value=''>
                	<input type='hidden' name='rdate' value=''>
                	<input type='hidden' name='start_time' value=''>
                	
                	
                	<!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >예약 추가</h1>
                    
					    
			        <div class="modal_l"> 
			        	<!-- 제목을 제외한 컨텐츠 -->
			        	<div id="hr-res"> 
			        	
				        	<div id="hr-res-left">
				        		<p>예약 날짜</p>
				        		
				        		<!-- 달력 -->
				        		<div id="res-calendar" style="display: none">
				        			<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
									    <tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
									        <td><label onclick="prevCalendar()" class="cal-prev-btn" style="display: none">
									        	<i class="fa-solid fa-chevron-left"></i> 
									        </label></td>
									        <td align="center" id="tbCalendarYM" colspan="5">yyyy년 m월</td>
									        <td><label onclick="nextCalendar()" class="cal-next-btn">
							        		<i class="fa-solid fa-chevron-right"></i> 
							        	</label>
							        </td>
									    </tr>
									    <tr>
									        <td align="center"><font color ="red">일</td>
									        <td align="center">월</td>
									        <td align="center">화</td>
									        <td align="center">수</td>
									        <td align="center">목</td>
									        <td align="center">금</td>
									        <td align="center"><font color ="blue">토</td>
									    </tr> 
									</table>
									<script language="javascript" type="text/javascript">
									    buildCalendar();
									</script>
				        		</div>
								<!-- 시간 선택 -->
				        		<div id="cal_time" style="display: none">
			        				<hr>
				        			<table id="cal_time_table" width="100%" cellspacing="0">
				        				<tr>
				        					<td><button type="button" class="cal_time_btn" value="0900">09:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="0930">09:30</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1000">10:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1030">10:30</button></td>
				        				</tr>
				        				<tr>
				        					<td><button type="button" class="cal_time_btn" value="1100">11:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1130">11:30</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1200">12:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1230">12:30</button></td>
				        				</tr>
				        				<tr>
				        					<td><button type="button" class="cal_time_btn" value="1400">02:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1430">02:30</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1500">03:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1530">03:30</button></td>
				        				</tr>
				        				<tr>
				        					<td><button type="button" class="cal_time_btn" value="1600">04:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1630">04:30</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1700">05:00</button></td>
				        					<td><button type="button" class="cal_time_btn" value="1730">05:30</button></td>
				        				</tr>
				        			</table>
				        			
				        		<div class="select-rtime-div"  style="display: none; align-items: center;">
					        		<p style="font-size: 16px; padding: 8px 12px;">진료 소요 시간(분)</p>
					        		<input name="rtime" id="res-select-rtime" type="number" step="30"
					        			style="padding:0 12px; border: 1px solid var(--haru); border-radius: 10px; width: 70px; height: 30px; " required>							        						
				        		</div>

				        		</div>
				        		
				        	</div>
				        	
				        	<div id="hr-res-right">
				        		<div class="hr-table-res-modal">
						        	<table id="hr-table-res-modal-data">
						        		
						        			<tr>
						        				<th>담당의</th>
						        				<td>
						        					<div>
								                       	<select id="res-doc" name="ano" required>
								                       		<option disabled selected value="0">선택</option>
								                    		<c:forEach var="d" items="${docList}">
								                    			<option value="${d.ANO}">${d.ANAME}&nbsp;선생님</option>
								                    		</c:forEach>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>	
						        			<tr>
						        				<th>예약 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-content" name="mtitle_bcd" required>
								                    		<option disabled selected value="0">선택</option>
								                    		<c:forEach var="bcd" items="${bcdList}">
								                    			<option value="${bcd.BCD}" class="res-content-bcd">${bcd.CONTENT}</option>
								                    		</c:forEach>
								                    	</select>
								                    </div>
						        				</td>			        						        								        				
						        			</tr>
						        			<tr>
						        				<th>세부 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-detail" name="mtitle_mcd" required>
								                    		<option disabled selected value="0">선택</option>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>
						        									        		
						        			<tr>
						        				<th>보호자</th>
						        				<td>
						        					<div style="display: flex">
						        						<input type="text" name="search1" id="res-mname"
						        								onkeypress="console.log('onkeypress 실행됨'); if (event.key === 'Enter') search_mname(event)"
						        								value="${search1 }" required="required">
								                       	<select id="res-select-mname" name="memno" style="display:none" required>
								                       		<option disabled selected value="0">선택</option>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>
						        			
						        			<tr>
						        				<th>동물이름</th>
						        				<td>
						        					<select id="res-select-petname" name="petno" required>
						        						<option disabled selected value="0">선택</option>
						        					</select>
						        				</td>
						        			</tr>
						
						
						
						        	</table>
						        </div>
						        
				        <p>예약 메모</p>
				        <div id="hr-res-memo">
				        	<textarea rows="10" cols="70" placeholder="예약 메모를 입력해주세요." name="memo"></textarea>
				        </div>
	        		
		        	</div>
		        
	        	</div>
	        	
	        
		        
	        </div>
	        
			        <!-- 모달 버튼 -->
			        <div class="modal_l-content-btn">
			        	<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
			        	<button type="submit" class="update_btn" form="pro-update-form">예약추가</button>
			        </div>
					
                </form>
                
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
    

</body>
</html>