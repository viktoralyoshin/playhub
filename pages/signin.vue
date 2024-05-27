<template>
  <div class="max-w-[1400px] px-4 mx-auto sm:w-[70%] w-[90%] md:w-[50%]">
    <Card>
      <CardHeader>
        <CardTitle>Вход</CardTitle>
        <CardDescription>Введите почту и пароль</CardDescription>
      </CardHeader>
      <CardContent>
        <form @submit="onSubmit" class="flex flex-col gap-4">
          <div>
            <Input
              type="email"
              required
              placeholder="223"
              v-model="userInfo.email"
            ></Input>
          </div>
          <Button type="submit">Button</Button>
        </form>
      </CardContent>
    </Card>
  </div>
</template>

<script lang="ts" setup>
definePageMeta({
  layout: "custom",
});
import { Button } from '@/components/ui/button'
import { Input } from "@/components/ui/input";
import { toast } from "@/components/ui/toast";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

const userInfo = reactive({
  email: "",
  password: "",
});

function onSubmit(event: Event) {
  event.preventDefault();
  console.log("Form submitted!");
  toast({
    title: "Scheduled: Catch up",
    description: "Friday, February 10, 2023 at 5:57 PM",
  });
}
</script>

<style></style>
