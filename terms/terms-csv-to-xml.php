<?php

//ldHispidTransferCodes();
hispidTerms();

function hispidTerms() {
    $handle = fopen('../HISPID2015_class.csv', 'r');
    fgetcsv($handle);
    $classes = array();
    $cl_ns = array();
    while (!feof($handle)) {
        $line = fgetcsv($handle);
        if ($line && $line[1]) {
            $cl_ns[] = $line[1];
            $classes[] = $line;
        }
    }
    fclose($handle);


    $handle = fopen('../HISPID2015.csv', 'r');
    $firstRow = fgetcsv($handle);
    $csv = array();
    $pr_classes = array();
    while (!feof($handle)) {
        $line = fgetcsv($handle);
        if ($line) {
            $pr_classes[] = $line[1];
            $csv[] = $line;
        }
    }
    fclose($handle);
    
    $properties = array();
    foreach ($csv as $i => $prop) {
        $properties[] = array();
        foreach ($prop as $j => $value) {
            $properties[$i][$firstRow[$j]] = $value;
        }
    }

    $doc = new DOMDocument('1.0', 'UTF-8');
    $root = $doc->createElement('hispid');
    $doc->appendChild($root);

    $terms = $doc->createElement('terms');
    $root->appendChild($terms);

    /*
     * Classes
     */
    foreach ($classes as $class) {
        $term = $doc->createElement('term');
        $newnode = $doc->createElement('type', 'Class');
        $term->appendChild($newnode);
        $newnode = $doc->createElement('name', $class[0]);
        $term->appendChild($newnode);
        $label = ucfirst(preg_replace('/([a-z])([A-Z])/', '$1 $2', $class[0]));
        $newnode = $doc->createElement('label', $label);
        $term->appendChild($newnode);
        $newnode = $doc->createElement('namespace', $class[1]);
        $term->appendChild($newnode);
        $newnode = $doc->createElement('qualName', $class[2]);
        $term->appendChild($newnode);
        $newnode = $doc->createElement('definition', $class[3]);
        $term->appendChild($newnode);
        $newnode = $doc->createElement('issued', $class[4]);
        $term->appendChild($newnode);
        $newnode = $doc->createElement('modified', $class[5]);
        $term->appendChild($newnode);
        $newnode = $doc->createElement('status', $class[6]);
        $term->appendChild($newnode);
        $terms->appendChild($term);
    }

    /*
     * Properties
     */

    foreach ($properties as $prop) {
        $term = $doc->createElement('term');
        // type
        $newnode = $doc->createElement('type', 'Property');
        $term->appendChild($newnode);
        // name
        $newnode = $doc->createElement('name', $prop['name']);
        $term->appendChild($newnode);
        // label
        $label = ucfirst(preg_replace('/([a-z])([A-Z])/', '$1 $2', $prop['name']));
        $newnode = $doc->createElement('label', $label);
        $term->appendChild($newnode);

        // namespace
        $newnode = $doc->createElement('namespace', $prop['namespace']);
        $term->appendChild($newnode);
        // qualName
        $newnode = $doc->createElement('qualName');
        $newnode->appendChild(new DOMText($prop['qualName']));
        $term->appendChild($newnode);
        // definition
        $newnode = $doc->createElement('definition');
        $newnode->appendChild(new DOMText($prop['description']));
        $term->appendChild($newnode);
        // class
        if ($prop['group'] && $prop['group'] != 'Record level terms') {
            $newnode = $doc->createElement('inClass', 'http://hiscom.chah.org.au/hispid/terms/' . $prop['group']);
            $term->appendChild($newnode);
        }
        // dataType
        if ($prop['dataType']) {
            $newnode = $doc->createElement('dataType', $prop['dataType']);
            $term->appendChild($newnode);
        }
        // usage
        if ($prop['usage']) {
            $newnode = $doc->createElement('usage');
            $newnode->appendChild(new DOMText($prop['usage']));
            $term->appendChild($newnode);
        }
        // vocabulary
        if ($prop['vocabulary']) {
            $newnode = $doc->createElement('vocabulary');
            $newnode->appendChild(new DOMText($prop['vocabulary']));
            $term->appendChild($newnode);
        }
        // comments
        if ($prop['comments']) {
            $newnode = $doc->createElement('comments');
            $newnode->appendChild(new DOMText($prop['comments']));
            $term->appendChild($newnode);
        }
        // examples
        if ($prop['examples']) {
            $newnode = $doc->createElement('examples');
            $arr = str_getcsv($prop['examples']);
            foreach (str_getcsv($prop['examples']) as $example) {
                $exnode = $doc->createElement('example', $example);
                $newnode->appendChild($exnode);
            }
            $term->appendChild($newnode);
        }
        // status
        if ($prop['status']) {
            $newnode = $doc->createElement('status');
            $newnode->appendChild(new DOMText($prop['status']));
            $term->appendChild($newnode);
        }
        // gitHub
        if ($prop['GitHub issue']) {
            $newnode = $doc->createElement('gitHub');
            $newnode->appendChild(new DOMText($prop['GitHub issue']));
            $term->appendChild($newnode);
        }
        // dwc
        if ($prop['Darwin Core']) {
            $newnode = $doc->createElement('dwc');
            $newnode->appendChild(new DOMText($prop['Darwin Core']));
            $term->appendChild($newnode);
        }
        // abcd
        if ($prop['ABCD']) {
            $newnode = $doc->createElement('abcd');
            $newnode->appendChild(new DOMText($prop['ABCD']));
            $term->appendChild($newnode);
        }
        // hispid3
        /*if ($prop[14]) {
            $newnode = $doc->createElement('hispid3');
            $newnode->appendChild(new DOMText($prop[14]));
            $term->appendChild($newnode);
        }*/
        // hispid4
        if ($prop['HISPID 4']) {
            $replaces = $doc->createElement('replaces');
            
            $arr = explode('+', $prop['HISPID 4']);
            foreach ($arr as $bit) {
                $bit = trim(str_replace('p.p.', '', $bit));
                $newnode = $doc->createElement('term', $bit);
                $replaces->appendChild($newnode);
            }
            $term->appendChild($replaces);
        }
        // hispid5
        /*if ($prop[16]) {
            $newnode = $doc->createElement('hispid5');
            $newnode->appendChild(new DOMText($prop[16]));
            $term->appendChild($newnode);
        }*/
        // ac
        if ($prop['Audubon Core']) {
            $newnode = $doc->createElement('ac');
            $newnode->appendChild(new DOMText($prop['Audubon Core']));
            $term->appendChild($newnode);
        }
        // issued
        if ($prop['issued']) {
            $newnode = $doc->createElement('issued');
            $newnode->appendChild(new DOMText($prop['issued']));
            $term->appendChild($newnode);
        }
        // modified
        if ($prop['modified']) {
            $newnode = $doc->createElement('modified');
            $newnode->appendChild(new DOMText($prop['modified']));
            $term->appendChild($newnode);
        }


        $terms->appendChild($term);
    }

    $doc->save('HISPID2015.xml');

    header('Content-type: text/xml');
    echo $doc->saveXML();
}

