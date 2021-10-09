<template>
  <div class="newPost main-post">
    <div class="main-content__post">
      <p class="title-general">Crear un nuevo post</p>
      <Posts>
        <template #contenido >
          <router-link class="btn-general" to="/">Mira todos los posts</router-link>
        </template>
      </Posts>
    </div>
  </div>
</template>


<script>
// @ is an alias to /src
import Posts from '@/components/Posts.vue'

export default {
  name: '',
  components: {
    Posts,
  }
}
</script>