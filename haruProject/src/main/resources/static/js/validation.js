/**
 * null, undefined, 공백, 0 체크
 * true : 공백없음
 * false : 있음
 */
function isEmpty(value) {
//    console.log('isEmpty : ', value);
    return !(
        value === undefined || 
        value === null || 
        (typeof value === "string" && value.trim() === "") || 
        (typeof value !== "string" && value == 0)
    );
}


/**
 * ISO 8601 형식의 날짜 문자열(2025-01-02T07:27:48.524+00:00)을 
 * YYYY-MM-DD HH:MM:SS 형식으로 변환하는 함수
 */
function ISODateFormat(dateString) {
//	console.log(dateString)
	
    const date = new Date(dateString);

    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}


/**
 * 정규식 체크
 * @param str   체크할 문자열
 * @param regex 정규식
 */
function checkRegex(str, regex) {
    let re = new RegExp(regex);
  
    let result = re.test(str);
//    console.log(result);
    return result;
}



/**
 * 로딩페이지
 */
function FunLoadingBarStart() {    
	let backHeight = $(document).height();               	//뒷 배경의 상하 폭    
	let backWidth = window.document.body.clientWidth;		//뒷 배경의 좌우 폭     
	let backGroundCover = "<div id='back'></div>";			//뒷 배경을 감쌀 커버    
	let loadingBarImage = '';								//가운데 띄워 줄 이미지     
	loadingBarImage += "<div id='loadingBar'>";    
	loadingBarImage += "<span style='color: white; font-size: 11px;'>잠시만 기다려 주세요..</span>"; //로딩 바 이미지    
	loadingBarImage += "</div>";     $('body').append(backGroundCover).append(loadingBarImage);      
	$('#back').css({ 'width': backWidth, 'height': backHeight, 'opacity': '0.3' });    
	$('#back').show();     
	$('#loadingBar').show();
}

/**
 * 로딩 종료
 */
function FunLoadingBarEnd() {    
	$('#back, #loadingBar').hide();    
	$('#back, #loadingBar').remove();
}
