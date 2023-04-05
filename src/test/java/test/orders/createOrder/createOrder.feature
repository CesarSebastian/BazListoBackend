Feature: Create a Order

  Background:
    * def unix =
    """
    function(arg) {
      var unixTime = Java.type('org.pedidos.unixtime.unixTime')
      var jd = new unixTime();
      return jd.unixTimeGet();
    }
    """
    * def result = call unix
    * def data = read('../../orders/createOrder/createOrder.json')
    * def env = read("../../environmentGlobal.json")
    * set data.fechaPedido = result
    * call read("../../authenticator/authenticator.feature@Token")

  Scenario: Print Data Pre-Post
      * remove data.cliente.negocio
      * print data

  #Create Order
  @CreateOrder
  Scenario: Create Correct Order
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    And request data
    When method post
    Then status 201
    And def id = $.id

  Scenario: Date Order - Incorrect
    Given header autorization = bearer
    And header x-id-interaccion = '123e4567-e89b-12d3-a456-426655440000'
    And header x-sicu = '241796043bb3423589809937918439f0'
    And header x-token-usuario = '3M2phrXFv57Snyxk7tXrD4TNfebuXFKJ'
    When url env.url_dev + '/pedidos'
    * set data.fechaPedido = '10330033'
    And request data
    When method post
    Then status 400

  Scenario: Date Order - Empty
    Given header autorization = bearer
    And header x-id-interaccion = '123e4567-e89b-12d3-a456-426655440000'
    And header x-sicu = '241796043bb3423589809937918439f0'
    And header x-token-usuario = '3M2phrXFv57Snyxk7tXrD4TNfebuXFKJ'
    When url env.url_dev + '/pedidos'
    * set data.fechaPedido = null
    And request data
    When method post
    Then status 400

  Scenario: Date Order - Range Out
    Given header autorization = bearer
    And header x-id-interaccion = '123e4567-e89b-12d3-a456-426655440000'
    And header x-sicu = '241796043bb3423589809937918439f0'
    And header x-token-usuario = '3M2phrXFv57Snyxk7tXrD4TNfebuXFKJ'
    When url env.url_dev + '/pedidos'
    * set data.fechaPedido = '1641016801000'
    And request data
    When method post
    Then status 400

  Scenario: Description Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.descripcionPedido = "Prueba de Descripción"
    And request data
    When method post
    Then status 422

  Scenario: Description Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.descripcionPedido = null
    And request data
    When method post
    Then status 400

  Scenario: ChatId Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.chatId = "Prueba123ChatId"
    And request data
    When method post
    Then status 422

  Scenario: ChatId Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.chatId = null
    And request data
    When method post
    Then status 400

  #Cliente
    # Error - Crea la Orden
  Scenario: idi Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.idi = "Prueba123Idi"
    And request data
    When method post
    Then status 422

  Scenario: idi Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.idi = null
    And request data
    When method post
    Then status 400

  Scenario: contacto Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.contacto = "Prueba123contacto"
    And request data
    When method post
    Then status 422

  Scenario: contacto Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.contacto = null
    And request data
    When method post
    Then status 400

  Scenario: nombre Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.nombre = "Prueba123contacto"
    And request data
    When method post
    Then status 422

  Scenario: nombre Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.nombre = null
    And request data
    When method post
    Then status 400

  Scenario: Body Client Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente
    And request data
    When method post
    Then status 400

    #Dirección
  Scenario: Body Direccion Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion
    And request data
    When method post
    Then status 400

  # Crea el pedido
  Scenario: referencia Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ubicacion.referencia = "Prueba123referencia"
    And request data
    When method post
    Then status 422

  Scenario: referencia Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ubicacion.referencia = null
    And request data
    When method post
    Then status 400

  Scenario: Body referencia Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.referencia
    And request data
    When method post
    Then status 400
  #Crea Pedido
  Scenario: entreCalles Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.entreCalles = "Prueba123entreCalles"
    And request data
    When method post
    Then status 422

  Scenario: entreCalles Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.entreCalles = null
    And request data
    When method post
    Then status 200

  Scenario: Body entreCalles Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.entreCalles
    And request data
    When method post
    Then status 400
  #Tiene un pedido abierto
  Scenario: imagenReferencia Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.imagenReferencia = "Prueba123imagenReferencia"
    And request data
    When method post
    Then status 422

  Scenario: imagenReferencia Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.imagenReferencia = null
    And request data
    When method post
    Then status 200

  Scenario: Body imagenReferencia Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.imagenReferencia
    And request data
    When method post
    Then status 400
  #Crear Pedido
  Scenario: etiquetaLugar Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.etiquetaLugar = "Prueba123etiquetaLugar"
    And request data
    When method post
    Then status 422

  Scenario: etiquetaLugar Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.etiquetaLugar = null
    And request data
    When method post
    Then status 200

  Scenario: Body etiqueta Lugar Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.etiquetaLugar
    And request data
    When method post
    Then status 400

  Scenario: etiquetaLugar Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.calle = "Prueba123etiquetaLugar"
    And request data
    When method post
    Then status 422

  Scenario: etiquetaLugar Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.calle = null
    And request data
    When method post
    Then status 400

  Scenario: Body calle Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.calle
    And request data
    When method post
    Then status 400

  Scenario: numeroExterior Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.numeroExterior = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422
