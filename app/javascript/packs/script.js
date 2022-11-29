/*global $*/

//タブ表示機能
//初期表示
$('#tab-contents .tab[id != "tab1"]').hide();
//クリック時のイベント
$('#tab-menu a').on('click', function(event) {
  $("#tab-contents .tab").hide();
  $("#tab-menu .active").removeClass("active");
  $(this).addClass("active");
  $($(this).attr("href")).show();
  event.preventDefault();
});