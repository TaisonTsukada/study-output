<template>
  <div id="app">
    <following></following>
  </div>
</template>

<script>
import Following from './components/Following';
export default {
  data: function() {
    return {
      message: "Hello Vue!"
    };
  },
  components: {
    Following
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
