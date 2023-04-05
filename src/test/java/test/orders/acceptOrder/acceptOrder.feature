Feature: Accept Order
  Background:
  * def acceptBody = read('acceptOrder.json')
  * call read("../../authenticator/authenticator.feature@Token")
  * def encryptor = Java.type('test.orders.acceptOrder.encrypOrder')
  * def env = read("../../environmentGlobal.json")
  * def sleep = function(millis){ java.lang.Thread.sleep(millis) }


  Scenario: Print Before Request
    * print acceptBody

  Scenario: Create Order & Accept
    * call read("../createOrder/createOrder.feature@CreateOrder")
    * def result = encryptor.getEncrypt(id,env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request acceptBody
    When method post
    Then status 200

    #Solventar Error - Error de Servicio
  Scenario: Accept Incorrect Order
    * def result = encryptor.getEncrypt('123456789',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request acceptBody
    When method post
    Then status 400

  #Solventar Error - Error de Token
  Scenario: Accept Empty Order
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+'/aceptar'
    And request acceptBody
    When method post
    Then status 403

  Scenario: Accept Order - Status Client Request
    * def result = encryptor.getEncrypt('64135614ee52f80008cb99c3',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request acceptBody
    When method post
    Then status 200

    #Agregar - Solicitud de Cambio de Estatus a 2
  Scenario: Accept Order - Previously Accepted
    * def result = encryptor.getEncrypt('64135614ee52f80008cb99c3',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request acceptBody
    When method post
    Then status 400

  Scenario: Amount - Incorrect (< 10)
    * def mont = encryptor.getAmount('1',env.encryp_key)
    * set acceptBody.monto = mont
    * def result = encryptor.getEncrypt('64135614ee52f80008cb99c3',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request acceptBody
    When method post
    Then status 400

  Scenario: Amount - Zero
    * def mont = encryptor.getAmount('0',env.encryp_key)
    * set acceptBody.monto = mont
    * def result = encryptor.getEncrypt('64135614ee52f80008cb99c3',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request acceptBody
    When method post
    Then status 400

  Scenario: Amount - Null
    * set acceptBody.monto = null
    * def result = encryptor.getEncrypt('64135614ee52f80008cb99c3',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request acceptBody
    When method post
    Then status 400

  Scenario: Amount - Out Amount
    * def result = encryptor.getEncrypt('64135614ee52f80008cb99c3',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/aceptar'
    And request {"descripcionPedido": null}
    When method acceptBody
    Then status 400