function getdatafrombiji(){
  var arr1 = []
  var arr2 = []
  var arr3 = []
  $('td').each(function(index){arr1.push($.trim($(this).context.textContent))})
  $('.de-item').each(function(){arr2.push($.trim($(this).html()))})
  $('.detail-content').find('i').each(function(){arr3.push($.trim($(this).attr('class')))})
  $.ajax({
    url: 'https://api.sports-link.online',
    data: {
    name: $('.field-name').html(),
    ratyrate: arr2,
    score: $('.score-num').html(),
    link: $('#field-map iframe').attr('data-src'),
    img: $('.swiper-slide').attr('style'),
    fac: arr3,
    context: arr1},
    success: function(data){
    console.log('success')
    }
  })
  arr1 = []
  arr2 = []
  arr3 = []
}