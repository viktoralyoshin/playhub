<template>
  <div>
    <Card>
      <CardHeader>
        <CardTitle>{{ collection.name }}</CardTitle>
        <CardDescription>{{ collection.description }}</CardDescription>
      </CardHeader>
      <CardContent class="flex flex-col gap-4">
        <div v-for="game in games" class="sm:flex flex-col hidden">
          <MPageCollectionItem :game />
        </div>
        <Drawer>
          <DrawerTrigger>
            <Button variant="outline" class="sm:hidden flex"
              >Посмотреть</Button
            ></DrawerTrigger
          >
          <DrawerContent>
            <DrawerHeader>
              <DrawerTitle>{{ collection.name }}</DrawerTitle>
              <DrawerDescription>{{
                collection.description
              }}</DrawerDescription>
            </DrawerHeader>
            <ScrollArea class="flex flex-col gap-4 mx-4">
              <div v-for="game in games">
                <MPageCollectionItem :game />
              </div>
            </ScrollArea>
            <DrawerFooter>
              <DrawerClose>
                <Button variant="outline"> Закрыть </Button>
              </DrawerClose>
            </DrawerFooter>
          </DrawerContent>
        </Drawer>
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
import { Button } from "@/components/ui/button";
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerDescription,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer";

import { ScrollArea } from '@/components/ui/scroll-area'

const props = defineProps({
  collection: {
    type: Object,
    required: true,
  },
});
const { collection } = props;

const games = await $fetch("http://92.53.105.185:5000/api/collection/getGames", {
  method: "POST",
  body: {
    id: collection.id,
  },
});
</script>

<style></style>
