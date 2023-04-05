Feature: EditOrder
  Background:
    * def env = read("../../environmentGlobal.json")
    * call read("../../authenticator/authenticator.feature@Token")


  Scenario: Encrypt Information
    * print id

  Scenario: Edit Order Correct
    * call read("../createOrder/createOrder.feature@CreateOrder")
    * def encryptor = Java.type('test.orders.acceptOrder.encrypOrder')
    * def result = encryptor.getEncrypt(id,env.encryp_key)
    Given header autorization = bearer
    When url env.url_dev + "/pedidos" + result + "/editar"
    When method Post
    Then status 200

  Scenario: Bad token
    * call read("../createOrder/createOrder.feature@CreateOrder")
    * def encryptor = Java.type('test.orders.acceptOrder.encrypOrder')
    * def result = encryptor.getEncrypt(id,env.encryp_key)
    Given header autorization = '1234'
    When url env.url_dev + "/pedidos" + result + "/editar"
    When method post
    Then status 403

  # Error Autenticación
  Scenario: Out Order Id
    Given header autorization = bearer
    When url env.url_dev + "/pedidos" + "/editar"
    When method post
    Then status 400

  # Error de Autenticación
  Scenario: Bad Order Id
    Given header autorization  = bearer
    When url env.url_dev + "/pedidos" + "123" + "/editar"
    When method Post
    Then status 403


