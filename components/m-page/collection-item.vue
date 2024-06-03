<template>
  <div
    class="flex rounded-xl items-center justify-between hover:bg-muted transition-all duration-300 ease-in-out cursor-pointer"
    @click="() => navigateTo('/games/dota2/')"
  >
    <div class="flex items-center gap-2">
      <img
        src="/mb2/cover.jpg"
        class="rounded-xl m-2"
        width="70"
        height="70"
        alt=""
      />
      <p class="font-semibold truncate">Mount & Blade II: Bannerlord</p>
    </div>
    <div
      class="flex justify-center items-center font-semibold py-2 bg-green-700 rounded-full px-4 text-white mr-4"
    >
      75
    </div>
  </div>
</template>

<script lang="ts" setup></script>

<style></style>
