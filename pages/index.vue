<template>
  <div>
    <MPageHeader />
    <div class="max-w-[1400px] px-4 mx-auto flex flex-col gap-10">
      <div>
        <h1
          class="font-semibold text-foreground font-semibold sm:text-[56px] text-[36px]"
        >
          Новинки
        </h1>
        <div class="w-full flex justify-center px-12">
          <Carousel
            class="relative w-full"
            :opts="{
              loop: true,
            }"
            :plugins="[
              Autoplay({
                delay: 10000,
              }),
            ]"
          >
            <CarouselContent>
              <CarouselItem v-for="(_, index) in 5" :key="index">
                <div class="p-1">
                  <MPageNewItem />
                </div>
              </CarouselItem>
            </CarouselContent>
            <CarouselPrevious />
            <CarouselNext />
          </Carousel>
        </div>
      </div>
      <div>
        <div>
          <h1
            class="font-semibold text-foreground font-semibold sm:text-[56px] text-[36px]"
          >
            Подборки
          </h1>
          <p
            class="font-semibold sm:text-[20px] text-[16px] text-muted-foreground"
          >
            Лучшие игры в своём жанре
          </p>
          <Separator class="my-4" />
          <div class="">
            <div class="w-full flex justify-center px-12">
              <Carousel class="relative w-full">
                <CarouselContent>
                  <CarouselItem
                    v-for="(_, index) in 5"
                    :key="index"
                    class="sm:basis-[100%] xl:basis-[33%]"
                  >
                    <div class="p-1">
                      <MPageCollection />
                    </div>
                  </CarouselItem>
                </CarouselContent>
                <CarouselPrevious />
                <CarouselNext />
              </Carousel>
            </div>
          </div>
        </div>
      </div>
      <div>
        <h1
          class="font-semibold text-foreground font-semibold sm:text-[56px] text-[36px]"
        >
          Пользователи
        </h1>
        <p
          class="font-semibold sm:text-[20px] text-[16px] text-muted-foreground"
        >
          Самые активные пользователи
        </p>
        <Separator class="my-4" />
        <div class="">
          <div class="w-full flex justify-center px-12">
            <Carousel class="relative w-full">
              <CarouselContent>
                <CarouselItem
                  v-for="(_, index) in 10"
                  :key="index"
                  class="md:basis-[50%] lg:basis-[25%]"
                >
                  <div class="p-1">
                    <MPageUserItem />
                  </div>
                </CarouselItem>
              </CarouselContent>
              <CarouselPrevious />
              <CarouselNext />
            </Carousel>
          </div>
        </div>
      </div>
      <div>
        <h1
          class="font-semibold text-foreground font-semibold sm:text-[56px] text-[36px]"
        >
          Лучшие игры
        </h1>
        <p
          class="font-semibold sm:text-[20px] text-[16px] text-muted-foreground"
        >
          Игры с самыми высокими оценками
        </p>
        <Separator class="my-4" />
        <div class="flex flex-col gap-2">
          <MPageCollectionItem
            v-for="(_, index) in 10"
            :key="index"
          ></MPageCollectionItem>
          <Button variant="ghost">Смотреть все</Button>
        </div>
      </div>
      <MPageContactUs />
      <div>
        <h1
          class="font-semibold text-foreground font-semibold sm:text-[56px] text-[36px]"
        >
          FAQ
        </h1>
        <Accordion
          type="single"
          class="w-full"
          collapsible
          :default-value="defaultValue"
        >
          <AccordionItem
            v-for="item in accordionItems"
            :key="item.value"
            :value="item.value"
          >
            <AccordionTrigger>{{ item.title }}</AccordionTrigger>
            <AccordionContent>
              {{ item.content }}
            </AccordionContent>
          </AccordionItem>
        </Accordion>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel";

import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";

import { Button } from "@/components/ui/button";

import { Separator } from "@/components/ui/separator";

import Autoplay from "embla-carousel-autoplay";
import UserItemVue from "~/components/m-page/user-item.vue";

const defaultValue = "item-1";

const accordionItems = [
  {
    value: "item-1",
    title: "Is it accessible?",
    content: "Yes. It adheres to the WAI-ARIA design pattern.",
  },
  {
    value: "item-2",
    title: "Is it unstyled?",
    content:
      "Yes. It's unstyled by default, giving you freedom over the look and feel.",
  },
  {
    value: "item-3",
    title: "Can it be animated?",
    content: "Yes! You can use the transition prop to configure the animation.",
  },
];
</script>

<style></style>
