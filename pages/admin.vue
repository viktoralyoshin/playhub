<template>
  <div class="max-w-[1400px] mx-auto pt-[200px]">
    <div class="">
      <form @submit="login" class="flex flex-col gap-4" autocomplete="off">
        <div class="flex flex-col gap-2">
          <Label for="name">name</Label>
          <Input
            id="name"
            type="text"
            required
            v-model="gameInfo.name"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="dev">dev</Label>
          <Input
            id="dev"
            type="text"
            required
            v-model="gameInfo.developer"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="release">release</Label>
          <Input
            id="release"
            type="text"
            required
            v-model="gameInfo.releaseDate"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="price">price</Label>
          <Input
            id="price"
            type="number"
            required
            v-model="gameInfo.price"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="desc">desc</Label>
          <Input
            id="desc"
            type="text"
            required
            v-model="gameInfo.description"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="genre">genre</Label>
          <Input
            id="genre"
            type="text"
            required
            v-model="gameInfo.genre"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="cover">cover</Label>
          <input
            ref="file"
            name="cover"
            id="cover"
            type="file"
            @change="onFileChange"
          />
        </div>
        <div class="flex flex-col gap-2">
          <Label for="pic">Pic</Label>
          <input
            ref="files"
            name="pic"
            id="pic"
            type="file"
            multiple
            @change="onPicChange"
          />
        </div>
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
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-vue-next";
const cover = ref();
const files = ref();

function onFileChange(e: any) {
  cover.value = e.target.files[0];
}

function onPicChange(e: any) {
  const file = e.target.files[0];
}

const gameInfo = reactive({
  name: "",
  developer: "",
  releaseDate: "",
  price: 0,
  description: "",
  genre: "",
});

const isLoading = ref(false);
const login = async (event: Event) => {
  event.preventDefault();
  const formData = new FormData();
  formData.append("cover", cover.value);
  formData.append("name", gameInfo.name);
  formData.append("developer", gameInfo.developer);
  formData.append("price", gameInfo.price);
  formData.append("releaseDate", gameInfo.releaseDate);
  formData.append("description", gameInfo.description);
  formData.append("genre", gameInfo.genre);
  Array.from(files.value.files).map((file, index) => formData.append(index, file));
  isLoading.value = true;
  const response = await $fetch("http://92.53.105.185:5000/api/game/create", {
    method: "POST",
    body: formData,
  });
  if (response) {
    isLoading.value = false;
  }
};
</script>

<style></style>
