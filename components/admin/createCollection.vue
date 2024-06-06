<template>
  <Dialog>
    <DialogTrigger as-child>
      <Button variant="outline">Cоздать подборку </Button>
    </DialogTrigger>
    <DialogContent class="sm:max-w-[425px]">
      <DialogHeader>
        <DialogTitle>Создание подборки</DialogTitle>
        <DialogDescription>
          Добавление подборки на платформу
        </DialogDescription>
      </DialogHeader>
      <form
        @submit="createCollection"
        class="flex flex-col gap-4"
        autocomplete="off"
      >
        <div class="flex flex-col gap-2">
          <Label for="name">Название</Label>
          <Input
            id="name"
            type="text"
            required
            v-model="collectionInfo.name"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="desc">Описание</Label>
          <Input
            id="desc"
            type="text"
            required
            v-model="collectionInfo.description"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label>Игры в подборке</Label>
          <TagsInput v-model="favoriteGames">
            <TagsInputItem
              v-for="item in favoriteGames"
              :key="item"
              :value="item"
            >
              <TagsInputItemText />
              <TagsInputItemDelete />
            </TagsInputItem>

            <TagsInputInput placeholder="Игры в подобрке..." />
          </TagsInput>
        </div>
        <button
          v-if="!isLoading"
          type="submit"
          class="bg-primary py-2 rounded-md"
        >
          Создать
        </button>
        <Button v-else disabled>
          <Loader2 class="w-4 h-4 mr-2 animate-spin" />
          Создаём
        </Button>
      </form>
    </DialogContent>
  </Dialog>
</template>

<script lang="ts" setup>
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-vue-next";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  TagsInput,
  TagsInputInput,
  TagsInputItem,
  TagsInputItemDelete,
  TagsInputItemText,
} from "@/components/ui/tags-input";

const favoriteGames = ref([]);

const collectionInfo = reactive({
  name: "",
  description: "",
});

const router = useRouter();

const isLoading = ref(false);
const createCollection = async (event: Event) => {
  event.preventDefault();
  isLoading.value = true;
  const response = await $fetch(
    "http://92.53.105.185:5000/api/collection/create",
    {
      method: "POST",
      body: {
        name: collectionInfo.name,
        description: collectionInfo.description,
        games: favoriteGames.value,
      },
    }
  );
  if (response) {
    isLoading.value = false;
    router.go();
    collectionInfo.name = "";
    collectionInfo.description = "";
    favoriteGames.value = [];
  }
};
</script>

<style></style>
