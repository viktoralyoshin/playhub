<template>
  <div class="max-w-[1400px] mx-auto pt-[100px]">
    <div class="border-[1px] rounded-3xl">
      <div class="p-8 flex flex-col gap-6">
        <div class="w-full sm:px-12 px-6">
          <Carousel
            class="relative w-full"
            @init-api="(val) => (emblaMainApi = val)"
          >
            <CarouselContent>
              <CarouselItem v-for="(item, index) in images" :key="index">
                <div class="p-1">
                  <Card>
                    <CardContent class="flex items-center justify-center p-2">
                      <img :src="item.src" alt="" class="rounded-md" />
                    </CardContent>
                  </Card>
                </div>
              </CarouselItem>
            </CarouselContent>
            <CarouselPrevious />
            <CarouselNext />
          </Carousel>

          <Carousel
            class="relative w-full"
            @init-api="(val) => (emblaThumbnailApi = val)"
          >
            <CarouselContent class="flex gap-1 ml-0">
              <CarouselItem
                v-for="(item, index) in images"
                :key="index"
                class="pl-0 md:basis-1/5 basis-1/3 cursor-pointer"
                @click="onThumbClick(index)"
              >
                <div
                  class="p-1"
                  :class="index === selectedIndex ? '' : 'opacity-50'"
                >
                  <Card>
                    <CardContent class="flex items-center justify-center p-2">
                      <img :src="item.src" alt="" class="rounded-md" />
                    </CardContent>
                  </Card>
                </div>
              </CarouselItem>
            </CarouselContent>
          </Carousel>
        </div>
        <div class="sm:px-12 px-6">
          <div class="flex flex-col gap-2">
          <div class="flex flex-col">
            <h1 class="font-semibold text-[56px]">Dota 2</h1>
            <div>
              <p class="text-muted-foreground font-medium text-[18px]">Издатель</p>
              <p class="font-medium text-[24px]">Valve</p>
            </div>
            <div>
              <p class="text-muted-foreground font-medium text-[18px]">Дата выхода</p>
              <p class="font-medium text-[24px]">10.07.2013</p>
            </div>
          </div>
        </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref } from "vue";
import { watchOnce } from "@vueuse/core";
import {
  Carousel,
  type CarouselApi,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel";
import { Card, CardContent } from "@/components/ui/card";

const images = [
  {
    src: "./1.jpg",
  },
  {
    src: "./2.jpg",
  },
  {
    src: "./3.jpg",
  },
  {
    src: "./4.jpg",
  },
  {
    src: "./5.jpg",
  },
  {
    src: "./6.jpg",
  },
  {
    src: "./7.jpg",
  },
];

const emblaMainApi = ref<CarouselApi>();
const emblaThumbnailApi = ref<CarouselApi>();
const selectedIndex = ref(0);

function onSelect() {
  if (!emblaMainApi.value || !emblaThumbnailApi.value) return;
  selectedIndex.value = emblaMainApi.value.selectedScrollSnap();
  emblaThumbnailApi.value.scrollTo(emblaMainApi.value.selectedScrollSnap());
}

function onThumbClick(index: number) {
  if (!emblaMainApi.value || !emblaThumbnailApi.value) return;
  emblaMainApi.value.scrollTo(index);
}

watchOnce(emblaMainApi, (emblaMainApi) => {
  if (!emblaMainApi) return;

  onSelect();
  emblaMainApi.on("select", onSelect);
  emblaMainApi.on("reInit", onSelect);
});
</script>

<style></style>
