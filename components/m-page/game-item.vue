<template>
  <div
    class="flex rounded-xl items-center justify-between hover:bg-muted transition-all duration-300 ease-in-out cursor-pointer"
    @click="() => navigateTo(`/games/${game.id}`)"
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
      :class="`flex justify-center items-center font-semibold py-2 ${color} rounded-full px-4 text-white mr-4`"
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

const color = ref("");
const setColor = (mark: number) => {
  if (mark > 84) {
    color.value = "bg-green-900";
  } else if (mark > 69 && mark < 85) {
    color.value = "bg-green-700";
  } else if (mark > 50 && mark < 70) {
    color.value = "bg-yellow-600";
  } else if (mark > 30 && mark < 51) {
    color.value = "bg-orange-500";
  } else {
    color.value = "bg-red-700";
  }
};
onMounted(() => {
  setColor(game.mark);
});
</script>

<style></style>
