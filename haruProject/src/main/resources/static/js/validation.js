/**
 * null, undefined, 공백, 0 체크
 * true : 공백없음
 * false : 있음
 */
 function isEmpty(value) {
	console.log('isEmpty : ', value);
    return !(!value || value.trim() === "" || value == 0);
}


/**
 * ISO 8601 형식의 날짜 문자열(2025-01-02T07:27:48.524+00:00)을 
 * YYYY-MM-DD HH:MM:SS 형식으로 변환하는 함수
 */
function ISODateFormat(dateString) {
	console.log(dateString)
	
    const date = new Date(dateString);

    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}
