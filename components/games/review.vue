<template>
  <div class="flex flex-col gap-2 border-[1px] rounded-xl p-8">
    <div
      class="flex sm:flex-row flex-col items-start sm:items-center justify-between sm:gap-0 gap-2"
    >
      <div
        @click="
          async () =>
            await navigateTo(`/users/${user.id}`, { replace: true })
        "
        class="flex gap-2 items-center border-[1px] bg-black hover:bg-accent py-2 px-4 rounded-xl transition-all duration-200 ease-in-out cursor-pointer"
      >
        <Avatar class="w-[50px] h-[50px]">
          <AvatarImage :src="user.avatar" alt="@radix-vue" />
          <AvatarFallback>{{ user.username }}</AvatarFallback>
        </Avatar>
        <div class="flex flex-col items-start">
          <p class="font-medium text-[16px]">{{ user.username }}</p>
          <p class="font-medium text-[12px] text-muted-foreground">
            Уровень {{ user.level }}
          </p>
        </div>
      </div>
      <div
        :class="`flex justify-center items-center font-semibold py-2 ${color} rounded-full px-4 text-white mr-4`"
      >
        {{ review.mark }}
      </div>
    </div>
    <div>
      <h1 class="font-semibold text-[24px] sm:text-[36px]">
        {{ review.title }}
      </h1>
    </div>
    <Separator />
    <div>
      <p class="font-medium text-[18px]">
        {{ review.text }}
      </p>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Separator } from "@/components/ui/separator";

const props = defineProps({
  review: {
    type: Object,
    required: true,
  },
});
const { review } = props;

const color = ref("");

const user = await $fetch("http://92.53.105.185:5000/api/user/get", {
  method: "POST",
  body: {
    id: review.userId,
  },
});

const setColor = (mark: number) => {
  if (mark > 84) {
    color.value = "bg-green-900";
  } else if (mark > 69 && mark < 85) {
    color.value = "bg-green-700";
  } else if (mark > 50 && mark < 70) {
    color.value = "bg-yellow-600";
  } else if (mark > 30 && mark < 51) {
    color.value = "bg-orange-500";
  } else {
    color.value = "bg-red-700";
  }
};
onMounted(() => {
  setColor(review.mark);
});
</script>

<style></style>
