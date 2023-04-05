Feature: Get Order
  Background:
    * call read("../../authenticator/authenticator.feature@Token")
    * def env = read("../../environmentGlobal.json")
    * def param = read("getOrder.json")

    Scenario: Get Correct Order
      Given header autorization = bearer
      And header x-dueno = param.sicuCommerce
      And header x-sicu = param.sicuClient
      And param id-tienda = param.externalCommerceId
      When url env.url_dev + '/pedidos/buscar'
      When method get
      Then status 200

  Scenario: CommerceId Incorrect
    Given header autorization = bearer
    * param.sicuCommerce = '170320231657'
    And header x-dueno = param.sicuCommerce
    And header x-sicu = param.sicuClient
    And param id-tienda = param.externalCommerceId
    When url env.url_dev + '/pedidos/buscar'
    When method get
    Then status 200

  Scenario: CommerceId - Empty
    Given header autorization = bearer
    * param.sicuCommerce = null
    And header x-dueno = param.sicuCommerce
    And header x-sicu = param.sicuClient
    And param id-tienda = param.externalCommerceId
    When url env.url_dev + '/pedidos/buscar'
    When method get
    Then status 200

  Scenario: Client Incorrect
    Given header autorization = bearer
    And header x-dueno = param.sicuCommerce
    And header x-sicu = '1234'
    And param id-tienda = param.externalCommerceId
    When url env.url_dev + '/pedidos/buscar'
    When method get
    Then status 200

  Scenario: Client - Empty
    Given header autorization = bearer
    And header x-dueno = param.sicuCommerce
    And header x-sicu = null
    And param id-tienda = param.externalCommerceId
    When url env.url_dev + '/pedidos/buscar'
    When method get
    Then status 200

  Scenario: Id Tienda - Incorrect
    Given header autorization = bearer
    And header x-dueno = param.sicuCommerce
    And header x-sicu = param.sicuClient
    And param id-tienda = '1234567890'
    When url env.url_dev + '/pedidos/buscar'
    When method get
    Then status 200

  Scenario: Id Tienda - Empty
    Given header autorization = bearer
    And header x-dueno = param.sicuCommerce
    And header x-sicu = param.sicuClient
    And param id-tienda = ''
    When url env.url_dev + '/pedidos/buscar'
    When method get
    Then status 200