function oldHispidTransferCodes() {
    $handle = fopen('../AVH fields 2014-08-14 - HISPID elements.csv', 'r');
    $csv = array();
    while (!feof($handle)) {
        $line = fgetcsv($handle);
        if ($line && $line[0] && ($line[1] || $line[2] || $line[3])) {
            if ($line[1]) {
                $csv[] = array(
                    'term' => $line[1],
                    'label' => $line[0],
                    'version' => 'hispid3'
                );
            }
            if ($line[2]) {
                $csv[] = array(
                    'term' => $line[2],
                    'label' => $line[0],
                    'version' => 'hispid4'
                );
            }
            if ($line[3]) {
                $csv[] = array(
                    'term' => $line[3],
                    'label' => $line[0],
                    'version' => 'hispid5'
                );
            }
        }
    }
    fclose($handle);
    
    $doc = new DOMDocument();
    $root = $doc->createElement('hispid');
    $doc->appendChild($root);
    $terms = $doc->createElement('terms');
    $root->appendChild($terms);
    
    foreach ($csv as $row) {
        $term = $doc->createElement('term');
        @$newnode = $doc->createElement('name', $row['term']);
        $term->appendChild($newnode);
        @$newnode = $doc->createElement('label', $row['label']);
        $term->appendChild($newnode);
        @$newnode = $doc->createElement('version', $row['version']);
        $term->appendChild($newnode);
        $terms->appendChild($term);
    }
    
    $doc->save('HISPID2015_old_terms.xml');
    header('Content-type: text/xml');
    echo $doc->saveXML();
            
}




