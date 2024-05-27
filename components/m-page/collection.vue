<template>
  <div>
    <Card>
      <CardHeader>
        <CardTitle>RPG</CardTitle>
        <CardDescription>Ролевые игры</CardDescription>
      </CardHeader>
      <CardContent class="flex flex-col gap-4">
        <div
          v-for="(_, index) in 5"
          :key="index"
          class="sm:flex sm:flex-col hidden"
        >
          <MPageCollectionItem />
        </div>
        <Drawer>
          <DrawerTrigger>
            <Button variant="outline" class="sm:hidden flex"
              >Смотреть</Button
            ></DrawerTrigger
          >
          <DrawerContent>
            <DrawerHeader>
              <DrawerTitle>RPG</DrawerTitle>
              <DrawerDescription>Ролевые игры</DrawerDescription>
            </DrawerHeader>
            <div class="flex flex-col gap-4 mx-4">
              <div v-for="(_, index) in 5" :key="index">
                <MPageCollectionItem />
              </div>
            </div>
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
</script>

<style></style>
