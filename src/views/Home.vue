<template>
  <div class="home">
    
    <Posts>
      <template #formulario >
        <p class="title-general">  Mira tus posts  </p>
        <router-link class="btn-general" to="/crear-post">Crea un nuevo post</router-link>
      </template>
    </Posts>
  </div>
</template>

<script>
// @ is an alias to /src
import Posts from '@/components/Posts.vue'

export default {
  name: 'Home',
  components: {
    Posts
  }
}
</script>

<style>
  .btn-general{
    background: #0a4375;
    color: #ffffff ;
    padding: 12px 40px;
    border-radius: 20px;
    font-size: 20px;
    margin-bottom: 30px;
    display: flex;
    width: max-content;
    transition: .3s ease-in-out;
    text-decoration: none;
    border: 1px solid #0a4375;
  }
  .btn-general:hover{
    background: #ffffff;
    color: #0a4375 ;
    border: 1px solid #0a4375;
    transition: .3s ease-in-out;
  }
  @media (min-width: 0px) and (max-width: 767px){
    .btn-general{
      margin: 0 auto 30px
    }
  }
</style>