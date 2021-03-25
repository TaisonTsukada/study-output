if (document.URL.match( /rooms/ ) ){
  function autoScroll(){
    const obj = document.getElementById("msg-history");
    obj.scrollTop = obj.scrollHeight;
  };
  
  document.addEventListener("turbolinks:load", autoScroll)
};