#Crea Pedido
  Scenario: numeroExterior Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.numeroExterior = null
    And request data
    When method post
    Then status 400

  Scenario: Body numeroExterior Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.numeroExterior
    And request data
    When method post
    Then status 400

  Scenario: numeroInterior Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.numeroInterior = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: numeroInterior Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.numeroInterior = null
    And request data
    When method post
    Then status 400

  Scenario: Body numeroInterior Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.numeroInterior
    And request data
    When method post
    Then status 400

  Scenario: colonia Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.colonia = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: colonia Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.colonia = null
    And request data
    When method post
    Then status 400

  Scenario: Body colonia Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.colonia
    And request data
    When method post
    Then status 400

  Scenario: codigoPostal Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.codigoPostal = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: codigoPostal Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.codigoPostal = null
    And request data
    When method post
    Then status 400

  Scenario: Body codigoPostal Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.codigoPostal
    And request data
    When method post
    Then status 400

  Scenario: municipio Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.municipio = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: municipio Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.municipio = null
    And request data
    When method post
    Then status 400

  Scenario: Body codigoPostal Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.municipio
    And request data
    When method post
    Then status 400

  Scenario: entidadFederativa Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.entidadFederativa = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: entidadFederativa Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.entidadFederativa = null
    And request data
    When method post
    Then status 400

  Scenario: Body entidadFederativa Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.entidadFederativa
    And request data
    When method post
    Then status 400
  #Crea Pedido
  Scenario: ciudad Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ciudad = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: ciudad Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ciudad = null
    And request data
    When method post
    Then status 400

  Scenario: Body ciudad Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.ciudad
    And request data
    When method post
    Then status 400
