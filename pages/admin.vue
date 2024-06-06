<template>
  <div
    class="max-w-[1400px] mx-auto pt-[200px] flex flex-col gap-10 sm:px-0 px-2"
  >
    <Head>
      <Title>PlayHub | Админка</Title>
    </Head>
    <div class="flex gap-4">
      <div class="flex flex-col border-[1px] gap-4 rounded-xl p-6">
        <p class="font-medium text-[18px] text-muted-foreground">
          Количество игр
        </p>
        <p class="font-semibold text-[24px]">{{ games.length }}</p>
      </div>
      <div class="flex flex-col border-[1px] gap-4 rounded-xl p-6">
        <p class="font-medium text-[18px] text-muted-foreground">
          Количество пользователей
        </p>
        <p class="font-semibold text-[24px]">{{ users.length }}</p>
      </div>
    </div>
    <div class="flex flex-col gap-4">
      <AdminCreateGame />
      <AdminCreateGenre />
      <AdminCreateCollection />
      <AdminCreateTag />
    </div>
    <div>
      <p class="font-semibold text-[18px]">Cписок тегов</p>
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead class="w-[100px]"> Id </TableHead>
            <TableHead>Name</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          <TableRow v-for="tag in tags" :key="tag.id">
            <TableCell class="font-medium">
              {{ tag.id }}
            </TableCell>
            <TableCell>
              {{ tag.name }}
            </TableCell>
          </TableRow>
        </TableBody>
      </Table>
    </div>
    <div>
      <p class="font-semibold text-[18px]">Cписок жанров</p>
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead class="w-[100px]"> Id </TableHead>
            <TableHead>Name</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          <TableRow v-for="genre in genres" :key="genre.id">
            <TableCell class="font-medium">
              {{ genre.id }}
            </TableCell>
            <TableCell>
              {{ genre.name }}
            </TableCell>
          </TableRow>
        </TableBody>
      </Table>
    </div>
  </div>
</template>

<script lang="ts" setup>
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

const tags = await $fetch("http://92.53.105.185:5000/api/tag/getall");
const genres = await $fetch("http://92.53.105.185:5000/api/genre/getall");
const games = await $fetch("http://92.53.105.185:5000/api/game/getall");
const users = await $fetch("http://92.53.105.185:5000/api/user/getusers");

onBeforeMount(async () => {
  const authStore = useAuthStore();
  if (authStore.user.role != "admin") {
    await navigateTo("/");
  }
});
</script>

<style></style>
