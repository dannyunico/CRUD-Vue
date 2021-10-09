<template>
  
  <router-view/>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
textarea{
  resize: none;
}
textarea:focus, input:focus, select:focus{
  outline: none;
}
.title-general{
  font-size: 50px;
  color: #0a4375;
  font-weight: 600;
  margin-bottom: 30px;
}
@media (min-width: 0px) and (max-width: 767px){
  .title-general{
    font-size: 40px !important;
    text-align: center !important;
  }
}
</style>
