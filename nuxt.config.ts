// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: ["@nuxtjs/tailwindcss", "shadcn-nuxt", ["@nuxtjs/google-fonts",{
    families: {
      Inter: '200..700',
      Poppins: '200..700'  
    }
  }]],
  shadcn: {
    prefix: 'UI',
    componentDir: './components/ui'
  }
})