package Runners;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

@KarateOptions(tags = {"~@ignore"})
class Runner1 {

    @Test
    public void testKarate() {
    	Runner.runFeature("classpath:features/Sample.feature", null, true);
    }
}
