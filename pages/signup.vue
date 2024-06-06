<template>
  <div class="max-w-[1400px] px-4 mx-auto sm:w-[70%] w-[90%] md:w-[50%]">
    <Head>
      <Title>PlayHub | Регистрация</Title>
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
          <CardTitle>Регистрация</CardTitle>
          <CardDescription>Придумайте почту и пароль</CardDescription>
        </div>
      </CardHeader>
      <CardContent>
        <ScrollArea class="h-[400px] rounded-md border p-4">
          <form @submit="signup" class="flex flex-col gap-4 p-4">
            <div class="flex flex-col gap-2">
              <Label for="email">Email</Label>
              <Input
                id="email"
                type="email"
                required
                placeholder="example@example.com"
                v-model="userInfo.email"
                autocomplete="off"
              ></Input>
            </div>
            <div class="flex flex-col gap-2">
              <Label for="password">Придумайте пароль</Label>
              <Input
                id="password"
                type="password"
                required
                placeholder="Пароль"
                v-model="userInfo.password"
                autocomplete="off"
                readonly
                onfocus="this.removeAttribute('readonly')"
              ></Input>
            </div>
            <div class="flex flex-col gap-2">
              <Label for="username">Имя пользователя</Label>
              <Input
                id="username"
                type="text"
                required
                placeholder="Имя пользователя"
                v-model="userInfo.username"
                autocomplete="off"
              ></Input>
            </div>
            <div class="flex flex-col gap-2">
              <Label for="avatar">Фото профиля</Label>
              <Input
                name="avatar"
                id="avatar"
                type="file"
                accept="image/*"
                @change="onFileChange"
                required
              />
            </div>
            <div class="flex flex-col gap-2">
              <Label>Напишите свои любимые игры</Label>
              <TagsInput v-model="favoriteGames">
                <TagsInputItem
                  v-for="item in favoriteGames"
                  :key="item"
                  :value="item"
                >
                  <TagsInputItemText />
                  <TagsInputItemDelete />
                </TagsInputItem>

                <TagsInputInput placeholder="Любимые игры..." />
              </TagsInput>
            </div>
            <button
              v-if="!isLoading"
              type="submit"
              class="bg-primary py-2 rounded-md"
            >
              Зарегистрироваться
            </button>
            <Button v-else disabled>
              <Loader2 class="w-4 h-4 mr-2 animate-spin" />
              Регистрация
            </Button>
          </form>
        </ScrollArea>
      </CardContent>
    </Card>
  </div>
</template>

<script lang="ts" setup>
definePageMeta({
  layout: "custom",
});
import { ScrollArea } from "@/components/ui/scroll-area";
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
import {
  TagsInput,
  TagsInputInput,
  TagsInputItem,
  TagsInputItemDelete,
  TagsInputItemText,
} from "@/components/ui/tags-input";

const isLoadingStore = useIsLoadingStore();
const isLoading = ref(false);
const avatar = ref();

function onFileChange(e: any) {
  avatar.value = e.target.files[0];
}

const favoriteGames = ref([]);

const userInfo = reactive({
  email: "",
  password: "",
  username: "",
});

const signup = async (event: Event) => {
  isLoadingStore.set(true);
  event.preventDefault();
  const formData = new FormData();
  formData.append("avatar", avatar.value);
  formData.append("email", userInfo.email);
  formData.append("password", userInfo.password);
  formData.append("username", userInfo.username);
  formData.append("favoriteGames", favoriteGames.value);
  formData.append("role", "user");
  isLoading.value = true;
  console.log(favoriteGames.value)
  avatar.value = '';
  userInfo.email = '';
  userInfo.password = '';
  userInfo.username = '';
  favoriteGames.value = [];
  const response = await $fetch(
    "http://92.53.105.185:5000/api/user/registration",
    {
      method: "POST",
      body: formData,
    }
  );
  if (response.message == "success") {
    localStorage.setItem("token", response.token);
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
