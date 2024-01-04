import '@mdi/font/css/materialdesignicons.css' // Ensure you are using css-loader
import { createVuetify } from 'vuetify'
import { aliases, mdi } from 'vuetify/src/iconsets/mdi'

export default createVuetify({
    defaults: {
        VBtn: {
            color: 'primary',
            variant: 'outlined',
            rounded: true,
            fontsize: '10px',
        },
    },
    icons: {
        defaultSet: 'mdi',
        aliases,
        sets: {
            mdi,
        },
    },
})