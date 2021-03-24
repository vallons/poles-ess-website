const colors = require("tailwindcss/colors");

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
        white: {
          DEFAULT: "#fff",
          dark: "#f8f7ed",
        },
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
          100: "#f4f3e9",
          300: "#bdbcb2",
          800: "#66645f",
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
