<script setup >
const route = useRoute();
const router = useRouter();
var topBar;

function scrollListener(e){
    topBar.classList.toggle('solid', e.target.scrollTop >= 400);
}

function visitContent(){
    router.push({name: 'content'});
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
    <div class="content-showcase">
        <img src="@/assets/img/banner/iron_man.jpg">
    </div>
    <div class="category-header">Newly Added:</div>
    <div class="category-wrapper">
        <div class="content-item" @click="visitContent">
            <div class="image-wrapper">
                <img class="image" src="@/assets/img/poster/iron_man.jpg">
            </div>
            <div class="name">Iron Man</div>
        </div>
    </div>
    <div class="placeholder" style="width: 100%;height: 1000px;"></div>
  </div>
</template>
<style scoped>
.content-showcase{
    width: 100%;
    height: 500px;
    overflow: hidden;
    position: relative;

    &::after{
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 100px;
        pointer-events: none;
        background: linear-gradient(to top, rgba(0,0,0,1), rgba(0,0,0,0))
    }
}

.category-header{
    width: 100%;
    height: fit-content;
    margin-top: 10px;
    text-align: start;
    padding: 5px 50px;
    color:white;
    font-weight: bolder;
    letter-spacing: 1.5px;
    font-size: 18px;
}

.category-wrapper{
    width: 100%;
    margin-top: 5px;
    padding: 0px 50px;
    height: fit-content;
    display:flex;
    justify-content: flex-start;
    align-items: center;

    .content-item{
        height: 280px;
        aspect-ratio: 0.6;
        overflow: hidden;
        border-radius: 6px;
        position: relative;
        cursor: pointer;

        .image-wrapper{
            width: 100%;
            height: calc(100% - 30px);
            border-radius: 5px;
            overflow: hidden;

            .image{
                width: 100%;
                height: 100%;
                object-fit: cover;
                view-transition-name: content-poster;
                contain: layout;
            }
        }

        .name{
            position: absolute;
            bottom: 5px;
            left: 5px;
            right: 5px;
            width: calc(100% - 10px);
            color:white;
            font-weight: bold;
            font-size: 14px;
            text-align: start;
            view-transition-name: content-name;
            contain: layout;
        }
    }
}
</style>