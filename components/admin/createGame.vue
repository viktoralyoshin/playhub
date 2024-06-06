<template>
  <Dialog>
    <DialogTrigger as-child>
      <Button variant="outline"> Создать игру </Button>
    </DialogTrigger>
    <DialogContent class="sm:max-w-[425px]">
      <DialogHeader>
        <DialogTitle>Создание Игры</DialogTitle>
        <DialogDescription> Добавление игры на платформу </DialogDescription>
      </DialogHeader>
      <form @submit="createGame" class="flex flex-col gap-4" autocomplete="off">
        <div class="flex flex-col gap-2">
          <Label for="name">Название</Label>
          <Input
            id="name"
            type="text"
            required
            v-model="gameInfo.name"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="dev">Издатель</Label>
          <Input
            id="dev"
            type="text"
            required
            v-model="gameInfo.developer"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="release">Дата релиза</Label>
          <Input
            id="release"
            type="text"
            required
            v-model="gameInfo.releaseDate"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="price">Цена</Label>
          <Input
            id="price"
            type="number"
            required
            v-model="gameInfo.price"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="desc">Описание</Label>
          <Input
            id="desc"
            type="text"
            required
            v-model="gameInfo.description"
            autocomplete="false"
          ></Input>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="genre">Жанр</Label>
          <Popover v-model:open="open">
            <PopoverTrigger as-child>
              <Button
                variant="outline"
                role="combobox"
                :aria-expanded="open"
                class="w-[200px] justify-between"
              >
                {{
                  value
                    ? genres.find((genre) => genre.name === value)?.name
                    : "Выберите жанр..."
                }}
                <ChevronsUpDown class="ml-2 h-4 w-4 shrink-0 opacity-50" />
              </Button>
            </PopoverTrigger>
            <PopoverContent class="w-[200px] p-0">
              <Command>
                <CommandInput class="h-9" placeholder="Поиск жанра..." />
                <CommandEmpty>Жанры не найдены</CommandEmpty>
                <CommandList>
                  <CommandGroup>
                    <CommandItem
                      v-for="genre in genres"
                      :key="genre.id"
                      :value="genre.name"
                      @select="
                        (ev) => {
                          if (typeof ev.detail.value === 'string') {
                            value = ev.detail.value;
                          }
                          open = false;
                        }
                      "
                    >
                      {{ genre.name }}
                      <Check
                        :class="
                          cn(
                            'ml-auto h-4 w-4',
                            value === genre.name ? 'opacity-100' : 'opacity-0'
                          )
                        "
                      />
                    </CommandItem>
                  </CommandGroup>
                </CommandList>
              </Command>
            </PopoverContent>
          </Popover>
        </div>
        <div class="flex flex-col gap-2">
          <Label for="cover">Обложка</Label>
          <input
            ref="file"
            name="cover"
            id="cover"
            type="file"
            @change="onFileChange"
          />
        </div>
        <div class="flex flex-col gap-2">
          <Label for="pic">Фото</Label>
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
import { Check, ChevronsUpDown } from "lucide-vue-next";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { cn } from "@/lib/utils";
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
const router = useRouter();
const genres = await $fetch("http://92.53.105.185:5000/api/genre/getAll");

const open = ref(false);
const value = ref("");

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
const createGame = async (event: Event) => {
  event.preventDefault();
  const formData = new FormData();
  formData.append("cover", cover.value);
  formData.append("name", gameInfo.name);
  formData.append("developer", gameInfo.developer);
  formData.append("price", gameInfo.price);
  formData.append("releaseDate", gameInfo.releaseDate);
  formData.append("description", gameInfo.description);
  formData.append("genreName", value.value);
  Array.from(files.value.files).map((file, index) =>
    formData.append(index, file)
  );
  isLoading.value = true;
  console.log(value.value)
  const response = await $fetch("http://92.53.105.185:5000/api/game/create", {
    method: "POST",
    body: formData,
  });
  if (response) {
    isLoading.value = false;
    router.go();
  }
};
</script>

<style></style>
