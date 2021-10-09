<template>
    <div class="main-post">
        <div class="main-content__post">
            <slot name="formulario">
                <div class="content-form">
                    <form  @submit.prevent="agregarPost()">
                        <input  :class="{'input-newPost__alert': campoVacio && !nombre}" 
                                v-model="nombre" type="text" placeholder="Nombre">
                        <span class="text-newPost__alert" v-show="campoVacio && !nombre"> Coloca un nombre </span>
                        <select v-model="asunto" >
                            <option value="Sin importancia">Sin Importacia</option>
                            <option value="Importante">Importante</option>
                            <option value="Urgente">Urgente</option>
                        </select>
                        <textarea v-model="mensaje" cols="30" rows="10" placeholder="Mensaje" ></textarea>
                        <input type="submit" value="Agregar">
                    </form>
                    <div class="form-info__extra">
                        <span class="text-newPost"> {{ exito }} </span>
                    </div>
                </div>
            </slot>
            <slot name="contenido">
                
                <div v-if="posts == 0" >
                    <h3> Crea tu primer post</h3>
                </div>
                <div class="content-form__filter" v-else>
                    <span>Filtrar</span>
                    <select v-model="filtroAsunto" type="text">
                        <option value="">Ninguna</option>
                        <option value="Sin importancia">Sin Importacia</option>
                        <option value="Importante">Importante</option>
                        <option value="Urgente">Urgente</option>
                    </select>
                </div>
                <h3 v-if="filtroPost == 0 && posts != 0"> No hay posts en {{ filtroAsunto }} </h3>
                <Post class="content-form" 
                    v-for="(post, n ) in filtroPost" 
                    :key="post.id" 
                    :nombre="post.nombre"
                    :asunto="post.asunto"
                    :mensaje="post.mensaje"
                    :fecha="post.fecha"
                    :formActualizar="formActualizar"
                    :idActualizar="idActualizar"
                    :formComments="formComments"
                    :inputValue="nombreUpdate"
                    :n="n"
                    :comentarios="post.comments"
                    @eliminarPost="eliminarPost(n)"
                    @eliminarComment="eliminarComment(n, commentInd)"
                    @verFormActualizar="verFormActualizar(n)"
                    @comentarPost="comentarPost(n)"
                    @cancelComment="cancelComment(n)"
                    @verFormComments="verFormComments(n)"
                    @guardarActualizacion="guardarActualizacion(n)"
                    @nameData="nameData"
                    @asuntoData="asuntoData"
                    @mensajeData="mensajeData"
                    @commentData="commentData"
                    @indexData="indexData"
                />
            </slot>
        </div>
    </div>
</template>

<script>
    
    import Post from '@/components/Post.vue'

    export default {
        name: 'posts' ,
        data(){
            return{
                posts: [],
                nombre: '',
                asunto: 'Sin importancia',
                mensaje: '',
                filtroAsunto: '',
                exito: '',
                formActualizar: false,
                idActualizar: -1,
                nombreUpdate: '',
                asuntoUpdate: '',
                mensajeUpdate: '',
                formComments: false,
                comments: [],
                newComment: '',
                commentInd: -1,
                campoVacio: false,
            }
        },
        methods: {
            agregarPost(){
                if (!this.nombre){
                    return this.campoVacio = true
                }
                this.posts.unshift({
                    id: + new Date(),
                    nombre: this.nombre,
                    asunto: this.asunto,
                    mensaje: this.mensaje,
                    comments: this.comments,
                    fecha: new Date().toString().split(' ').splice(1,4).join(' '),
                });
                this.savePost();
                this.asunto = 'Sin importancia';
                this.mensaje = '';
                this.exito = ` El post ${this.nombre} fue creado con exito`
                this.nombre = '';
                this.campoVacio = false
            },
            asuntoData(data) {
                this.asuntoUpdate = data;
            },
            verFormActualizar(id) {
                // Antes de mostrar el formulario de actualizar, rellenamos sus campos
                this.idActualizar = id;
                this.nombreUpdate = this.posts[id].nombre;
                this.asuntoUpdate = this.posts[id].asunto;
                this.mensajeUpdate = this.posts[id].mensaje;
                // Mostramos el formulario
                this.formActualizar = true;
            },
            verFormComments(id){
                this.idActualizar = id;
                this.formComments = true;
            },
            guardarActualizacion(id) {
                if (!this.nombreUpdate && !this.mensajeUpdate){
                    return
                }
                // Ocultamos nuestro formulario de actualizar
                this.formActualizar = false;
                // Actualizamos los datos
                this.posts[id].nombre = this.nombreUpdate;
                this.posts[id].asunto = this.asuntoUpdate;
                this.posts[id].mensaje = this.mensajeUpdate;
                this.savePost();
            },
            indexData(data){
                this.commentInd = data;
            },
            eliminarComment(x, y){
                this.posts[x].comments.splice(y, 1);
                this.savePost();
            },
            cancelComment(){
                this.formComments = false;
            },
            eliminarPost(x){
                this.posts.splice(x, 1);
                this.savePost();
            },
            savePost(){
                localStorage.setItem('posts', JSON.stringify(this.posts));
            },
            nameData(data) {
                this.nombreUpdate = data;
            },
            
            mensajeData(data) {
                this.mensajeUpdate = data;
            },
            commentData(data){
                this.newComment = data;
            },
            
            comentarPost(id){
                if(!this.newComment){
                    return;
                }
                this.posts[id].comments.unshift({
                    comment: this.newComment,
                    fecha: new Date().toString().split(' ').splice(1,4).join(' '),
                });
                this.formComments = false;
                this.newComment = '';
                this.savePost();
            },
        },
        created(){
            let data = localStorage.getItem('posts');
            if(data != null){
                this.posts = JSON.parse(data);
            }
        },
        components: {
            Post
        },
        computed:{
            filtroPost(){
                return this.posts.filter( post => {
                    return post.asunto.includes(this.filtroAsunto)
                } )
            }
        },
    }
    
</script>

<style>
    .main-post{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 100%;
    }
    .main-content__post{
        width: 600px;
    }
    .content-form{
        width: 100%;
        margin-bottom: 50px;
    }
    form{
        display: flex;
        flex-direction: column;
    }
    input, select, textarea{
        padding: 10px;
        margin: 10px 0;
    }
    .newContent-form{
        border: 1px solid gray;
        margin: 30px 0;
        padding: 20px;
    }
    .content-form__filter{
        display: flex;
        flex-direction: column;
        width: max-content;
        margin-top: 2rem;
    }
    .content-form__filter select{
        border: 1px solid #0a4375;
        background: #ffffff;
        color: #0a4375;
    }
    .content-form input, .content-form select, .content-form textarea{
        border: 1px solid #0a4375;
        background: #ffffff;
        color: #000000;
    }
    .content-form input::placeholder, .content-form textarea::placeholder{
        color: #000000;
    }
    .content-form input[type='submit']{
        background: #0a4375;
        color: #ffffff;
        padding: 14px;
        font-size: 20px;
        transition: .3s ease-in-out;
        cursor: pointer;
    }
    .content-form input[type='submit']:hover{
        background: #ffffff;
        color: #0a4375;
        transition: .3s ease-in-out;
    }
    .text-newPost{
        color: #0a4375;
        font-size: 16px;
        font-weight: 600;
    }
    .text-newPost__alert{
        color: #d45047;
    }
    .input-newPost__alert{
        border-color: #d45047 !important;
    }
    .form-info__extra{
        display: flex;
        flex-direction: column;
    }
    @media (min-width: 0px) and (max-width: 767px){
        .main-content__post{
            width: 100%;
        }
    }
</style>