// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    experimental: {
        viewTransition: true,
    },
    devtools: { enabled: true },
    css: [
        '@/assets/css/global.css',
        '@/assets/css/fonts.css',
        '@/assets/css/libraries/boxicons.min.css'
    ]
})
