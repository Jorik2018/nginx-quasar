<template>
  <div style="text-align: center;">
    <h3>Trabajo: Creación de Imagen Docker</h3>
    <h4>Autor: {{ title }}</h4>
    <p style="font-size: 50px;">{{ clickCount }}</p>
  </div>
</template>

<script lang="ts">
import {
  defineComponent,
  PropType,
  computed,
  ref,
  toRef,
  Ref,
onMounted,
onUnmounted,
} from 'vue';
import { Todo, Meta } from './models';

function useClickCount() {
  const clickCount = ref(0);
  function increment() {
    clickCount.value += 1
    return clickCount.value;
  }

  return { clickCount, increment };
}

function useDisplayTodo(todos: Ref<Todo[]>) {
  const todoCount = computed(() => todos.value.length);
  return { todoCount };
}

export default defineComponent({
  name: 'ExampleComponent',
  props: {
    title: {
      type: String,
      required: true
    },
    todos: {
      type: Array as PropType<Todo[]>,
      default: () => []
    },
    meta: {
      type: Object as PropType<Meta>,
      required: true
    },
    active: {
      type: Boolean
    }
  },
  setup (props) {
    const { clickCount, increment } = useClickCount();
    let timerId: NodeJS.Timeout | null = null;

    onMounted(() => {
      // Start the timer when the component is mounted
      timerId = setInterval(() => {
        increment();
      }, 1000);
    });

    onUnmounted(() => {
      // Clean up the timer when the component is unmounted
      if (timerId !== null) {
        clearInterval(timerId);
      }
    });

    return {clickCount, increment, ...useDisplayTodo(toRef(props, 'todos')) };
  },
});
</script>
