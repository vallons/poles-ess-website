module.exports = {
  purge: [],
  theme: {
    extend: {
      colors: {
        primary: {
          light: "var(--color-primary-light)",
          DEFAULT: "var(--color-primary)",
          dark: "var(--color-primary-dark)",
        },
        secondary: {
          light: "var(--color-secondary-light)",
          DEFAULT: "var(--color-secondary)",
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
