module Aroma
  class HTTPHeader
    TOKEN = 'X-Aroma-Token'
    APP_ID = 'X-Aroma-App-Id'
    APP_VERSION = 'X-Aroma-App-Version'
    APP_VERSION_CODE = 'X-Aroma-App-Version-Code'
    OS = 'X-Aroma-Os'
    OS_VERSION = 'X-Aroma-Os-Version'
    MODEL = 'X-Aroma-Os-Model'
    UUID = 'X-Aroma-Os-Uuid'
    
    attr_accessor :token
    attr_accessor :app_id
    attr_accessor :app_version
    attr_accessor :app_version_code
    attr_accessor :os
    attr_accessor :os_version
    attr_accessor :model
    attr_accessor :uuid
    
    def initialize(headers)
      @token = headers[TOKEN]
      @app_id = headers[APP_ID]
      @app_version = headers[APP_VERSION]
      @app_version_code = headers[APP_VERSION_CODE]
      @os = headers[OS]
      @os_version = headers[OS_VERSION]
      @model = headers[MODEL]
      @uuid = headers[UUID]
    end

    def self.create_from_headers(headers)
      token = headers[TOKEN]
      app_id = headers[APP_ID]
      app_version = headers[APP_VERSION]
      app_version_code = headers[APP_VERSION_CODE]
      os = headers[OS]
      os_version = headers[OS_VERSION]
      model = headers[MODEL]
      uuid = headers[UUID]
    end
    
    def to_hash
      {
        TOKEN => @token,
        APP => @app_id,
        APP_VERSION => @app_version,
        APP_VERSION_CODE => @app_version_code,
        OS => @os,
        OS_VERSION => @os_version,
        MODEL => @model,
        UUID => @uuid,
      }
    end
  end
end
