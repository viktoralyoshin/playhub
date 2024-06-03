<template>
  <div class="flex flex-col gap-2 border-[1px] rounded-xl p-8">
    <div class="flex items-center justify-between">
      <div
        class="flex gap-2 items-center bg-black hover:bg-accent py-2 px-4 rounded-xl transition-all duration-200 ease-in-out cursor-pointer"
      >
        <Avatar class="w-[50px] h-[50px]">
          <AvatarImage
            src="https://github.com/radix-vue.png"
            alt="@radix-vue"
          />
          <AvatarFallback>1rowvy</AvatarFallback>
        </Avatar>
        <div class="flex flex-col items-start">
          <p class="font-medium text-[16px]">1rowvy</p>
          <p class="font-medium text-[12px] text-muted-foreground">
            Уровень 1
          </p>
        </div>
      </div>
      <div
        class="flex justify-center items-center font-semibold py-2 bg-green-700 rounded-full px-4 text-white mr-4"
      >
        95
      </div>
    </div>
    <div>
      <h1 class="font-semibold text-[36px]">Отличная игра</h1>
    </div>
    <Separator />
    <div>
      <p class="font-medium text-[18px]">
        На самом деле прекрасная игра, объединяет людей сплотиться ради победы,
        тут люди пытаются поддержать тебя, когда ты умираешь, кидают тебе
        "спасибо", иногда даже ребята при твоей смерти ставят паузу, скорее
        всего из-за того что переживают сильно и пытаются успокоиться и привести
        себя в норму, больше всего удивляет, что некоторые игроки знакомы с
        твоей мамой, что довольно странно, мир тесен. Бывает даже когда люди
        используют кнопку голоса, чтобы напеть или включить через динамики
        какой-нибудь свой любимый трек, видимо делятся своими интересами и
        пытаются найти друзей :3
      </p>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Separator } from "@/components/ui/separator";
const authStore = useAuthStore();
</script>

<style></style>
