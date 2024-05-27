<template>
  <div class="h-screen flex justify-center items-center"><slot /> <div class="bg-image w-full h-full"></div></div>
</template>

<script lang="ts" setup></script>

<style>
.bg-image {
  background: url("/public/bg.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
}
</style>
