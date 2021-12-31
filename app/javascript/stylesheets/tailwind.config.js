const colors = require('tailwindcss/colors')

module.exports = {

  purge: [],

  darkMode: false, // or 'media' or 'class'

  theme: {

    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      gray: colors.coolGray,
      white: colors.white,
      red: colors.red,

      black: { light: '#505754', DEFAULT: '#383D3B' },
      teal: { light: '#1CABC4', DEFAULT: '#178CA0' },
      pink: { light: '#F1E9ED', DEFAULT: '#EEE5E9' },
      yellow: { light: '#FDDA2B', DEFAULT: '#FDDF46' },
      blue: { light: '#D2FEFF', DEFAULT: '#CEFDFF' }
    },

    extend: {},

  },

  variants: {
    extend: {}
  },

  plugins: [],

}
