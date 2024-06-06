<template>
  <div
    class="w-full border-border border rounded-3xl cursor-pointer"
    @click="async () => await navigateTo(`/games/${game.id}`)"
  >
    <div class="flex md:flex-row flex-col md:p-8 p-4 md:items-center gap-8">
      <img :src="images[0].src" class="md:w-[50%] rounded-3xl" alt="" />
      <div class="flex flex-col gap-6">
        <div>
          <p class="font-medium text-[16px] text-muted-foreground">
            {{ game.releaseDate }}
          </p>
          <p class="font-semibold sm:text-[46px] text-[24px] truncate">
            {{ game.name }}
          </p>
          <ul class="flex gap-2">
            <li class="bg-primary py-[2px] px-[6px] rounded-lg">
              #{{ genre.name }}
            </li>
          </ul>
        </div>
        <div class="flex items-center gap-2">
          <p class="font-semibold text-[18px]">
            {{ game.price == 0 ? "Бесплатно" : game.price + " ₽" }}
          </p>
        </div>
      </div>
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
const { images, genre } = await $fetch("http://92.53.105.185:5000/api/game/get", {
  method: "POST",
  body: {
    id: game.id,
  },
});
</script>

<style>
p {
  margin: 0px;
  padding: 0px;
}
</style>
