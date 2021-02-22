if (location.pathname.match("articles/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("article_tag_list");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("article_tag_list").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
    });
  });
};