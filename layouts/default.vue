<template>
  <div>
    <Loader v-if="isLoadingStore.isLoading" />
    <div v-else>
      <Navbar />
      <slot>
      </slot>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { useAuthStore, useIsLoadingStore } from "~/stores/auth.store";
import { toast } from "@/components/ui/toast";

const authStore = useAuthStore();
const isLoadingStore = useIsLoadingStore();

onMounted(async () => {
  try {
    const response = await $fetch("http://localhost:5000/api/user/verify", {
      method: "GET",
      credentials: "include",
    });
    authStore.set({
      email: response.email,
      username: response.username,
      level: response.level,
      role: response.role,
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
