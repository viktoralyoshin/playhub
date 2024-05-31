<template>
  <div class="w-full border-border border-[1px] rounded-2xl">
    <div class="flex sm:flex-row flex-col">
      <div class="sm:w-1/2 flex flex-col justify-center sm:py-14 py-7 sm:pl-14 pl-7 bg-black rounded-2xl">
        <h1 class="font-semibold text-[36px]">Связаться с нами</h1>
        <h1 class="font-semibold text-[18px] text-muted-foreground">
          Напишем вам в ближайшее время
        </h1>
      </div>
      <div class="relative sm:w-1/2 flex items-center justify-center form rounded-2xl">
        <Input id="search" type="text" placeholder="example@example.com" class="p-6 text-[18px] w-[90%] sm:my-0 my-14" />
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Input } from "@/components/ui/input";
</script>

<style>
.form {
  background: url("/public/bg-form.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  background-position: right;
}
</style>
