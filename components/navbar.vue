<template>
  <div class="w-screen bg-transparent absolute">
    <div
      class="flex justify-between items-center px-4 max-w-[1400px] mx-auto py-4"
    >
      <div class="flex items-center gap-[40px]">
        <div class="flex gap-[10px] items-center cursor-pointer" @click="()=>navigateTo('/')">
          <img src="/logo.png" width="50" alt="logo" />
          <h1 class="font-semibold text-[24px] font-eng">
            <span class="font-eng text-primary font-semibold">Play</span>Hub
          </h1>
        </div>
        <nav class="hidden gap-[20px] items-center text-[18px] sm:flex">
          <a
            href="#"
            class="opacity-70 hover:opacity-100 transition-all ease-in-out duration-300"
            >Новинки</a
          >
          <a
            href="#"
            class="opacity-70 hover:opacity-100 transition-all ease-in-out duration-300"
            >Все игры</a
          >
          <a
            href="#"
            class="opacity-70 hover:opacity-100 transition-all ease-in-out duration-300"
            >Статьи</a
          >
        </nav>
      </div>
      <Button
        v-if="!authStore.isAuth"
        class="hidden sm:flex hover:bg-accent-foreground text-black backdrop-opacity-10 backdrop-invert bg-white/60"
        as-child
        ><a href="/signin"><UserRound class="w-6 h-6 mr-2" />Войти</a></Button
      >
      <NavbarProfile v-else />
      <!-- <UserRound class="w-6 h-6 mr-2" /> -->
      <Sheet>
        <SheetTrigger as-child>
          <AlignRight class="sm:hidden flex" />
        </SheetTrigger>
        <SheetContent>
          <SheetHeader>
            <SheetTitle
              ><img src="/logo.png" width="40" height="40" alt="logo"
            /></SheetTitle>
          </SheetHeader>
          <div class="py-[50px]">
            <nav class="flex flex-col gap-[30px]">
              <a href="#">Новинки</a>
              <a href="#">Все игры</a>
              <a href="#">Статьи</a>
            </nav>
          </div>
          <SheetFooter>
            <SheetClose as-child>
              <Button type="submit" as-child>
                <a href="/signin"><UserRound class="w-6 h-6 mr-2" />Войти</a>
              </Button>
            </SheetClose>
          </SheetFooter>
        </SheetContent>
      </Sheet>
    </div>
  </div>
</template>

<script lang="ts" setup>

import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetDescription,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";
import { UserRound, AlignRight } from "lucide-vue-next";

const authStore = useAuthStore();

</script>

<style></style>
