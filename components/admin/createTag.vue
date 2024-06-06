<template>
  <Dialog>
    <DialogTrigger as-child>
      <Button variant="outline">Создать тег </Button>
    </DialogTrigger>
    <DialogContent class="sm:max-w-[425px]">
      <DialogHeader>
        <DialogTitle>Создание тега</DialogTitle>
        <DialogDescription> Добавление тега на платформу </DialogDescription>
      </DialogHeader>
      <form @submit="createTag" class="flex flex-col gap-4" autocomplete="off">
        <div class="flex flex-col gap-2">
          <Label for="name">Название</Label>
          <Input
            id="name"
            type="text"
            required
            v-model="tagInfo.name"
            autocomplete="false"
          ></Input>
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

const tagInfo = reactive({
  name: "",
});
const router = useRouter();
const isLoading = ref(false);
const createTag = async (event: Event) => {
  event.preventDefault();
  isLoading.value = true;
  const response = await $fetch("http://92.53.105.185:5000/api/tag/create", {
    method: "POST",
    body: {
      name: tagInfo.name,
    },
  });
  if (response) {
    isLoading.value = false;
    router.go()
    tagInfo.name = ''
  }
};
</script>

<style></style>
