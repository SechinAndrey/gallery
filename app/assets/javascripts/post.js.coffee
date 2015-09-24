jQuery ->
  $('#q_topik_cont').autocomplete
    source: $('#q_topik_cont').data('autocomplete-source')
    minLength: 3