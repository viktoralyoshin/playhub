<template>
  <div>
    <DropdownMenu>
      <DropdownMenuTrigger
        ><div class="flex gap-2 items-center bg-black hover:bg-accent py-2 px-4 rounded-xl transition-all duration-200 ease-in-out">
          <Avatar class="w-[50px] h-[50px]">
            <AvatarImage
              src="https://github.com/radix-vue.png"
              alt="@radix-vue"
            />
            <AvatarFallback>{{ authStore.user.username }}</AvatarFallback>
          </Avatar>
          <div class="flex flex-col items-start">
            <p class="font-medium text-[16px]">{{ authStore.user.username }}</p>
            <p class="font-medium text-[12px] text-muted-foreground">Уровень {{ authStore.user.level }}</p>
          </div>
        </div></DropdownMenuTrigger
      >
      <DropdownMenuContent>
        <DropdownMenuLabel>Мой аккаунт</DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuItem class="flex gap-2 items-center"
          ><User />Профиль</DropdownMenuItem
        >
        <DropdownMenuSeparator />
        <DropdownMenuItem class="flex gap-2 items-center" @click="logout"
          ><LogOut />Выйти</DropdownMenuItem
        >
      </DropdownMenuContent>
    </DropdownMenu>
  </div>
</template>

<script lang="ts" setup>
import { LogOut, Settings, User } from "lucide-vue-next";

import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuPortal,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

const authStore = useAuthStore();

const logout = async () => {
  const response = await $fetch("http://92.53.105.185:5000/api/user/logout", {
    method: "post",
    credentials: "include",
  });
  authStore.clear();
  navigateTo("/signin");
};
</script>

<style></style>
