module.exports = {
  purge: [],
  theme: {
    extend: {
      colors: {
        primary: 'var(--color-primary)',
        secondary: 'var(--color-secondary)'
      }
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
      '0': 0,
      auto: "auto",
      48: "12rem",
    },
  },
  variants: {},
  plugins: [],
};
