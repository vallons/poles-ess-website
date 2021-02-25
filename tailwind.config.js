const colors = require("tailwindcss/colors")

module.exports = {
  purge: [],
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      gray: colors.warmGray,
      yellow: colors.yellow,
      red: colors.red,
      green: colors.lime,
      black: colors.black,
    },
    extend: {
      colors: {
        white: "#fff",
        primary: {
          light: "var(--color-primary-light)",
          DEFAULT: "var(--color-primary)",
          dark: "var(--color-primary-dark)",
        },
        secondary: {
          light: "var(--color-secondary-light)",
          DEFAULT: "var(--color-secondary)",
        },
        "c-gray": {
          light: "#f4f3e9",
          dark: "#62615f",
        },
      },
    },
    container: {
      padding: {
        default: "1rem",
        sm: "2rem",
        lg: "6rem",
        xl: "10rem",
      },
    },
    inset: {
      0: 0,
      auto: "auto",
      48: "12rem",
    },
  },
  variants: {},
  plugins: [],
};
