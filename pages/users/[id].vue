<template>
  <div class="max-w-[1400px] mx-auto pt-[100px]">
    <Head>
      <Title>PlayHub | {{ user.username }}</Title>
    </Head>
    <div>
      <div class="p-8 flex flex-col gap-6">
        <div
          class="sm:px-12 px-6 flex sm:flex-row flex-col justify-between items-center gap-4"
        >
          <div class="flex gap-4 items-center">
            <Avatar class="w-[100px] h-[100px]">
              <AvatarImage :src="user.avatar" alt="@radix-vue" />
              <AvatarFallback>{{ user.username }}</AvatarFallback>
            </Avatar>
            <div class="flex flex-col items-start">
              <h1 class="font-semibold text-[24px]">{{ user.username }}</h1>
              <h1 class="font-semibold text-[18px] text-muted-foreground">
                Уровень {{ user.level }}
              </h1>
            </div>
          </div>
          <div class="flex flex-col items-start" v-if="authStore.user.id==user.id">
            <Progress v-model="progress" />
            <h1
              class="font-medium sm:text-[18px] text-[14px] text-muted-foreground"
            >
              Отзывов до следующего уровня: {{ (100 - progress) / 20 }}
            </h1>
          </div>
        </div>
        <div class="flex flex-col items-center">
          <p class="font-medium text-[18px] text-muted-foreground">
            Любимые игры
          </p>
          <div class="flex flex-auto gap-2">
            <div
              v-for="favGame in favGames"
              class="bg-primary rounded-xl p-1 px-2"
            >
              <p class="font-semibold text-[18px]">
                {{ favGame.name }}
              </p>
            </div>
          </div>
        </div>
        <Separator />
        <div class="sm:px-12 px-6 flex flex-col gap-4">
          <h1 class="font-semibold text-[28px] sm:text-[48px]">Статьи</h1>
          <div class="flex flex-col gap-4">
            <div
              v-if="!isEmpty(articles)"
              v-for="article in articles"
              :key="article.id"
            >
              <GamesArticle :article="article" />
            </div>
            <p v-else class="font-medium sm:text-[24px] text-[18px]">
              Этот пользователь ещё не добавлял статьи😢
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Separator } from "@/components/ui/separator";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";

const authStore = useAuthStore();

const route = useRoute();
const userId = route.params.id;
function isEmpty(obj: Object) {
  for (let key in obj) {
    return false;
  }
  return true;
}

const user = await $fetch("http://92.53.105.185:5000/api/user/get", {
  method: "POST",
  body: {
    id: userId,
  },
});

const progress = ref("");

if (user.reviewCount >= 5) {
  progress.value = `${(user.reviewCount % 5) * 20}`;
} else {
  progress.value = `${user.reviewCount * 20}`;
}

const articles = await $fetch("http://92.53.105.185:5000/api/article/get", {
  method: "POST",
  body: {
    userId: user.id,
  },
});

const favGames = await $fetch("http://92.53.105.185:5000/api/user/getfav", {
  method: "POST",
  body: {
    userId: user.id,
  },
});

console.table(articles);
</script>

<style></style>
