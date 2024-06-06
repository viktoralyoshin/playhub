<template>
  <div>
    <Head>
      <Title>PlayHub | Игры</Title>
    </Head>
    <div class="max-w-[1400px] px-4 pt-[100px] mx-auto">
      <div class="flex flex-col gap-2">
        <h1 class="font-semibold text-foreground sm:text-[56px] text-[36px]">
          Все игры
        </h1>
        <div class="relative w-full items-center">
          <Input
            id="search"
            type="text"
            placeholder="Поиск..."
            class="px-10 py-6 text-[18px]"
            @input="search"
            v-model="query"
          />
          <span
            class="absolute start-0 top-[0.9rem] flex items-center justify-center px-2"
          >
            <Search class="size-6 text-muted-foreground" />
          </span>
          <Transition>
            <div
              v-if="isSearch"
              class="absolute bg-black p-4 w-full mt-2 rounded-xl border-[1px] z-5 flex flex-col gap-5"
            >
              <ScrollArea>
                <TransitionGroup name="list">
                  <div v-if="!isLoading">
                    <p v-if="isEmpty(results)" class="font-medium text-[18px]">
                      Ничего не найдено
                    </p>
                    <div v-for="result in results" :key="result.id">
                      <MPageGameItem :game="result" />
                    </div>
                  </div>
                </TransitionGroup>
              </ScrollArea>
            </div>
          </Transition>
        </div>
        <div v-for="game in games" :key="game.id">
          <MPageGameItem :game="game"></MPageGameItem>
        </div>
      </div>
    </div>
    <Footer />
  </div>
</template>

<script lang="ts" setup>
import { Input } from "@/components/ui/input";
import { Search } from "lucide-vue-next";
import { ScrollArea } from "@/components/ui/scroll-area";
const games = await $fetch("http://92.53.105.185:5000/api/game/getall");

const isLoading = ref(false);
const isSearch = ref(false);

const query = ref("");

const results = ref();

const search = async () => {
  isLoading.value = true;
  if (query.value == "") {
    isSearch.value = false;
  } else {
    isSearch.value = true;
  }
  results.value = await $fetch("http://92.53.105.185:5000/api/game/search", {
    method: "POST",
    body: {
      query: query.value,
    },
  });
  isLoading.value = false;
};

function isEmpty(obj: Object) {
  for (let key in obj) {
    return false;
  }
  return true;
}
</script>

<style>
.v-enter-active,
.v-leave-active {
  transition: opacity 0.5s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}

.list-enter-active,
.list-leave-active {
  transition: 1s ease;
}
.list-enter-from,
.list-leave-to {
  opacity: 0;
}
</style>
