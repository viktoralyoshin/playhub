<template>
  <div class="h-screen md:flex hidden justify-center items-center"><slot /> <div class="bg-image h-full flex md:w-1/2 xl:w-2/3"></div></div>
  <div class="h-screen flex md:hidden justify-center items-center bg-image"><slot /> <div class="bg-image h-full hidden md:flex md:w-1/2 xl:w-2/3"></div></div>
</template>

<script lang="ts" setup></script>

<style>
.bg-image {
  background: url("/public/bg-form.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
}
</style>
