<template>
  <div>
    <Card>
      <CardHeader />
      <CardContent class="flex flex-col gap-4 items-center justify-center">
        <Avatar class="w-[100px] h-[100px]">
          <AvatarImage
            src="https://github.com/radix-vue.png"
            alt="@radix-vue"
          />
          <AvatarFallback>CN</AvatarFallback>
        </Avatar>
        <div class="flex flex-col items-center">
          <h1 class="font-semibold text-[36px]">radix</h1>
          <h2 class="font-semibold text-[18px] text-muted-foreground">
            10 отзывов
          </h2>
        </div>
      </CardContent>
    </Card>
  </div>
</template>

<script lang="ts" setup>
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
</script>

<style></style>
