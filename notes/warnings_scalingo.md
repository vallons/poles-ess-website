Tailwind is not purging unused styles because no template paths have been provided.
             If you have manually configured PurgeCSS outside of Tailwind or are deliberately not
             removing unused styles, set `purge: false` in your Tailwind config file to silence
             this warning.
          
             https://tailwindcss.com/docs/controlling-file-size/#removing-unused-css


WARNING in asset size limit: The following asset(s) exceed the recommended size limit (244 KiB).
       This can impact web performance.
       Assets: 
         media/webfonts/fa-brands-400-ccfdb9dc.svg (713 KiB)
         media/webfonts/fa-solid-900-03ba7cb7.svg (893 KiB)
         js/administration-47e10bfb607b4a81474e.js (531 KiB)
         css/application-1179c81a.css (1.43 MiB)
         js/application-2779e4e0d5b8d34c830e.js (419 KiB)
         media/webfonts/fa-solid-900-03ba7cb7.svg.gz (249 KiB)
         js/application-2779e4e0d5b8d34c830e.js.map.gz (350 KiB)
         js/administration-47e10bfb607b4a81474e.js.map.gz (462 KiB)
       
       WARNING in entrypoint size limit: The following entrypoint(s) combined asset size exceeds the recommended limit (244 KiB). This can impact web performance.
       Entrypoints:
         administration (758 KiB)
             css/administration-327218bf.css
             js/administration-47e10bfb607b4a81474e.js
         application (1.84 MiB)
             css/application-1179c81a.css
             js/application-2779e4e0d5b8d34c830e.js
       
       
       WARNING in webpack performance recommendations: 
       You can limit the size of your bundles by using import() or require.ensure to lazy load some parts of your application.
       For more info visit https://webpack.js.org/guides/code-splitting/


Running: rake assets:clean
       rake aborted!
       Don't know how to build task 'assets:clean' (See the list of available tasks with `rake --tasks`)
       Did you mean?  assets:precompile


###### WARNING:
       You set your `config.active_storage.service` to :local in production.
       If you are uploading files to this app, they will not persist after the app
       is restarted, on one-off dynos, or if the app has multiple dynos.
       Scalingo applications have an ephemeral file system. To
       persist uploaded files, please use a service such as S3 and update your Rails
       configuration.
       
       For more information can be found in this article:
         https://doc.scalingo.com/platform/app/filesystem

###### WARNING:
       We detected that some binary dependencies required to
       use all the preview features of Active Storage are not
       present on this system.
       
       If you need this feature, FFmpeg should be present,
       you can install by using its buildpack:
       
       For more information please see:
         https://doc.scalingo.com/platform/deployment/buildpacks/ffmpeg

###### WARNING:
       No Procfile detected, using the default web server (webrick)
       http://doc.scalingo.com/languages/ruby/web-server
