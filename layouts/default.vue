<template>
  <div>
    <Loader v-if="isLoadingStore.isLoading" />
    <div v-else>
      <Navbar />
      <slot> </slot>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { useAuthStore, useIsLoadingStore } from "~/stores/auth.store";
import { toast } from "@/components/ui/toast";
const isLoadingStore = useIsLoadingStore();
const authStore = useAuthStore();
onMounted(async () => {
  try {
    const response = await $fetch("http://92.53.105.185:5000/api/user/verify", {
      method: "POST",
      body: {
        token: localStorage.getItem('token'),
      },
    });
    localStorage.setItem('token', response.token)
    authStore.set({
      id: response.user.id,
      email: response.user.email,
      username: response.user.username,
      level: response.user.level,
      role: response.user.role,
      avatar: response.user.avatar,
      status: true,
    });
    toast({
      title: `Привет, ${authStore.user.username}👋`,
    });
  } catch (e) {
    authStore.clear();
  } finally {
    isLoadingStore.set(false);
  }
});
</script>

<style></style>
