<template>
  <div>
    <div class="newContent-form" :class="{'newContent-edit': formActualizar && idActualizar == n}">
      <div class="newContent-form__name">
        <div class="form-name__content">
          <span v-if="formActualizar && idActualizar == n">
            <input  v-model="nombreActualizar" 
                    v-on:input="nameChange"
                    type="text"
                    placeholder="Añade el nuevo nombre">
          </span>
          <span v-else>
            <p> {{nombre}} </p>
          </span>
        </div>
        <div class="form-asunto__content">
          <span v-if="formActualizar && idActualizar == n">
            <select  v-model="asuntoActualizar" v-on:change="asuntoChange">
              <option value="Sin importancia">Sin Importacia</option>
              <option value="Importante">Importante</option>
              <option value="Urgente">Urgente</option>
            </select>
          </span>
          <span v-else>
            <p> {{asunto}} </p>
          </span>
        </div>
      </div>
      
      
      
      <div class="form-mensaje__content">
        <span v-if="formActualizar && idActualizar == n">
          <textarea  v-model="mensajeActualizar" 
                  v-on:input="mensajeChange"
                  type="text"> </textarea>
        </span>
        <span v-else>
          <p> {{mensaje}} </p>
        </span>
      </div>
      <div class="form-btns__content">
        <div >
          <div v-if="!validDelete && !formComments">
            <span v-if="formActualizar && idActualizar == n">
              <a  class="form-btns__update" href="javascript:void(0)" 
                  @click="$emit('guardarActualizacion')" >Guardar</a>
            </span>
            <span v-else>
              <a href="javascript:void(0)" @click="$emit('verFormActualizar'), mostar()" >Actualizar  </a>
              <a href="javascript:void(0)" @click="deletePost" > Eliminar </a>
              <a href="javascript:void(0)" @click="$emit('verFormComments'), limpiar()" >Comentar</a>
            </span>
          </div>
        </div>
        <span class="form-btns__date"> {{fecha}} </span>
      </div>
      <div class="form-btns__valid">
        <div v-if="validDelete">
          <div class="form-valid__delete" >
            <span>Quieres Eliminar?</span>
            <div>
              <a :class="{'delete-valid': validDelete}" href="javascript:void(0)" @click="$emit('eliminarPost')" > SI </a>
              <a href="javascript:void(0)" @click="cancelDelete()" > NO </a>
            </div>
          </div>
        </div>
        <div v-if="formComments && idActualizar == n" class="content-comment" >
            <form @submit.prevent="addComment">
                <textarea   v-model="comment" 
                            v-on:input="commentChange" 
                            placeholder="Añade tu comentario">
                </textarea>
                <div>
                  <button @click="$emit('comentarPost')" > Enviar </button>
                  <button @click="$emit('cancelComment')">Cancelar </button>
                </div>
            </form>
        </div>
      </div>
      <div class="main-comment__content" >
        <span v-show="comentarios != 0">
            <p> Comentarios </p>
        </span>
        <ul>
          <li v-for="(comentario, $index) in comentarios"  :key="comentario.id" >
            <p> {{ comentario.comment }} </p>
            
            <div  class="comment-btn__delete"  v-if="deleteComment && indices == $index" >
                <span>Quieres Eliminar?</span>
                <div >
                    <a :class="{'delete-valid': deleteComment}" href="javascript:void(0)" @click="$emit('eliminarComment'), cancelDelete()">SI</a>
                    <a  href="javascript:void(0)" @click="cancelDelete()">NO</a>
                </div>
                
            </div>
            <div class="comment-btn__date" v-else>
                <a href="javascript:void(0)" @click="indice($index)" v-on:click="index">Eliminar</a>
                <span class="form-btns__date">{{ comentario.fecha }} </span>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>


<script>
    export default {
        name: 'post',
        props:  [ 'comentarios', 'nombre', 'asunto', 'mensaje', 'formActualizar', 'idActualizar', 'n','formComments', 'fecha'],
        data(){
            return{
                nombreActualizar: '',
                asuntoActualizar: '',
                mensajeActualizar: '',
                comment: '',
                comments: [],
                indices: -1,
                deleteComment: false,
                validDelete: false
            }
        },
        methods: {
            
            nameChange(){
                this.$emit('nameData', this.nombreActualizar);
            },
            asuntoChange(){
                this.$emit('asuntoData', this.asuntoActualizar) 
            },
            mensajeChange(){
                this.$emit('mensajeData', this.mensajeActualizar) 
            },
            commentChange(){
                this.$emit('commentData', this.comment);
            },
            index(){
                this.$emit('indexData', this.indices);
            },
            mostar(){
                this.nombreActualizar = this.nombre;
                this.asuntoActualizar = this.asunto;
                this.mensajeActualizar = this.mensaje
            },
            limpiar(){
                this.comment = '';
            },
            indice(n){
                this.indices = n;
                this.deleteComment = true
            },
            cancelDelete(){
                this.deleteComment = false;
                this.validDelete = false
            },
            deletePost(){
                this.validDelete = true
            },
        }
    }
</script>



