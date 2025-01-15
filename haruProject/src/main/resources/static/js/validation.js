/**
 * null, undefined, 공백, 0 체크
 * true : 공백없음
 * false : 있음
 */
 function isEmpty(value) {
	console.log("a: ", value)

    return !(!value || value.trim() === "" || value == 0);
}