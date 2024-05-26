<template>
  <div class="w-full">
    <div
      class="flex justify-between items-center px-4 max-w-[1400px] mx-auto py-4"
    >
      <div class="flex items-center gap-[10px]">
        <img src="/logo.png" width="50" alt="logo" />
        <h1 class="font-semibold text-[24px] font-eng">
          <span class="font-eng text-primary font-semibold">Play</span>Hub
        </h1>
      </div>
      <nav class="hidden gap-[40px] items-center text-[18px] sm:flex">
        <a
          href="#"
          class="opacity-70 hover:opacity-100 transition-all ease-in-out duration-300"
          >новинки</a
        >
        <a
          href="#"
          class="opacity-70 hover:opacity-100 transition-all ease-in-out duration-300"
          >все игры</a
        >
        <a
          href="#"
          class="opacity-70 hover:opacity-100 transition-all ease-in-out duration-300"
          >статьи</a
        >
      </nav>
      <Button class="hidden sm:flex" variant="outline"
        ><UserRound class="w-6 h-6 mr-2" />Войти</Button
      >
      <Sheet>
        <SheetTrigger as-child>
          <AlignRight class="sm:hidden flex" />
        </SheetTrigger>
        <SheetContent>
          <SheetHeader>
            <SheetTitle><img src="/logo.png" width="40" height="40" alt="logo" /></SheetTitle>
          </SheetHeader>
          <div class="py-[50px]">
            <nav class="flex flex-col gap-[30px]">
              <a
                href="#"
                >Новинки</a
              >
              <a
                href="#"
                >Все игры</a
              >
              <a
                href="#"
                >Статьи</a
              >
            </nav>
          </div>
          <SheetFooter>
            <SheetClose as-child>
              <Button type="submit">
                <UserRound class="w-6 h-6 mr-2" />Войти
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
</script>

<style></style>
