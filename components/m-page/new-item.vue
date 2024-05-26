<template>
  <div class="w-full border-border border-2 rounded-3xl">
    <div class="flex md:flex-row flex-col md:p-8 p-4 md:items-center gap-8">
      <img src="/public/hades2/1.jpeg" class="md:w-[50%] rounded-3xl" alt="" />
      <div class="flex flex-col gap-6">
        <div>
          <p class="font-medium text-[16px] text-muted-foreground">
            07.05.2024
          </p>
          <p class="font-semibold sm:text-[46px] text-[26px]">Hades II</p>
          <ul class="flex gap-2">
            <li class="bg-primary py-[2px] px-[6px] rounded-lg">#action</li>
            <li class="bg-primary py-[2px] px-[6px] rounded-lg">#rpg</li>
          </ul>
        </div>
        <div class="flex items-center gap-2">
          <img src="/public/steam.png" width="30px" alt="steam" />
          <p class="font-semibold text-[18px]">1 100 ₽</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup></script>

<style>
p {
  margin: 0px;
  padding: 0px;
}
</style>
