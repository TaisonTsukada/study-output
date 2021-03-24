import Vue from "vue";
import ActionCable from 'actioncable';
import App from "../app.vue";

const cable = ActionCable.createConsumer('ws:hoge.com:3000/cable');
Vue.prototype.$cable = cable;

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});