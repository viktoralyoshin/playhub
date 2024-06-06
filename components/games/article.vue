<template>
  <div class="flex flex-col gap-2 border-[1px] rounded-xl p-8">
    <div class="flex items-center justify-between">
      <div
        @click="
          async () => await navigateTo(`/users/${user.id}`, { replace: true })
        "
        class="flex gap-2 items-center bg-black border-[1px] hover:bg-accent py-2 px-4 rounded-xl transition-all duration-200 ease-in-out cursor-pointer"
      >
        <Avatar class="w-[50px] h-[50px]">
          <AvatarImage :src="user.avatar" alt="@radix-vue" />
          <AvatarFallback>{{ user.username }}</AvatarFallback>
        </Avatar>
        <div class="flex flex-col items-start">
          <p class="font-medium text-[16px]">{{ user.username }}</p>
          <p class="font-medium text-[12px] text-muted-foreground">
            Уровень {{ user.level }}
          </p>
        </div>
      </div>
    </div>
    <div>
      <h1 class="font-semibold text-[24px] sm:text-[36px]">
        {{ article.title }}
      </h1>
    </div>
    <div>
      <span class="bg-primary p-1 rounded-md">#{{ tag.name }}</span>
    </div>
    <Separator />
    <div>
      <p class="font-medium text-[18px] text-left">
        {{ article.text }}
      </p>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Separator } from "@/components/ui/separator";

const props = defineProps({
  article: {
    type: Object,
    required: true,
  },
});
const { article } = props;

const user = await $fetch("http://92.53.105.185:5000/api/user/get", {
  method: "POST",
  body: {
    id: article.userId,
  },
});

const tag = await $fetch("http://92.53.105.185:5000/api/tag/get", {
  method: "POST",
  body: {
    id: article.tagId,
  },
});
</script>

<style></style>