#Ubicación
  Scenario: Body ubicacion Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.ubicacion
    And request data
    When method post
    Then status 400

  Scenario: latitud Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ubicacion.latitud = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: ciudad Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ubicacion.latitud = null
    And request data
    When method post
    Then status 400

  Scenario: Body ciudad Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.ubicacion.latitud
    And request data
    When method post
    Then status 400

  Scenario: latitud Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ubicacion.latitud = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: longitud Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.cliente.direccion.ubicacion.longitud = null
    And request data
    When method post
    Then status 400

  Scenario: Body longitud Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.cliente.direccion.ubicacion.longitud
    And request data
    When method post
    Then status 400

    #Negocio

  Scenario: Body negocio Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio
    And request data
    When method post
    Then status 400

  Scenario: Body id Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.id
    And request data
    When method post
    Then status 400

  Scenario: id Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.id = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: id Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.id = null
    And request data
    When method post
    Then status 400

  Scenario: Body contacto Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.contacto
    And request data
    When method post
    Then status 400

  Scenario: contacto Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.contacto = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: contacto Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.contacto = null
    And request data
    When method post
    Then status 400

  Scenario: Body logo Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.logo
    And request data
    When method post
    Then status 400

  Scenario: logo Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.logo = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: logo Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.logo = null
    And request data
    When method post
    Then status 400

  Scenario: Body name Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.name
    And request data
    When method post
    Then status 400

  Scenario: name Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.name = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: name Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.name = null
    And request data
    When method post
    Then status 400

  Scenario: Body owner Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.owner
    And request data
    When method post
    Then status 400

  Scenario: owner Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.owner = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: owner Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.owner = null
    And request data
    When method post
    Then status 400

    #Dirección Negocio
  Scenario: Body direccion Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion
    And request data
    When method post
    Then status 400

  Scenario: Body referencia Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.referencia
    And request data
    When method post
    Then status 400

  Scenario: referencia Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.referencia = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: referencia Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.referencia = null
    And request data
    When method post
    Then status 200

  Scenario: Body entreCalles Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.entreCalles
    And request data
    When method post
    Then status 400

  Scenario: entreCalles Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.entreCalles = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: entreCalles Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.entreCalles = null
    And request data
    When method post
    Then status 200

  Scenario: Body imagenReferencia Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.imagenReferencia
    And request data
    When method post
    Then status 400

  Scenario: imagenReferencia Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.imagenReferencia = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: imagenReferencia Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.imagenReferencia = null
    And request data
    When method post
    Then status 200

  Scenario: Body etiquetaLugar Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.etiquetaLugar
    And request data
    When method post
    Then status 400

  Scenario: etiquetaLugar Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.etiquetaLugar = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: calle Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.calle = null
    And request data
    When method post
    Then status 200

  Scenario: Body calle Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.calle
    And request data
    When method post
    Then status 400

  Scenario: calle Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.calle = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: calle Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.calle = null
    And request data
    When method post
    Then status 400

  Scenario: Body numeroExterior Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.numeroExterior
    And request data
    When method post
    Then status 400

  Scenario: numeroExterior Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.numeroExterior = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: numeroExterior Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.numeroExterior = null
    And request data
    When method post
    Then status 400

  Scenario: Body numeroInterior Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.numeroInterior
    And request data
    When method post
    Then status 400

  Scenario: numeroInterior Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.numeroInterior = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: numeroInterior Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.numeroInterior = null
    And request data
    When method post
    Then status 400

  Scenario: Body codigoPostal Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.codigoPostal
    And request data
    When method post
    Then status 400

  Scenario: numeroInterior Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.codigoPostal = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: codigoPostal Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.codigoPostal = null
    And request data
    When method post
    Then status 400

  Scenario: Body municipio Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.municipio
    And request data
    When method post
    Then status 400

  Scenario: municipio Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.municipio = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: municipio Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.municipio = null
    And request data
    When method post
    Then status 400

  Scenario: Body entidadFederativa Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.entidadFederativa
    And request data
    When method post
    Then status 400

  Scenario: entidadFederativa Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.entidadFederativa = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: entidadFederativa Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.entidadFederativa = null
    And request data
    When method post
    Then status 400

  Scenario: Body ciudad Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.ciudad
    And request data
    When method post
    Then status 400

  Scenario: ciudad Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.ciudad = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: ciudad Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.ciudad = null
    And request data
    When method post
    Then status 400

    #ubicacion
  Scenario: Body ubicacion Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.ubicacion
    And request data
    When method post
    Then status 400

  Scenario: Body latitud Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.ubicacion.latitud
    And request data
    When method post
    Then status 400

  Scenario: latitud Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.ubicacion.latitud = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: latitud Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.ubicacion.latitud = null
    And request data
    When method post
    Then status 400

  Scenario: Body longitud Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.direccion.ubicacion.longitud
    And request data
    When method post
    Then status 400

  Scenario: longitud Not Encrypt
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.ubicacion.longitud = "Prueba123numeroExterior"
    And request data
    When method post
    Then status 422

  Scenario: longitud Null
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.direccion.ubicacion.longitud = null
    And request data
    When method post
    Then status 400

      #Categoria
  Scenario: Categoria Empty
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.categoria
    And request data
    When method post
    Then status 400

    #Server error
  Scenario: Categoria Id Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.categoria.id
    And request data
    When method post
    Then status 400

  Scenario: Categoria Name Different
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.categoria.nombre = "Prueba1nombre"
    And request data
    When method post
    Then status 200

    #Server Error
  Scenario: Categoria Name Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.categoria.nombre
    And request data
    When method post
    Then status 400

    #Server error
  Scenario: subCategoria Empty
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.categoria.subCategoria
    And request data
    When method post
    Then status 400

    #Server Error
  Scenario: subCategoria Id Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.negocio.categoria.subCategoria.id
    And request data
    When method post
    Then status 400

  Scenario: subCategoria Name different
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.negocio.categoria.subCategoria.name = "Pruebas123"
    And request data
    When method post
    Then status 200

    #Productos
  Scenario: Productos Out
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * remove data.productos
    And request data
    When method post
    Then status 400

    #Plasticos
  Scenario: Plasticos True
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos'
    * set data.plasticos = "True"
    And request data
    When method post
    Then status 200