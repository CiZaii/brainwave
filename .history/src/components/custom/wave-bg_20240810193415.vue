<script lang="ts" setup>
import { computed } from 'vue';
import { getPaletteColorByNumber } from '@sa/color';

defineOptions({ name: 'WaveBg' });

interface Props {
  /** Theme color */
  themeColor: string;
}

const props = defineProps<Props>();

const lightColor = computed(() => getPaletteColorByNumber(props.themeColor, 200));
const darkColor = computed(() => getPaletteColorByNumber(props.themeColor, 500));
</script>

<template>
  <div class="absolute-lt z-1 size-full overflow-hidden">
          <img class="bgs" src="/bgs.svg" alt="">
  </div>
</template>

<style scoped>
.bgs{
   width: 100%;
   height:100;
}
</style>
