/**
 * Copyright (C) 2018 DANS - Data Archiving and Networked Services (info@dans.knaw.nl)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package nl.knaw.dans.bridge.service.api.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.core.env.Environment;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

/*
    @author Eko Indarto
 */
@javax.annotation.Generated(value = "io.swagger.codegen.languages.SpringCodegen", date = "2018-04-10T11:02:09.449+02:00")
@Configuration
public class DataverseBridgeDocumentationConfig {
    @Value("${info.app.build.date}")
    private String infoAppBuildDate;
    @Value("${info.app.version}")
    private String infoAppVersion;
    ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("DANS Bridge to Digital Archive Repository (DAR)")
                .description("A bridge for Archiving Dataverse dataset to Digital Archive Repository (DAR) via the SWORD v2.0 protocol.")
                .license("MIT License")
                .licenseUrl("https://opensource.org/licenses/MIT")
                .termsOfServiceUrl("https://dans.knaw.nl")
                .version(infoAppVersion + " (build date: " + infoAppBuildDate + ")")
                .contact(new Contact("DANS","https://dans.knaw.nl", "eko.indarto@dans.knaw.nl"))
                .build();
    }

    @Bean
    public Docket customImplementation(){
        return new Docket(DocumentationType.SWAGGER_2)
                .select()
                .apis(RequestHandlerSelectors.basePackage("nl.knaw.dans.bridge.service.api"))
                .build()
                .directModelSubstitute(java.time.LocalDate.class, java.sql.Date.class)
                .directModelSubstitute(java.time.OffsetDateTime.class, java.util.Date.class)
                .apiInfo(apiInfo());
    }
}
