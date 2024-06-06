<template>
  <div>
    <Loader v-if="isLoadingStore.isLoading" />
    <section v-else>
      <div class="h-screen flex justify-center items-center">
        <slot />
      </div>
    </section>
  </div>
</template>

<script lang="ts" setup>
import { useAuthStore, useIsLoadingStore } from "~/stores/auth.store";
const isLoadingStore = useIsLoadingStore();
onBeforeMount(async () => {
  const authStore = useAuthStore();
  try {
    const response = await $fetch("http://92.53.105.185:5000/api/user/verify", {
      method: "POST",
      body: {
        token: localStorage.getItem("token"),
      },
    });
    localStorage.setItem("token", response.token);
    authStore.set({
      id: response.user.id,
      email: response.user.email,
      username: response.user.username,
      level: response.user.level,
      role: response.user.role,
      avatar: response.user.avatar,
      status: true,
    });
    await navigateTo("/");
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
