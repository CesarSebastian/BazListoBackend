Feature: Authentication Get
  @Token
  Scenario: Authentication Get Token
    Given url "https://api.middleware.delivery-dev.com"+"/autenticacion"
    And request {"usuario": "qa-middleware","contraseña": "2yx1I896Y6Q8#"}
    When method post
    Then status 200
    And def token = $.access_token
    And def bearer = 'Bearer ' + token
    And print bearer

  Scenario: Incorrect User
    Given url "https://api.middleware.delivery-dev.com"+"/autenticacion"
    And request {"usuario": "qa-spider","contraseña": "2yx1I896Y6Q8#"}
    When method post
    Then status 401

  Scenario: Incorrect Password
    Given url "https://api.middleware.delivery-dev.com"+"/autenticacion"
    And request {"usuario": "qa-middleware","contraseña": "123#"}
    When method post
    Then status 401