## Site config

{

* title
  <!-- -->
  :"Fastify",

  tagline
  <!-- -->
  :"Fast and low overhead web framework, for Node.js",

  url
  <!-- -->
  :"https\://fastify.io",

  baseUrl
  <!-- -->
  :"/zh-Hans/",

  onBrokenLinks
  <!-- -->
  :"warn",

  favicon
  <!-- -->
  :"img/favicon.ico",

  trailingSlash
  <!-- -->
  :true,

  organizationName
  <!-- -->
  :"fastify",

  projectName
  <!-- -->
  :"website",

  i18n
  <!-- -->
  :{
  * defaultLocale
    <!-- -->
    :"en",

    locales
    <!-- -->
    :\[
    * "en",

      "zh-Hans"
    ],

    path
    <!-- -->
    :"i18n",

    localeConfigs
    <!-- -->
    :{}
  },

  markdown
  <!-- -->
  :{
  * hooks
    <!-- -->
    :{
    * onBrokenMarkdownLinks
      <!-- -->
      :"warn",

      onBrokenMarkdownImages
      <!-- -->
      :"throw"
    },

    format
    <!-- -->
    :"mdx",

    mermaid
    <!-- -->
    :false,

    emoji
    <!-- -->
    :true,

    mdx1Compat
    <!-- -->
    :{
    * comments
      <!-- -->
      :true,

      admonitions
      <!-- -->
      :true,

      headingIds
      <!-- -->
      :true
    },

    anchors
    <!-- -->
    :{
    * maintainCase
      <!-- -->
      :false
    }
  },

  presets
  <!-- -->
  :\[
  * \[
    * "classic",

      {}
    ]
  ],

  themeConfig
  <!-- -->
  :{
  * image
    <!-- -->
    :"img/logos/fastify-black.svg",

    colorMode
    <!-- -->
    :{
    * respectPrefersColorScheme
      <!-- -->
      :true,

      defaultMode
      <!-- -->
      :"light",

      disableSwitch
      <!-- -->
      :false
    },

    docs
    <!-- -->
    :{
    * sidebar
      <!-- -->
      :{},

      versionPersistence
      <!-- -->
      :"localStorage"
    },

    navbar
    <!-- -->
    :{
    * title
      <!-- -->
      :"Home",

      logo
      <!-- -->
      :{},

      items
      <!-- -->
      :\[],

      hideOnScroll
      <!-- -->
      :false
    },

    footer
    <!-- -->
    :{
    * style
      <!-- -->
      :"dark",

      links
      <!-- -->
      :\[
      * {},

        {},

        {}
      ],

      copyright
      <!-- -->
      :"\<p>Copyright \<a href="https\://openjsf.org">OpenJS Foundation\</a> and Fastify contributors. All rights reserved. The \<a href="https\://openjsf.org">OpenJS Foundation\</a> has registered trademarks and uses trademarks. For a list of trademarks of the \<a href="https\://openjsf.org">OpenJS Foundation\</a>, please see our \<a href="https\://trademark-policy.openjsf.org">Trademark Policy\</a> and \<a href="https\://trademark-list.openjsf.org">Trademark List\</a>. Trademarks and logos not indicated on the \<a href="https\://trademark-list.openjsf.org">list of OpenJS Foundation trademarks\</a> are trademarks\&trade; or registered\&reg; trademarks of their respective holders. Use of them does not imply any affiliation with or endorsement by them.\</p>\<p>\<a href="https\://openjsf.org">The OpenJS Foundation\</a> | \<a href="https\://terms-of-use.openjsf.org">Terms of Use\</a> | \<a href="https\://privacy-policy.openjsf.org">Privacy Policy\</a> | \<a href="https\://bylaws.openjsf.org">Bylaws\</a> | \<a href="https\://code-of-conduct.openjsf.org">Code of Conduct\</a> | \<a href="https\://trademark-policy.openjsf.org">Trademark Policy\</a> | \<a href="https\://trademark-list.openjsf.org">Trademark List\</a> | \<a href="https\://www\.linuxfoundation.org/cookies">Cookie Policy\</a>\</p>"
    },

    prism
    <!-- -->
    :{
    * theme
      <!-- -->
      :{},

      darkTheme
      <!-- -->
      :{},

      magicComments
      <!-- -->
      :\[
      * {},

        {}
      ],

      additionalLanguages
      <!-- -->
      :\[]
    },

    metadata
    <!-- -->
    :\[],

    blog
    <!-- -->
    :{
    * sidebar
      <!-- -->
      :{}
    },

    tableOfContents
    <!-- -->
    :{
    * minHeadingLevel
      <!-- -->
      :2,

      maxHeadingLevel
      <!-- -->
      :3
    }
  },

  plugins
  <!-- -->
  :\[
  * "@orama/plugin-docusaurus-v3",

    \[
    * "@docusaurus/plugin-client-redirects",

      {}
    ],

    \[
    * "@signalwire/docusaurus-plugin-llms-txt",

      {}
    ]
  ],

  baseUrlIssueBanner
  <!-- -->
  :true,

  future
  <!-- -->
  :{
  * v4
    <!-- -->
    :{
    * removeLegacyPostBuildHeadAttribute
      <!-- -->
      :false,

      useCssCascadeLayers
      <!-- -->
      :false
    },

    experimental\_faster
    <!-- -->
    :{
    * swcJsLoader
      <!-- -->
      :false,

      swcJsMinimizer
      <!-- -->
      :false,

      swcHtmlMinimizer
      <!-- -->
      :false,

      lightningCssMinimizer
      <!-- -->
      :false,

      mdxCrossCompilerCache
      <!-- -->
      :false,

      rspackBundler
      <!-- -->
      :false,

      rspackPersistentCache
      <!-- -->
      :false,

      ssgWorkerThreads
      <!-- -->
      :false
    },

    experimental\_storage
    <!-- -->
    :{
    * type
      <!-- -->
      :"localStorage",

      namespace
      <!-- -->
      :false
    },

    experimental\_router
    <!-- -->
    :"browser"
  },

  onBrokenAnchors
  <!-- -->
  :"warn",

  onDuplicateRoutes
  <!-- -->
  :"warn",

  staticDirectories
  <!-- -->
  :\[
  * "static"
  ],

  customFields
  <!-- -->
  :{},

  themes
  <!-- -->
  :\[],

  scripts
  <!-- -->
  :\[],

  headTags
  <!-- -->
  :\[],

  stylesheets
  <!-- -->
  :\[],

  clientModules
  <!-- -->
  :\[],

  titleDelimiter
  <!-- -->
  :"|",

  noIndex
  <!-- -->
  :false

}
