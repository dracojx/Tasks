import draco.tasks.User
import draco.tasks.Service
import draco.tasks.Adapter

class BootStrap {

	def init = { servletContext ->
		// environment specific settings
		environments { 
			development {
				def user = new User(username:"jingxuan",password:"Abc1234", name:"景轩", admin:true, edit:true, activate:true)
				if(!user.save()) {
					user.errors.each {
						println it
					}
				}
				
				def service1 = new Service(name:"DIS")
				if(!service1.save()) {
					service1.errors.each {
						println it
					}
				}
				
				def service2 = new Service(name:"TMS")
				if(!service2.save()) {
					service2.errors.each {
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
			}
		}
	}
	def destroy = {
	}
}
