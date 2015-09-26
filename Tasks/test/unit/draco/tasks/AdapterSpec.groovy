package draco.tasks

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Adapter)
class AdapterSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "testNameNull"() {
		def adapter = new Adapter()
    }
}
