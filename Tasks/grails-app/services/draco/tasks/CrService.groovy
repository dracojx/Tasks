package draco.tasks

import grails.transaction.Transactional

@Transactional
class CrService {

    def createCr(def number) {
		def cr = new Cr(number:number, stage:"1")
		if(!cr.save()) {
			cr.errors.each {
				println it
			}
		}
    }
}
