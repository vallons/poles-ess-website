const path = require("path");
const { environment } = require('@rails/webpacker')

const webpack = require("webpack");

const resolve = {
  alias: {
    '@utils': path.resolve(__dirname, '..', '..', 'app/front/scripts/shared/utils')
  }
};

environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery",
    "window.jQuery": "jquery",
    Popper: ["popper.js", "default"],
  })
);

environment.config.merge({ resolve });

module.exports = environment
