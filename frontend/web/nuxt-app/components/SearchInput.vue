<template>
    <div class="search-bar">
        <i class='bx bx-search-alt-2'></i>
        <input type="text" class="input">
    </div>
</template>
<style scoped>
.search-bar{
    width: 200px;
    height: 35px;
    background-color: rgba(0,0,0,.5);
    backdrop-filter: blur(10px);
    border-radius: 12px;
    margin-left: auto;
    display:flex;
    justify-content: flex-start;
    padding: 2px 10px;
    align-items: center;

    .bx{
        color:white;
        font-size: 20px;
        flex-shrink: 0;
        margin-right: 5px;
    }

    .input{
        flex: 1;
        background-color: transparent;
        outline:none;
        border:none;
        color:white;
    }
}
</style>