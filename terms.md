HISPID Terms
============

## Institution Code

The Index Herbariorum code for the herbarium supplying the record.

Examples: `MEL`, `CANB`

<table>
<tr>
	<td>Darwin Core</td>
	<td>_[institutionCode] []_</td>
	<td>The name (or acronym) in use by the institution having custody of the object(s) or information referred to in the record.</td>
</tr>
<tr>
	<td>HISPID 3 and 4</td>
	<td>_[insid] []_</td>
	<td>The standard code for the Institution to which the plant record refers.</td>
</tr>
</table>

[institutionCode]: http://rs.tdwg.org/dwc/terms/institutionCode
[insid]: http://chah.gov.au/hispid/terms/insid

## Collection Code

An acronym or code of a collection or source within the Institution if appropriate, otherwise the same as institutionCode

Examples: `CBG`, `WAHERB`

### Darwin Core

> _[collectionCode] []_: The name, acronym, coden, or initialism identifying the collection or data set from which the record was derived.

### HISPID 3 and 4

> None.

[collectionCode]: http://rs.tdwg.org/dwc/terms/collectionCode

## Catalog Number

The unique identifier for each collection object, including the acronym

Examples: `MEL 12345`, `CANB 78021.1`, `PERTH 08444595`, `CHR 1234 A`

### Darwin Core

> _[catalogNumber] []_:  An identifier (preferably unique) for the record within the data set or collection.

### HISPID 3

> _[accid] []_: The unique identifier of the record, often called “Accession Number”, used internally by the institution to record each accession.

[catalogNumber]: http://rs.tdwg.org/dwc/terms/catalogueNumber
[accid]: http://chah.org.au/hispid/terms/accid
