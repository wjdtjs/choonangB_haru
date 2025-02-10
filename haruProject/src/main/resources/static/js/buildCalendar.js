
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

/**
 * 달력 그리기
 */
function buildCalendar(disabledDates) {
//	console.log("buildCalendar disabledDates ->", disabledDates);
	
    var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
    var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    var tbCalendar = document.getElementById("calendar");
    var tbCalendarYM = document.getElementById("tbCalendarYM");		// 제목(연도, 월) 작성

    tbCalendarYM.innerHTML = `${today.getFullYear()}년 ${today.getMonth() + 1}월`;

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
//            cell.bgColor = "#A6D6C5";
        }
        
        const dateStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, "0")}-${String(currentDay).padStart(2, "0")}`;
//        console.log("dateStr ->", dateStr);
        
     	// value 배열의 날짜를 YYYY-MM-DD 형식으로 변환
     	if(disabledDates) {
	        const dateValue = disabledDates.map(date => {
	            const d = new Date(date);
	            return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
       		 });
			 
			 // 비활성화 날짜 처리         	
	        if (dateValue.includes(dateStr)) {
	            cell.style.backgroundColor = "lightgray";
	            cell.style.pointerEvents = "none"; // 클릭 비활성화
	            cell.style.opacity = "0.6"; // 시각적 효과
	        } else {
	            // 날짜 클릭 이벤트 추가
	            cell.addEventListener("click", async function () {
	            	// 두 자리 수로 맞추기 위한 함수 (ex: 1 -> 01)
	            	const padZero = (num) => (num < 10 ? `0${num}` : `${num}`);
	            	
	            	// yy/MM/dd로 변환
	                const selectedDate = `${today.getFullYear()}/${padZero(today.getMonth() + 1)}/${padZero(currentDay)}`;
	                selectedDateGlobal = selectedDate
	
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
}

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


/**
 * 비활성화 날짜 불러오기
 */
async function getDisabledDates(docValue) {
	var current_m = today.getMonth()+1;
	try {
		console.log("getDisabledDates docValue ->"+docValue);
		console.log("getDisabledDates api url ->", `/api/disabled-dates?ano=${docValue}&month=${current_m}`);
        const response = await fetch(`/api/disabled-dates?ano=${docValue}&month=${current_m}`, {
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
        const response = await fetch(`/api/vet-regular-holiday?ano=${docValue}&formattedDateEnd=${formatted_lastdate}`, {
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
	$(".user-body-container").animate({ scrollTop: $(document).height() }, 500);
}
    
// 선택한 날짜에 따른 비활성화 시간 불러오기
async function getDisabledTimes(selectedDate) {
	try {
		const docValue = selected_vet;
		console.log("getDisabledTimes selected ano : ", docValue);
		console.log("getDisabledTimes docValue ->"+docValue);
		console.log("getDisabledTimes api url ->", `/api/disabled-times?rdate=${selectedDate}&ano=${docValue}`);
		    		
		const response = await fetch(`/api/disabled-times?rdate=${selectedDate}&ano=${docValue}`, {
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

$(".cal_time_btn").click(function() {
    const previouslySelected = $(".cal_time_btn.selected_time");
    if (previouslySelected && previouslySelected !== $(this)) {
        previouslySelected.removeClass("selected_time");
    }
    
	$(this).toggleClass("selected_time");	// 버튼 색 변경
	
	/* 필수 선택시에만 버튼 활성화 디자인 */
    if($('input:radio[name=ano]').is(':checked') 
			&& $('.cal_time_btn.selected_time').val()!=null 
	) {
		$('button[type=submit]').css('background', 'var(--haru)');
	} else {
		$('button[type=submit]').css('background', '#d9d9d9');
	}

});    	