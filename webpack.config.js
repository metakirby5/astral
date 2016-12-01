'use strict';

const path = require('path')
    , webpack = require('webpack')
    , merge = require('webpack-merge')
    , HtmlWebpackPlugin = require('html-webpack-plugin');

const
    // Environment
      ENV = process.env.npm_lifecycle_event

    // Module folders
    , VENDORS = ['node_modules', 'bower_components']
    , VENDOR_RE = new RegExp(VENDORS.join('|'))

    // Input and output folders
    , SRC_PATH = path.join(__dirname, 'src')
    , BUILD_PATH = path.join(__dirname, 'dist')

    // Output names
    , INDEX = 'index'
    , SRC_BUNDLE = 'main'
    , VENDOR_BUNDLE = 'vendor';

// Check if module is vendor, for chunking
const isVendor = (module) => {
  var r = module.userRequest;
  return typeof r === 'string' && r.match(VENDOR_RE);
}

var config = {
  // What file to start at
  entry: [path.join(SRC_PATH, `${SRC_BUNDLE}.coffee`)],

  // Where to output
  output: {
    path: BUILD_PATH,
    filename: '[name].js',
  },

  // Where to load modules from
  resolve: {
    modulesDirectories: VENDORS,
    extensions: ['', '.coffee', '.styl', '.js', '.css']
  },

  // Coffeelint options
  coffeelint: {
    configFile: 'coffeelint.json',
  },

  // Stylus options
  stylus: {
    use: [require('nib')()],
    import: ['~nib/lib/nib/index.styl'],
    preferPathResolver: 'webpack',
  },

  // Stylint options
  stylint: {
    config: '.stylintrc',
  },

  // Module loading options
  module: {
    // Linters, etc
    preLoaders: [
      { // Coffeelint
        test: /\.coffee$/,
        loader: 'coffee-lint',
        exclude: VENDOR_RE,
      },
      { // Stylint
        test: /\.styl/,
        loader: 'stylint',
        exclude: VENDOR_RE,
      },
    ],

    // Files to load
    loaders: [
      { // Pug
        test: /\.pug$/,
        loaders: ['pug-html-loader'],
      },
      { // Coffeescript
        test: /\.coffee$/,
        loaders: ['coffee'],
      },
      { // Stylus
        test: /\.styl$/,
        exclude: /\.u\.styl/,
        loaders: ['style', 'css', 'stylus'],
      },
      { // Reference-counted stylus
        test: /\.u\.styl/,
        loaders: ['style/useable', 'css', 'stylus'],
      },
      { // Plain CSS
        test: /\.css$/,
        loaders: ['style', 'css'],
      },
      { // Media
        test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf)$/,
        loaders: ['url'],
      },
    ],
  },

  plugins: [
    // Generate HTML
    new HtmlWebpackPlugin({
      template: path.join(SRC_PATH, `${INDEX}.pug`),
    }),
    // Separate vendor bundle
    new webpack.optimize.CommonsChunkPlugin({
      name: VENDOR_BUNDLE,
      minChunks: isVendor,
    }),
  ],
};

// Options based on environment
switch (ENV) {
  case 'start': // Development
    console.log('Running development server...');
    config.entry.unshift('react-hot-loader/patch');
    module.exports = merge(config, {
      // Source maps
      devtool: 'cheap-module-eval-source-map',

      // -- Hot loading --

      module: {
        loaders: [
          {
            test: /\.coffee$/,
            loaders: ['react-hot-loader/webpack'],
          },
        ],
      },

      plugins: [new webpack.HotModuleReplacementPlugin()],

      devServer: {
        // Public serving
        host: '0.0.0.0',

        // Adjust entry point
        inline: true,

        // Show progress
        progress: true,

        // Hot reloading
        hot: true,

        // Allow routing
        historyApiFallback: true,

        // Display options
        stats: {
          // Do not show list of hundreds of files included in a bundle
          chunkModules: false,
          colors: true,
        },
      },
    });
    break;

  case 'build': // Production
    console.log('Building production scripts...');
    module.exports = merge(config, {
      plugins: [
        // Production environment variable
        new webpack.DefinePlugin({
          'process.env': {
            'NODE_ENV': JSON.stringify('production'),
          },
        }),

        // Deduplicate
        new webpack.optimize.DedupePlugin(),

        // Minify
        new webpack.optimize.UglifyJsPlugin({
          compress: {warnings: false},
        }),
      ],
    });
    break;
}
