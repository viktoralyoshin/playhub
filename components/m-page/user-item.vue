<template>
  <div>
    <Card class="cursor-pointer hover:bg-muted transition-all ease-in-out duration-200"
      @click="
        async () => await navigateTo(`/users/${user.id}`, { replace: true })
      "
    >
      <CardHeader />
      <CardContent class="flex flex-col gap-4 items-center justify-center">
        <Avatar class="w-[100px] h-[100px]">
          <AvatarImage :src="user.avatar" alt="" />
          <AvatarFallback>{{ user.username }}</AvatarFallback>
        </Avatar>
        <div class="flex flex-col items-center w-full">
          <h1 class="font-semibold text-[24px] text-center truncate w-[95%]">{{ user.username }}</h1>
          <div class="flex flex-col items-center">
            <h2 class="font-semibold text-[16px] text-muted-foreground">
              Отзывы
            </h2>
            <h2 class="font-semibold text-[18px]">
              {{ reviewCount }}
            </h2>
          </div>
        </div>
      </CardContent>
    </Card>
  </div>
</template>

<script lang="ts" setup>
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
const props = defineProps({
  user: {
    type: Object,
    required: true,
  },
});
const { user } = props;

const { reviewCount } = await $fetch("http://92.53.105.185:5000/api/user/get", {
  method: "POST",
  body: {
    id: user.id,
  },
});
</script>

<style></style>
