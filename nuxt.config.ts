// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },
  modules: ["@nuxtjs/tailwindcss", "shadcn-nuxt", ["@nuxtjs/google-fonts",{
    families: {
      Inter: '200..700',
      Poppins: '200..700'  
    }
  }], '@pinia/nuxt', 'nuxt-file-storage'],
  shadcn: {
    prefix: 'UI',
    componentDir: './components/ui'
  },
  pinia: {
    storesDirs: ['./stores/**'],
  },
  app: {
    pageTransition: { name: 'page', mode: 'out-in' }
  },
  fileStorage: {
    // enter the absolute path to the location of your storage
    mount: 'nuxt-file-storage/server/files',
},
})