
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const TerserPlugin = require('terser-webpack-plugin');
const webpack = require('webpack');

const MetaTags = { author: "Alexandr Selunin; aka.qwars@gmail.com" };

module.exports = {
    context:  __dirname + '/develop',
    target: 'web',
    devServer: {
        static: '.public/',
        historyApiFallback: {
            rewrites: [
                {
                    from: /.*/,
                    to: function( context ){
                        return context.parsedUrl.pathname.match(/\.\w+$/) ? context.parsedUrl.pathname : '/index.html'
                    }
                }
            ]
        }
    },
    performance: {
        maxEntrypointSize: 1_000_000,
        maxAssetSize: 1_000_000
    },
    plugins: [
        new webpack.DefinePlugin({
            'process.env': {
                APP_API_KEY: JSON.stringify(process.env.APP_API_KEY),
                APP_AUTH_DOMAIN: JSON.stringify(process.env.APP_AUTH_DOMAIN),
                APP_PROJECT_ID: JSON.stringify(process.env.APP_PROJECT_ID),
                APP_STORAGE_BUCKET: JSON.stringify(process.env.APP_STORAGE_BUCKET)
            }
        }),
        new HtmlWebpackPlugin({
            title: 'Konnektu - автоматизация маркетинга :: Платформа создание и продвиженее сайтов',
            favicon: './favicon.ico',
            scriptLoading: 'defer',
            // base: '/',
            meta: Object.assign({ viewport: 'width=device-width, initial-scale=1, shrink-to-fit=no' }, MetaTags )
        }),
        new HtmlWebpackPlugin({
            filename: '404.html',
            template: './404.html',
            inject: false
        }),
        new MiniCssExtractPlugin({ filename: './styleshets/main.css' })
    ],
    optimization: {
        minimize: process.env.npm_lifecycle_event === 'build',
        minimizer: [
            new CssMinimizerPlugin({
                minimizerOptions: { preset: [ 'default', { discardComments: { removeAll: true } } ] }
            }),
            new TerserPlugin({ parallel: true })
        ]
    },
    module: {
	rules: [
            {
                test: /\.m?js$/,
                exclude: /(node_modules|bower_components|javascripts)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env'],
                        pugins: [ "@babel/plugin-proposal-class-properties"]
                    }
                }
            },
            {
                test: /images.+\.(jpe?g|png|gif|svg|ico)$/,
                type: 'asset/resource',
            },
            {
                test: /fonts.+\.(woff(2)?|ttf|sfd|eot|svg)([?#]+\w+)?$/,
                type: 'asset/resource',
            },
            {
                test: /.+\.(jpe?g|png|gif|svg|ico)$/,
                type: 'asset/resource',
            },
            {
                test: /\.styl$/i,
                use: [
                    {
                        loader: MiniCssExtractPlugin.loader,
                        options: { publicPath: '/' }
                    },
                    { loader: 'css-loader', options: { sourceMap: true } },
                    {
                        loader: 'postcss-loader',
                        options: {
                            postcssOptions:{ plugins: [ 'postcss-preset-env' ] },
	                    sourceMap: true
	                }
                    },
                    { loader: 'stylus-loader', options: { sourceMap: true } }
                ]
            },
            {
	        test: /\.css$/,
                use: [                    
                    { loader: MiniCssExtractPlugin.loader },
                    { loader: 'css-loader', options: { sourceMap: true } },
                    {
                        loader: 'postcss-loader',
                        options: {
                            postcssOptions:{ plugins: [ 'postcss-preset-env' ] },
	                    sourceMap: true
	                }
                    }
                ]
	    },
	    {
		test: /\.imba$/,
		loader: 'imba/loader',
	    }
	]
    },
    resolve: {
        alias: {
            path: require.resolve("path-browserify")
        },
        modules: ['node_modules'],
	extensions: [".imba", ".js", ".json"],
        mainFiles: ['index']
    },
    entry: "./index.imba",
    output: {
	path: __dirname + "/public",
        publicPath: '/',
	filename: "./javascripts/application.js",
        assetModuleFilename: './assets/[hash][ext][query]'
    }
}
