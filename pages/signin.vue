<template>
  <div class="max-w-[1400px] px-4 mx-auto sm:w-[70%] w-[90%] md:w-[50%]">
    <Card>
      <CardHeader class="gap-10">
        <div class="flex gap-[10px] items-center">
          <img src="/logo.png" width="50" alt="logo" />
          <h1 class="font-semibold text-[24px] font-eng">
            <span class="font-eng text-primary font-semibold">Play</span>Hub
          </h1>
        </div>
        <div>
          <CardTitle>Вход</CardTitle>
          <CardDescription>Введите почту и пароль</CardDescription>
        </div>
      </CardHeader>
      <CardContent>
        <form @submit="onSubmit" class="flex flex-col gap-4">
          <div class="flex flex-col gap-2">
            <Label for="email">Email</Label>
            <Input
              id="email"
              type="email"
              required
              placeholder="example@example.com"
              v-model="userInfo.email"
            ></Input>
          </div>
          <div class="flex flex-col gap-2">
            <Label for="password">Пароль</Label>
            <Input
              id="password"
              type="password"
              required
              placeholder="Пароль"
              v-model="userInfo.password"
            ></Input>
          </div>
          <button type="submit" class="bg-primary py-2 rounded-md">
            Войти
          </button>
        </form>
      </CardContent>
    </Card>
  </div>
</template>

<script lang="ts" setup>
definePageMeta({
  layout: "custom",
});
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { toast } from "@/components/ui/toast";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

const userInfo = reactive({
  email: "",
  password: "",
});

function onSubmit(event: Event) {
  event.preventDefault();
  console.log("Form submitted!");
  toast({
    title: "Form submitted!",
    description: userInfo,
  });
  userInfo.email = "";
  userInfo.password = "";
  navigateTo('/');
}
</script>

<style></style>
