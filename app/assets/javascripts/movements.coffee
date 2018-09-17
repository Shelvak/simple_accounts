window.Movements ||= {}

Movements.showSwalError = ->
  swal.showValidationError(
    'Oops hubo un problema...'
  )


Movements.chooseClient = (clients) ->
  debugger

Movements.processClientResult = (result) ->
  if result.value.length == 1
    Movements.createMovementForClient(result.value[0])
  else if result.value.length > 1
    Movements.chooseClient(result.value)
  else
    Movements.showSwalError()

Movements.createMovementForClient = (client) ->
  swal(
    title: "Cliente: #{client.name}"
    text: "Tiene $12.043"
    input: 'number'
    inputAttributes: {
       step: '.01'
    }
    confirmButtonText: 'Agregar plata'
    cancelButtonText: 'Quitar plata'
    showCancelButton: true
    showCloseButton: true
    allowEscapeKey: true
    allowOutsideClick: true
  ).then(
    (result) ->
      debugger
      # result = {dismiss: "overlay"}
      # result = {dismiss: "cancel"} solo manejar este caso
      # result = {dismiss: "close"}...
      # result = {dismiss: "overlay"}
  )

Movements.searchClient = (query) ->
  $.get(
    url: '/clients'
    data: { q: query }
    dataType: 'json'
    success: (response) ->
      response
    error: Movements.showSwalError
  )

$(document).on 'click', '[data-add-movement-to-client]', (e) ->
  e.preventDefault()
  e.stopPropagation()

  link = $(e.currentTarget)

  kind = link.data('AddMovementToClient')
  url = link.href

  swal(
    title: 'Pase la tarjeta o busca por identificador o nombre'
    input: 'text'
    inputAttributes: {
      autocapitalize: 'off'
    }
    showCancelButton: false
    showCloseButton: true
    confirmButtonText: 'Mecha'
    showLoaderOnConfirm: true
    preConfirm: Movements.searchClient
    allowEscapeKey: -> !swal.isLoading()
    allowOutsideClick: -> !swal.isLoading()
  ).then(Movements.processClientResult)

