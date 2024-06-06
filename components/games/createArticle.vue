<template>
  <Drawer>
    <DrawerTrigger as-child>
      <Button variant="outline"
        ><Pen class="w-4 h-4 mr-2" /> Добавить статью
      </Button>
    </DrawerTrigger>
    <DrawerContent>
      <div class="sm:max-w-[80%] max-w-[95%] mx-auto">
        <DrawerHeader>
          <DrawerTitle>Добавление статьи</DrawerTitle>
          <DrawerDescription>
            Добавление статьи на платформу
          </DrawerDescription>
        </DrawerHeader>
        <form
          @submit="createArticle"
          class="flex flex-col gap-4"
          autocomplete="off"
        >
          <div class="flex flex-col gap-2">
            <Label for="genre">Тег</Label>
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
                      ? tags.find((tag) => tag.name === value)?.name
                      : "Выберите тег..."
                  }}
                  <ChevronsUpDown class="ml-2 h-4 w-4 shrink-0 opacity-50" />
                </Button>
              </PopoverTrigger>
              <PopoverContent class="w-[200px] p-0">
                <Command>
                  <CommandInput class="h-9" placeholder="Поиск тега..." />
                  <CommandEmpty>Теги не найдены</CommandEmpty>
                  <CommandList>
                    <CommandGroup>
                      <CommandItem
                        v-for="tag in tags"
                        :key="tag.id"
                        :value="tag.name"
                        @select="
                          (ev) => {
                            if (typeof ev.detail.value === 'string') {
                              value = ev.detail.value;
                            }
                            open = false;
                          }
                        "
                      >
                        {{ tag.name }}
                        <Check
                          :class="
                            cn(
                              'ml-auto h-4 w-4',
                              value === tag.name ? 'opacity-100' : 'opacity-0'
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
            <Label for="name">Заголовок</Label>
            <Input
              id="name"
              type="text"
              class="px-4 py-2 text-[18px]"
              placeholder="Заголовок"
              required
              v-model="articleInfo.title"
              autocomplete="false"
            ></Input>
          </div>
          <div class="flex flex-col gap-2">
            <Label for="dev">Содержание</Label>
            <Textarea
              id="text"
              class="px-4 py-2 text-[18px] resize-none h-[200px]"
              placeholder="Текст статьи"
              maxlength="2000"
              v-model="articleInfo.text"
              required
            />
          </div>
          <DrawerFooter>
            <button
              v-if="!isLoading"
              type="submit"
              class="bg-primary py-2 rounded-md"
            >
              Добавить
            </button>
            <Button v-else disabled>
              <Loader2 class="w-4 h-4 mr-2 animate-spin" />
              Добавляем
            </Button>
          </DrawerFooter>
        </form>
      </div>
    </DrawerContent>
  </Drawer>
</template>

<script lang="ts" setup>
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-vue-next";
import { Pen } from "lucide-vue-next";
import { Check, ChevronsUpDown } from "lucide-vue-next";
import { Textarea } from "@/components/ui/textarea";
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerDescription,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer";
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

const authStore = useAuthStore();

const tags = await $fetch("http://92.53.105.185:5000/api/tag/getAll");

const open = ref(false);
const value = ref("");

const articleInfo = reactive({
  title: "",
  text: "",
});

const isLoading = ref(false);
const createArticle = async (event: Event) => {
  event.preventDefault();
  isLoading.value = true;
  const formData = new FormData();
  formData.append("title", articleInfo.title);
  formData.append("text", articleInfo.text);
  formData.append("userId", authStore.user.id);
  formData.append("tagName", value.value);
  const response = await $fetch(
    "http://92.53.105.185:5000/api/article/create",
    {
      method: "POST",
      body: formData,
    }
  );
  if (response) {
    isLoading.value = false;
    router.go();
  }
};
</script>

<style></style>
