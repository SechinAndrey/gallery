jQuery ->
  availableTags = $('#q_topik_cont').data('autocomplete-source')

  split = (val) ->
    val.split /,\s*/

  extractLast = (term) ->
    split(term).pop()

  $('#q_topik_cont').bind('keydown', (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).autocomplete('instance').menu.active
      event.preventDefault()
    return
  ).autocomplete
    minLength: 0
    source: (request, response) ->
      response $.ui.autocomplete.filter(availableTags, extractLast(request.term))
      return
    focus: ->
      false
    select: (event, ui) ->
      terms = split(@value)
      terms.pop()
      terms.push ui.item.value
      terms.push ''
      @value = terms.join(', ')
      false

  $('#image').on 'click', (event) ->
    $('#imagepreview').attr 'src', $(this).attr('src')
    $('#imageModal').modal 'show'
    return