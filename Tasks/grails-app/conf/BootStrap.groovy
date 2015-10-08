import draco.tasks.User
import draco.tasks.Service
import draco.tasks.Adapter

class BootStrap {

	def init = { servletContext ->
		// environment specific settings
		environments { 
			development {
				def admin = new User(username:"admin",password:"123456".encodeAsMD5(), name:"管理员", 
					admin:true, system:true, reset:false, activate:true)
				if(!admin.save()) {
					admin.errors.each {
						println it
					}
				}
				def user = new User(username:"jingxuan",password:"123456".encodeAsMD5(), name:"景轩", 
					admin:false, system:false, reset:true, activate:true)
				if(!user.save()) {
					user.errors.each {
						println it
					}
				}
				
				def service1 = new Service(name:"DIS", description:"金力调派", vendor:"jlsoft")
				if(!service1.save()) {
					service1.errors.each {
						println it
					}
				}
				
				def service2 = new Service(name:"TMS", vendor:"vtradex")
				if(!service2.save()) {
					service2.errors.each {
						println it
					}
				}
				
				def service3 = new Service(name:"ELC", description:"电商", vendor:"elc")
				if(!service3.save()) {
					service3.errors.each {
						println it
					}
				}
				
				def service4 = new Service(name:"ECC", description:"SAP ERP系统", vendor:"sap")
				if(!service4.save()) {
					service4.errors.each {
						println it
					}
				}
				
				def service5 = new Service(name:"HLT", description:"合力中税", vendor:"hlt")
				if(!service5.save()) {
					service5.errors.each {
						println it
					}
				}
				
				def adapter1 = new Adapter(name:"HTTP")
				if(!adapter1.save()) {
					adapter1.errors.each {
						println it
					}
				}
				
				def adapter2 = new Adapter(name:"SOAP")
				if(!adapter2.save()) {
					adapter2.errors.each {
						println it
					}
				}
				
				def adapter3 = new Adapter(name:"ABAP Proxy")
				if(!adapter3.save()) {
					adapter3.errors.each {
						println it
					}
				}
				
				def adapter4 = new Adapter(name:"FILE/FTP")
				if(!adapter4.save()) {
					adapter4.errors.each {
						println it
					}
				}
			}
			production {
				def admin = new User(username:"admin",password:"vnHFhgRwXaXKb2xt".encodeAsMD5(), name:"管理员", 
					admin:true, system:true, reset:false, activate:true)
				if(!admin.save()) {
					admin.errors.each {
						println it
					}
				}
			}
		}
	}
	def destroy = {
	}
}
