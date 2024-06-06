<template>
  <div
    class="flex rounded-xl items-center justify-between hover:bg-muted transition-all duration-300 ease-in-out cursor-pointer"
    @click="async () => await navigateTo(`/games/${game.id}`)"
  >
    <div class="flex items-center gap-2">
      <img :src="game.cover" class="rounded-xl m-2" width="70" height="70" alt="" />
      <p class="font-semibold truncate">{{game.name}}</p>
    </div>
  </div>
</template>

<script lang="ts" setup>
const props = defineProps({
  game: {
    type: Object,
    required: true,
  },
});
const { game } = props;
</script>

<style></style>
