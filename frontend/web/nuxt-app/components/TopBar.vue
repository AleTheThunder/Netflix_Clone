<script setup lang="ts">
import SearchInput from '../components/SearchInput.vue';
</script>

<template>
    <div class="top-bar">
        <div class="logo">
            Streamy
        </div>
        <div class="nav">
            <div class="nav-item">Home</div>
            <div class="nav-item">Browse</div>
            <div class="nav-item">Genre</div>
        </div>
        <SearchInput/>
        <div class="profile">
            <img src="@/assets/img/profile.webp" class="image">
        </div>
    </div>
</template>
<style scoped>
.top-bar{
    position: fixed;
    left: 0; top: 0;
    background: linear-gradient(to bottom, rgba(0,0,0,.7), rgba(0,0,0,.5), rgba(0,0,0,0));
    height: 80px;
    width: 100%;
    border-bottom: 2px solid transparent;
    background-clip: padding-box;
    z-index: 10;
    display:flex;
    justify-content: flex-start;
    transition: border-color .4s ease, background .4s ease;
    align-items: center;
    padding: 5px 50px;

    .logo{
        width: fit-content;
        height: 40px;
        display:flex;
        justify-content: center;
        align-items: center;
        color:white;
        font-weight: bolder;
        font-size: 28px;
    }

    .nav{
        width: fit-content;
        height: 40px;
        display:flex;
        justify-content: center;
        align-items: center;
        margin-left: 50px;

        .nav-item{
            color:white;
            opacity: .5;
            transition: .2s ease;
            cursor: pointer;
            margin-right: 40px;
        }

        .nav-item:hover{
            opacity: 1;
        }
    }

    .profile{
        margin-left: 20px;
        width: 35px;
        height: 35px;

        .image{
            border-radius: 4px;
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }
    }
}

.top-bar.solid{
    background-color: #202020;
    border-color: var(--accent-color);
}
</style>