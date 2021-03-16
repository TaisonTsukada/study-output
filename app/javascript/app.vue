<template>
  <div id="app">
    <nav>
      <router-link 
        to="/" 
        active-class="link--active"
        exact
        class="link"
      >Home</router-link>
      <router-link 
        to="/users" 
        class="link"
        active-class="link--active"
        exact
      >Users</router-link>
    </nav>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
