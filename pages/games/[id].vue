<template>
  <div>
    <Head>
      <Title>PlayHub | {{ game.name }}</Title>
    </Head>
    <div class="max-w-[1400px] mx-auto pt-[100px]">
      <div>
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
              <div class="flex gap-2 items-center">
                <h1 class="font-semibold text-[28px] sm:text-[56px]">
                  {{ game.name }}
                </h1>
                <div
                  :class="`flex justify-center items-center font-semibold py-2 rounded-full px-4 text-white mr-4 ${color}`"
                >
                  {{ game.mark }}
                </div>
              </div>
              <div>
                <p class="text-muted-foreground font-medium text-[18px]">
                  Жанр
                </p>
                <p class="font-medium text-[24px]">{{ genre.name }}</p>
              </div>
              <div>
                <p class="text-muted-foreground font-medium text-[18px]">
                  Издатель
                </p>
                <p class="font-medium text-[24px]">{{ game.developer }}</p>
              </div>
              <div>
                <p class="text-muted-foreground font-medium text-[18px]">
                  Дата выхода
                </p>
                <p class="font-medium text-[24px]">{{ game.releaseDate }}</p>
              </div>
              <Separator />
              <div>
                <p class="text-muted-foreground font-medium text-[18px]">
                  Описание
                </p>
                <p class="font-medium text-[18px] sm:text-[24px]">
                  {{ game.description }}
                </p>
              </div>
              <Separator />
              <div>
                <p class="text-muted-foreground font-medium text-[18px]">
                  Стоимость
                </p>
                <div class="flex items-center gap-2">
                  <p class="font-semibold text-[24px]">
                    {{ game.price == 0 ? "Бесплатно" : game.price + " ₽" }}
                  </p>
                </div>
              </div>
            </div>
          </div>
          <Separator />
          <div class="sm:px-12 px-6 flex flex-col gap-4">
            <div class="flex flex-col gap-2">
              <h1 class="font-semibold text-[24px] sm:text-[48px]">Отзывы</h1>
              <div v-if="authStore.isAuth">
                <Drawer>
                  <DrawerTrigger
                    ><Button variant="outline" v-if="!haveReview"
                      ><Pen class="w-4 h-4 mr-2" />Добавить свой</Button
                    ></DrawerTrigger
                  >
                  <DrawerContent>
                    <form
                      @submit="createReview"
                      class="flex flex-col items-center"
                    >
                      <DrawerHeader class="flex flex-col items-center">
                        <DrawerTitle>Добавление отзыва</DrawerTitle>
                        <DrawerDescription
                          >Заполните все поля</DrawerDescription
                        >
                      </DrawerHeader>
                      <div class="flex flex-col w-3/4 gap-8 my-6">
                        <div class="flex flex-col gap-2">
                          <Label for="title">Заголовок</Label>
                          <Input
                            id="title"
                            type="text"
                            class="px-4 py-2 text-[18px]"
                            placeholder="Заголовок."
                            v-model="reviewInfo.title"
                            required
                          />
                        </div>
                        <div class="flex flex-col gap-2">
                          <Label for="text">Текст отзыва</Label>
                          <Textarea
                            id="text"
                            class="px-4 py-2 text-[18px] resize-none h-[200px]"
                            placeholder="Текст отзыва."
                            maxlength="1000"
                            v-model="reviewInfo.text"
                            required
                          />
                        </div>
                        <div class="flex flex-col gap-6">
                          <div class="flex flex-col gap-2">
                            <Label for="mark">Оценка</Label>
                            <Input
                              id="mark"
                              type="number"
                              class="px-4 py-2 text-[18px]"
                              placeholder="Оценка"
                              max="100"
                              min="0"
                              v-model="reviewInfo.mark"
                              required
                            />
                          </div>
                          <p>
                            Ваша оценка:
                            <span>
                              {{
                                reviewInfo.mark > 100 || reviewInfo.mark < 0
                                  ? "Оценка не может быть больше 100 и меньше 0"
                                  : reviewInfo.mark
                              }}</span
                            >
                          </p>
                        </div>
                      </div>
                      <Separator class="mt-4 mb-2" />
                      <DrawerFooter>
                        <button
                          type="submit"
                          class="bg-primary py-2 rounded-md px-4 font-medium"
                        >
                          Добавить отзыв
                        </button>
                        <DrawerClose> </DrawerClose>
                      </DrawerFooter>
                    </form>
                  </DrawerContent>
                </Drawer>
              </div>
            </div>
            <div class="flex flex-col gap-4">
              <div
                v-if="!isEmpty(reviews)"
                v-for="review in reviews"
                :key="review.id"
              >
                <GamesReview :review="review" />
              </div>
              <p v-else class="font-medium text-[18px] sm:text-[24px]">
                Отзывов пока что нет😢
              </p>
            </div>
          </div>
        </div>
      </div>
      <Footer />
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
import { Separator } from "@/components/ui/separator";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Pen } from "lucide-vue-next";
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
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";

const color = ref("");
const haveReview = ref(false);

const authStore = useAuthStore();
const isLoadingStore = useIsLoadingStore();
const route = useRoute();
const router = useRouter();
const gameId = route.params.id;
const reviewInfo = reactive({
  userId: authStore.user.id,
  gameId: gameId,
  title: "",
  text: "",
  mark: 60,
});

const { game, reviews, images, genre } = await $fetch(
  "http://92.53.105.185:5000/api/game/get",
  {
    method: "POST",
    body: {
      id: gameId,
    },
  }
);
const check = await $fetch("http://92.53.105.185:5000/api/review/check", {
  method: "POST",
  body: { id: authStore.user.id, gameId: game.id },
});
if (check.message == "true") {
  haveReview.value = true;
} else {
  haveReview.value = false;
}

const createReview = async (e: Event) => {
  e.preventDefault();
  isLoadingStore.set(true);
  const response = await $fetch("http://92.53.105.185:5000/api/review/create", {
    method: "POST",
    body: JSON.stringify(reviewInfo),
  });
  if (response.status == 200) {
    reviewInfo.gameId = "";
    reviewInfo.userId = "";
    reviewInfo.title = "";
    reviewInfo.text = "";
    reviewInfo.mark = 60;
  }
  router.go();
};

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
  setColor(game.mark);
});

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

function isEmpty(obj: Object) {
  for (let key in obj) {
    return false;
  }
  return true;
}

watchOnce(emblaMainApi, (emblaMainApi) => {
  if (!emblaMainApi) return;

  onSelect();
  emblaMainApi.on("select", onSelect);
  emblaMainApi.on("reInit", onSelect);
});
</script>

<style></style>
