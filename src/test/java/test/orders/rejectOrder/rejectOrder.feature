Feature: RejectOrder
  Background:
    * def rejectBody = read ('rejectOrder.json')
    * call read("../../authenticator/authenticator.feature@Token")
    * def encryptor = Java.type('test.orders.acceptOrder.encrypOrder')
    * def env = read("../../environmentGlobal.json")

  Scenario: Print Before Request
    * print rejectBody

  Scenario: Create order & Reject
    * call read("../createOrder/createOrder.feature@CreateOrder")
    * def result = encryptor.getEncrypt(id,env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/rechazar'
    And request rejectBody
    When method post
    Then status 200

  Scenario: Reject incorrect Order
    * def result = encryptor.getEncrypt ('123456789',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/rechazar'
    And request rejectBody
    When method post
    Then status 400

  Scenario: Reject empty Order
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+'/rechazar'
    And request rejectBody
    When method post
    Then status 403

  Scenario: Reject order previously rejected
    * def result = encryptor.getEncrypt('64135614ee52f80008cb99c3',env.encryp_key)
    Given header autorization = bearer
    And header x-id-interaccion = env.header_dev.x_id_interaccion
    And header x-sicu = env.header_dev.x_sicu
    And header x-token-usuario = env.header_dev.x_token_usuario
    When url env.url_dev + '/pedidos/'+result+'/rechazar'
    And request rejectBody
    When method post
    Then status 400


