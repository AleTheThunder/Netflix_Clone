<script setup >
const route = useRoute();
var topBar;

function scrollListener(e){
    topBar.classList.toggle('solid', e.target.scrollTop >= 400);
}

if(process.client){
    const body = document.body;
    body.addEventListener('scroll', scrollListener);
    topBar = document.querySelector('.top-bar');
}
</script>

<template>
  <div id="app">
    <TopBar/>
    <img class="image" src="@/assets/img/poster/iron_man.jpg">
    <span class="name">Iron Man</span>
  </div>
</template>
<style scoped>
.image{
    margin-top: 100px;
    height: 250px;
    aspect-ratio: .6;
    view-timeline-name: content-image;
}

.name{
    view-timeline-name: content-name;
    color:white;
    font-weight: bold;
    font-size: 18px;
}
</style>