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
package nl.knaw.dans.bridge.service.generated.model;

import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;
import javax.validation.Valid;
import javax.validation.constraints.*;

/**
 * XslTransformer
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2018-11-13T20:06:05.738+01:00[Europe/Amsterdam]")

public class XslTransformer   {
  @JsonProperty("xsl-name")
  private String xslName = null;

  @JsonProperty("xsl-url")
  private String xslUrl = null;

  public XslTransformer xslName(String xslName) {
    this.xslName = xslName;
    return this;
  }

  /**
   * Get xslName
   * @return xslName
  **/
  @ApiModelProperty(value = "")


  public String getXslName() {
    return xslName;
  }

  public void setXslName(String xslName) {
    this.xslName = xslName;
  }

  public XslTransformer xslUrl(String xslUrl) {
    this.xslUrl = xslUrl;
    return this;
  }

  /**
   * Get xslUrl
   * @return xslUrl
  **/
  @ApiModelProperty(value = "")


  public String getXslUrl() {
    return xslUrl;
  }

  public void setXslUrl(String xslUrl) {
    this.xslUrl = xslUrl;
  }


  @Override
  public boolean equals(java.lang.Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    XslTransformer xslTransformer = (XslTransformer) o;
    return Objects.equals(this.xslName, xslTransformer.xslName) &&
        Objects.equals(this.xslUrl, xslTransformer.xslUrl);
  }

  @Override
  public int hashCode() {
    return Objects.hash(xslName, xslUrl);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class XslTransformer {\n");
    
    sb.append("    xslName: ").append(toIndentedString(xslName)).append("\n");
    sb.append("    xslUrl: ").append(toIndentedString(xslUrl)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(java.lang.Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}

