<template>
  <div>
    <Head>
      <Title>PlayHub | Статьи</Title>
    </Head>
    <div class="max-w-[1400px] px-4 pt-[100px] mx-auto">
      <div class="flex flex-col gap-2">
        <div>
          <h1
            class="font-semibold text-foreground font-semibold sm:text-[56px] text-[36px]"
          >
            Статьи
          </h1>
          <GamesCreateArticle
            v-if="authStore.user.status && authStore.user.level >= 3"
          />
          <div v-else>
            <p class="font-semibold sm:text-[20px] text-[16px] text-muted-foreground">Вы сможете добавлять свои статьи, когда получите 3 уровень</p>
          </div>
        </div>
        <Separator />
        <div v-for="article in articles" :key="article.id">
          <GamesArticle :article="article"></GamesArticle>
        </div>
      </div>
    </div>
    <Footer />
  </div>
</template>

<script lang="ts" setup>
import { Separator } from "@/components/ui/separator"
const authStore = useAuthStore();
const articles = await $fetch("http://92.53.105.185:5000/api/article/getall");
</script>

<style></style>
