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
    <Footer />
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

const defaultValue = "item-1";

const accordionItems = [
  {
    value: "item-1",
    title: "Что такое платформа подбора игр?",
    content:
      "Платформа подбора игр — это онлайн-сервис, который помогает пользователям находить игры, соответствующие их предпочтениям и интересам.",
  },
  {
    value: "item-2",
    title: "Какие данные используются для подбора игр?",
    content:
      "Платформы могут использовать информацию о ваших предпочтениях (жанры, типы игр, предпочитаемые платформы), историю игровой активности, отзывы других пользователей и другие данные для формирования рекомендаций.",
  },
  {
    value: "item-3",
    title: "Могу ли я доверять рекомендациям платформы подбора игр?",
    content:
      "Решение о том, доверять ли рекомендациям платформы, остается за вами. Платформы стараются предложить наиболее подходящие игры на основе доступной информации, но итоговое решение всегда зависит от вас.",
  },
];
</script>

<style></style>
