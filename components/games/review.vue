<template>
  <div class="flex flex-col gap-2 border-[1px] rounded-xl p-8">
    <div class="flex items-center justify-between">
      <div
        class="flex gap-2 items-center bg-black hover:bg-accent py-2 px-4 rounded-xl transition-all duration-200 ease-in-out cursor-pointer"
      >
        <Avatar class="w-[50px] h-[50px]">
          <AvatarImage
            src="https://github.com/radix-vue.png"
            alt="@radix-vue"
          />
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
        :class="`flex justify-center items-center font-semibold py-2 bg-${color}-700 rounded-full px-4 text-white mr-4`"
      >
        {{ review.mark }}
      </div>
    </div>
    <div>
      <h1 class="font-semibold text-[36px]">{{ review.title }}</h1>
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

const color = ref('')

const user = await $fetch("http://92.53.105.185:5000/api/user/get", {
  method: "POST",
  body: {
    id: review.userId,
  },
});

onMounted(() => {
  if (review.mark >= 70) {
    color.value = "green";
  } else if (review.mark > 50) {
    color.value = "yellow";
  } else if (review.mark > 30) {
    color.value = "orange";
  } else {
    color.value = "red";
  }
});

</script>

<style></style>
