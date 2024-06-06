<template>
  <div class="max-w-[1400px] px-4 mx-auto sm:w-[70%] w-[90%] md:w-[50%]">
    <Head>
      <Title>PlayHub | Вход</Title>
    </Head>
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
        <form @submit="login" class="flex flex-col gap-4" autocomplete="off">
          <div class="flex flex-col gap-2">
            <Label for="email">Email</Label>
            <Input
              id="email"
              type="email"
              required
              placeholder="example@example.com"
              v-model="userInfo.email"
              autocomplete="false"
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
              autocomplete="false"
            ></Input>
          </div>
          <NuxtLink to="/signup" class="hover:text-primary transition-all duration-200 ease-in-out">Ещё нет аккаунта? Создайте аккаунт</NuxtLink>
          <button
            v-if="!isLoading"
            type="submit"
            class="bg-primary py-2 rounded-md"
          >
            Войти
          </button>
          <Button v-else disabled>
            <Loader2 class="w-4 h-4 mr-2 animate-spin" />
            Идёт вход
          </Button>
        </form>
      </CardContent>
    </Card>
  </div>
</template>

<script lang="ts" setup>
definePageMeta({
  layout: "custom",
});
import { toast } from "@/components/ui/toast";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-vue-next";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
const isLoadingStore = useIsLoadingStore();
const isLoading = ref(false);
const userInfo = reactive({
  email: "",
  password: "",
});

const login = async (event: Event) => {
  isLoadingStore.set(true);
  event.preventDefault();
  isLoading.value = true;
  const response = await $fetch("http://92.53.105.185:5000/api/user/login", {
    method: "POST",
    body: JSON.stringify(userInfo),
  });
  if (response.message == "success") {
    localStorage.setItem('token', response.token);
    await navigateTo("/");
    userInfo.email = "";
    userInfo.password = "";
    isLoading.value = false;
  } else {
    isLoadingStore.set(false);
    toast({
      title: "Попробуйте ещё раз",
      description: response.message,
    });
  }
};
</script>

<style></style>
