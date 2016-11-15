/*
 * Copyright (c) 2011-2015 BlackBerry Limited.
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

/*
 * 
 * See 
 * http://markup.su/highlighter/api 
 * for more info
 * 
 */


import bb.cascades 1.3

Page {
    function markupText() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if(xhttp.readyState === XMLHttpRequest.DONE) {
                if (xhttp.status === 200) {
                    markupTextArea.text = xhttp.responseText
                }
            }
        };
        
        var url = "http://markup.su/api/highlighter?" 
                + "source=" + encodeURIComponent(rawTextArea.text) 
                + "&language=" + encodeURIComponent(languageDropDown.selectedOption.text) 
                + "&theme=Sunburst"
                
        xhttp.open("GET", url, true);
        xhttp.send();        
    }
    
    Container {
        Container {
            layoutProperties: StackLayoutProperties { spaceQuota: 1 }
            DropDown {
                id: languageDropDown
                title: "Language"
                Option { text: "ASP vb.NET" }
                Option { text: "C" }
                Option { text: "C++" }
                Option { text: "C++ Qt"; selected: true }
                Option { text: "CSS" }
                Option { text: "Fortran - Punchcard" }
                Option { text: "HTML" }
                Option { text: "Java" }
                Option { text: "JavaScript" }
                Option { text: "JSON" }
                Option { text: "Objective-C" }
                Option { text: "PHP" }
                Option { text: "Python" }
                Option { text: "Ruby on Rails" }
                Option { text: "SQL" }
                Option { text: "XML" }
                onSelectedOptionChanged: markupText()
            }
            
            TextArea {
                id: rawTextArea
                property int numberOfLines: text.split("\n").length
                onNumberOfLinesChanged: {
                    console.log("Calling web service")
                    markupText()
                }
                input.flags: TextInputFlag.AutoCapitalizationOff
            }
        }
        
        Divider {}
        
        Container {
            layoutProperties: StackLayoutProperties { spaceQuota: 1 }
            background: Color.Black
            TextArea {
                id: markupTextArea
                editable: false
                textFormat: TextFormat.Html
            }
        }
    }
}
