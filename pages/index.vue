<template>
  <div>
    <MPageHeader />
    <div class="max-w-[1400px] px-4 mx-auto flex flex-col gap-10">
      <div>
        <h1 class="font-semibold text-foreground font-semibold text-[56px]">
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
          <h1 class="font-semibold text-foreground font-semibold text-[56px]">
            Подборки
          </h1>
          <p class="font-medium text-[28px] text-muted-foreground">
            Лучшие игры в своём жанре
          </p>
        </div>
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
import Autoplay from "embla-carousel-autoplay";
</script>

<style></style>
