require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Pruebin Speculo",
      :email => "pruebin@rspec.com",
      :password => "speculus",
      :password_confirmation => "speculus"
    }
  end

  describe "email" do

    it "debe crear una instancia dandole atributos validos" do
      User.create!(@attr)
    end

    it "debe tener un mail" do
      usuario_sin_mail = User.new(@attr.merge(:email => ""))
      usuario_sin_mail.should_not be_valid
    end

    it "debe aceptar mails con formato valido" do
      mails_validos = %w[usuario@valido.com EL_USUARIO@mail.valido.org mail.valido@validez.jp]
      mails_validos.each do |mail|
        usuario_con_email_valido = User.new(@attr.merge(:email => mail))
        usuario_con_email_valido.should be_valid
      end
    end

    it "debe rechazar mails invalidos" do
      mails_invalidos = %w[hola soyUnMalMail@ mailInvalido@@invalidez.cl mailmalo@gmail. malito@invalido,com]
      mails_invalidos.each do |mail|
        usuario_con_email_valido = User.new(@attr.merge(:email => mail))
        usuario_con_email_valido.should_not be_valid
      end
    end

    it "debe rechazar usuarios con mail duplicado" do
      User.create!(@attr)
      usuario_con_mail_duplicado = User.new(@attr)
      usuario_con_mail_duplicado.should_not be_valid
    end

    it "debe rechazar emails identicos con up to case" do
      email_en_mayusculas = @attr[:email].upcase
      User.create!(@attr.merge(:email => email_en_mayusculas))
      usuario_con_mail_duplicado = User.new(@attr)
      usuario_con_mail_duplicado.should_not be_valid
    end

    it "debe tener el mismo mail que en los atributos" do
      usuario = User.new(@attr)
      usuario.email.should eql "pruebin@rspec.com"
    end
  end

  describe "usuario y roles" do

    before(:each) do
      @usuario = User.create(@attr)
    end

    it "debe tener el mismo nombre que en los atributos" do
      @usuario.name.should eql "Pruebin Speculo"
    end

    it "no debe aprobar roles que no le perteneces" do
      @usuario.add_role :admin
      @usuario.has_role?(:evaluator).should be_false
    end

    it "debe aprobar roles que le perteneces" do
      @usuario.add_role :admin
      @usuario.has_role?(:admin).should be_true
    end
  end

  describe "passwords" do

    before(:each) do
      @usuario = User.new(@attr)
    end

    it "debe tener el atributo password" do
      @usuario.should respond_to(:password)
    end

    it "debe tener el atributo password confirmation" do
      @usuario.should respond_to(:password_confirmation)
    end
  end

  describe "validaciones de password" do

    it "debe tener una password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "debe requerir una password confirmation que sea igual a la password" do
      usuario = User.new(@attr.merge(:password_confirmation => "otra_clave"))
      usuario.should_not be_valid
    end

    it "debe rechazar claves cortas" do
      clave_corta = "corta"
      usuario = User.new(@attr.merge(:password => clave_corta, :password_confirmation => clave_corta))
      usuario.should_not be_valid
    end

  end

  describe "encriptacion de la password" do

    before(:each) do
      @usuario = User.create!(@attr)
    end

    it "debe tener un atributo que almacene la clave encriptada" do
      @usuario.should respond_to(:encrypted_password)
    end

    it "debe setear el atributo encrypted_password" do
      @usuario.encrypted_password.should_not be_blank
    end

  end

end