<style scoped>
    .content-post{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 500px;
    }
    .content-form{
        width: 100%;

    }
    form{
        display: flex;
        flex-direction: column;
    }
    input{
        padding: 10px;
        margin: 10px 0;
    }
    .newContent-form{
        border: 3px solid #0a4375;
        margin: 30px 0;
        padding: 20px;
        position: relative;
    }
    .newContent-edit{
      border-color: #d45047;
    }
    .newContent-form__name{
        display: flex;
        justify-content: space-between;
        margin-bottom: 1rem;
        align-items: center;
    }
    .form-name__content p{
        color: #0a4375;
        font-size: 25px;
        font-weight: 600;
        margin: 0;
    }
    .form-asunto__content{
        position: absolute;
        right: 0;
        top: 0;
    }
    .form-asunto__content p{
        color: #ffffff;
        background: #0a4375;
        padding: 15px;
        font-size: 12px;
        margin: 0;
        border-bottom-left-radius: 12px;
        width: 120px;
        text-align: center;
    }
    .form-btns__content{
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 30px 0 0;
    }
    .form-btns__content div > span{
      display: flex;
    }
    .form-valid__delete{
      display: flex;
      flex-direction: column;
    }
    .form-valid__delete > div{
      display: flex;
    }
    .form-valid__delete > span{
      font-size: 20px;
      color: #0a4375 ;
      font-weight: 600;
      margin-bottom: 10px;
    }
    .form-valid__delete a, .comment-btn__delete a{
      background: #0a4375;
      color: #ffffff ;
      padding: 6px;
      border-radius: 4px;
      font-size: 18px;
      transition: .3s ease-in-out;
      text-decoration: none;
      border: 1px solid #0a4375;
      display: flex;
      width: 30px;
      justify-content: center;
      margin-right: 10px;
    }
    .form-valid__delete .delete-valid, .comment-btn__delete .delete-valid{
      background: #d45047;
    }
    
    .form-valid__delete a:hover, .comment-btn__delete a:hover{
      background: #ffffff;
      color: #0a4375 ;
      border: 1px solid #0a4375;
      transition: .3s ease-in-out;
    }
    .form-valid__delete .delete-valid:hover, .comment-btn__delete .delete-valid:hover{
      color: #d45047;
      border-color: #d45047;
    }
    .form-btns__date{
      font-size: 12px;
      color: #424242;
    }
    .form-btns__content a, .comment-btn__date a{
      background: #ffffff;
      padding: 2px 6px;
      color: #0a4375 ;
      border: 1px solid #0a4375;
      margin-right: 10px;
      font-size: 14px;
      transition: .3s ease-in-out;
      text-decoration: none;
      display: flex;
      border-radius: 2px;
    }
    .form-btns__content a:hover, .comment-btn__date a:hover{
      background: #0a4375;
      color: #ffffff ;
      transition: .3s ease-in-out;
    }
    .form-name__content input{
      width: 300px;
      border: 1px solid #d45047;
    }
    .form-asunto__content select:focus{
      outline: none;
    }
    .form-asunto__content select{
      background: #d45047;
      padding: 15px;
      color: #ffffff;
      width: 150px;
      border-bottom-left-radius: 12px;
      margin: 0;
      border: 1px solid #d45047;
    }
    .form-asunto__content select option{
      height: 14px;
    }
    .form-mensaje__content textarea{
      width: 300px;
      height: 70px;
      padding: 10px;
      border: 1px solid #d45047;
    }
    .form-btns__content .form-btns__update{
      background: #0a4375;
      color: #ffffff ;
      padding: 6px;
      border-radius: 4px;
      font-size: 18px;
      transition: .3s ease-in-out;
      text-decoration: none;
      border: 1px solid #0a4375;
      display: flex;
      justify-content: center;
      margin-right: 10px;
    }
    .content-comment{
      margin-top: 20px;
    }
    .content-comment form textarea{
      height: 70px;
      padding: 10px;
      border: 1px solid #0a4375;
      margin-bottom: 10px;
    }
    .content-comment form button{
      background: #0a4375;
      color: #ffffff ;
      padding: 6px 10px;
      border-radius: 4px;
      font-size: 18px;
      transition: .3s ease-in-out;
      text-decoration: none;
      border: 1px solid #0a4375;
      margin-right: 10px;
    }
    .main-comment__content ul{
      margin: 0;
      list-style: none;
      position: relative;
    }
    .main-comment__content > span > p{
      margin: 30px 0 10px;
      font-size: 20px;
      color: #0a4375;
      font-weight: 600;
    }
    .form-mensaje__content p{
      font-size: 18px;
      color: #0a4375;
    }
    .main-comment__content ul li{
      display: flex;
      flex-direction: column;
      padding: 20px;
      position: relative;
    }
    .main-comment__content ul li::before{
      content: '';
      position: absolute;
      width: 10px;
      height: 10px;
      border-radius: 50%;
      background: #0a4375;
      left: -30px;
      top: 50%;
    }
    .main-comment__content ul li:nth-child(odd){
      background: #0a437540;
    }
    .main-comment__content ul li p{
      margin: 0 0 10px;
      font-size: 16px;
      color: #0a4375;
    }
    .comment-btn__date{
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .comment-btn__delete > div{
      display: flex;
      margin-top: 10px;
    }
    .comment-btn__delete span{
      font-size: 16px;
      color: #0a4375;
      font-weight: 600;
    }
    @media (min-width: 0px) and (max-width: 767px){
        .form-btns__content, .comment-btn__date{
            flex-direction: column-reverse;
            align-items: flex-start;
        }
        .form-btns__date{
          margin-bottom: 10px;
        }
        .form-name__content input, .form-mensaje__content textarea{
          width: -webkit-fill-available;
        }
        .newContent-form{
          padding: 80px 20px 20px;
        }
        
    }
</style>