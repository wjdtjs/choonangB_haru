/**
 * 상품 등록, 상품 상세 및 수정 javascript 파일
 */


/* 썸네일 이미지 선택 */
const mainImg = document.getElementById('main_img');
mainImg.addEventListener('change', (e) => {
	const files = e.currentTarget.files;
	
	if (files && files[0]) {
        const reader = new FileReader();
        
        // 파일 로드 완료 시 실행
        reader.onload = function(event) {
        	console.log(event)
            // 파일의 데이터 URL을 가져와 이미지 태그 생성
            const imgTag = `<img src="${event.target.result}" alt="product-image" style="width: 7rem; height: 7rem"/>`;
            
            $('.pro-label-div').css('display', 'none');
            $('.pro-mainimg-div').css('display', 'block');
            $('.pro-mainimg-div').html(imgTag);
         	$('.pro-mainimg-div').addClass('pro-thumbnail');
        };
        
     	reader.readAsDataURL(files[0]);

    }
    
})

/**
 * 대분류 선택 시 중분류 값 가져오기
 */
$(".sub-bcd-select").change(() => {
	getMcd();
})
 	
/**
 * 중분류 값 가져오기
 */
function getMcd(val) {
	let selectedOptionValue = $(".sub-bcd-select option:selected").val();
//		console.log(selectedOptionValue);

	$('.add-product-mcd').remove();
	$('.sub-mcd-select option:eq(0)').prop("selected", true);
	
	$.ajax({
		url: `${contextPath}/api/product-mcd/`+selectedOptionValue,
		dataType: 'json',
		success: function(data){
			
			let str = "";
			$(data).each(function() {
				str += `<option value="${this.MCD}" class="add-product-mcd">${this.CONTENT}</option>`;
			})
			
			$('.sub-mcd-select').append(str);
			
			if(val) {
				$('.sub-mcd-select').val(val).prop('selected', true);
			}
		}
		
	})
}
   	
/**
 * 썸네일 이미지 삭제
 */
document.querySelector('.pro-mainimg-div').addEventListener('click', () => {
	console.log('썸네일 삭제');
	$('#main_img').val('');
    $('.pro-mainimg-div').css('display', 'none');
 	$('.pro-label-div').css('display', 'block');
});
