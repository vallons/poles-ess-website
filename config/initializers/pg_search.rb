PgSearch.multisearch_options = {
  using: {
    tsearch: {
      prefix: true,
      highlight: {
        StartSel: '<b>',
        StopSel: '</b>',
        MaxWords: 123,
        MinWords: 456,
        ShortWord: 4,
        HighlightAll: true,
        MaxFragments: 3,
        FragmentDelimiter: '&hellip;'
      }
    },
    trigram: {}
  },
  ignoring: :accents
}
