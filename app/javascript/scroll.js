$(document).on("turbolinks:load", function() {
  if ($("nav.pagination a[rel=next]").length){
    $(".messages").infiniteScroll({
      path: "nav.pagination a[rel=next]",
      append: ".user_list div",
      elementScroll: true,
      history: true,
      prefill: false,
      status: ".page-load-status",
      hideNav: ".pagination"
    });
  };
});