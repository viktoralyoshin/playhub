<template>
  <div
    class="flex rounded-xl items-center justify-between hover:bg-muted transition-all duration-300 ease-in-out cursor-pointer"
    @click="() => navigateTo(`/games/${game.id}/`)"
  >
    <div class="flex items-center gap-2">
      <img
        :src="game.cover"
        class="rounded-xl m-2"
        width="70"
        height="70"
        alt=""
      />
      <p class="font-semibold truncate">{{ game.name }}</p>
    </div>
    <div
      :class="`flex justify-center items-center font-semibold py-2 bg-${color}-700 rounded-full px-4 text-white mr-4`"
    >
      {{ game.mark }}
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

const color = ref('')

onMounted(() => {
  if (game.mark >= 70) {
    color.value = "green";
  } else if (game.mark > 50) {
    color.value = "yellow";
  } else if (game.mark > 30) {
    color.value = "orange";
  } else {
    color.value = "red";
  }
});

</script>

<style></style>
