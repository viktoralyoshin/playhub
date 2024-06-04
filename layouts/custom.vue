<template>
  <Loader v-if="isLoadingStore.isLoading" />
  <section v-else>
    <div class="h-screen md:flex hidden justify-center items-center">
      <slot />
      <div class="bg-image h-full flex md:w-1/2 xl:w-2/3"></div>
    </div>
    <div class="h-screen flex md:hidden justify-center items-center bg-image">
      <slot />
      <div class="bg-image h-full hidden md:flex md:w-1/2 xl:w-2/3"></div>
    </div>
  </section>
</template>

<script lang="ts" setup>
import { useAuthStore, useIsLoadingStore } from "~/stores/auth.store";
const authStore = useAuthStore();
const isLoadingStore = useIsLoadingStore();
onMounted(async () => {
  try {
    const response = await $fetch("http://92.53.105.185:5000/api/user/verify", {
      method: "GET",
      credentials: "include",
    });
    authStore.set({
      id: response.id,
      email: response.email,
      username: response.username,
      level: response.level,
      role: response.role,
      status: true,
    });
    navigateTo("/");
  } catch (e) {
    authStore.clear();
  } finally {
    isLoadingStore.set(false);
  }
});
</script>

<style>
.bg-image {
  background: url("/public/bg-form.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
}
</style>
