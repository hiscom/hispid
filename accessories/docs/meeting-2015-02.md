Meeting Agenda, 16–18 February 2015
===================================

## General Items

HISPID should become a list of terms and definitions. It should not define a particular transfer format to avoid the need to define essentially the same terms at least once per transfer format. For exchange of herbarium data, HISPID 5 remains a useful transfer standard as it provides better atomisation than HISPID 3 and Darwin Core. Darwin Core is better for AVH/ALA content because that is the standard they use and a herbarium needs access to more terms than AVH.

We need to assume that it is increasingly common that herbaria will be hiring consultants to implement data transfer systems, rather than using in-house resources. In this situation, we need to be as clear and consise as possible with our content and transfer standards to aid this. Documents can have different audiences, e.g. developer technical specifications versus content terms and definitions.

### Outcomes

*   Generate a wiki document containing the full set of terms and their definitions with any associated controlled vocabulary or informational material. This might be similar to the [AVH data](http://hiscom.rbg.vic.gov.au/wiki/AVH_data) page, but covering all terms needed/used by Australian herbaria.
*   Rework the definitions of any elements to tighten their usage, including placing controlled vocabularies and other restrictions on fields if necessary.

## Supporting AVH/ALA

Deliver Darwin Core to AVH/ALA at least as well as HISPID 5/ABCD, thus avoiding a conversion to Darwin Core prior to delivery to AVH/ALA.

  _There is actually very little transformation between ABCD and Darwin Core. I think there are only two elements – identificationQualifier and typeStatus – that need to be transformed; the rest is direct mapping. One issue is the flattening out of ABCD that needs to happen. Another is different implementations of ABCD by different providers._

The [AVH data](http://hiscom.rbg.vic.gov.au/wiki/AVH_data) entry in the HISCOM wiki describes the way the AVH aggregation software (written by Niels) works. The [AVH MoU Technical Addendum](http://hiscom.rbg.vic.gov.au/wiki/AVH_MoU_Technical_Addendum) details the (CHAH accepted) expectation of any single data provider.

### Outcomes?

## Bolstering Herbarium use of HISPID 5/ABCD

We still need HISPID as an exchange standard. Aside from updating the standard itself, we also need to find ways to better support its use.

### Outcomes

#### Tools

We could define tools that might be used to help herbaria move to HISPID 5/ABCD? A tool that can take HISPID 3/4 documents and convert these to HISPID 5/ABCD and/or Darwin Core might be a good thing to attempt. This would help herbaria to transition off HISPID 3/4.

  _I pretty much have that already, but they are loose scripts scattered here and there. The HO and BRI data was converted from HSIPID 3 to ABCD (or BioCASe tables used to create ABCD)_

#### Documentation

Rework HISPID 5 as necessary to update it for current needs and update the associated documentation.

  _I would actually like to have a real ABCD implementation. HISPID 5 won't validate against ABCD, as it is in the wrong name space. MEL (and MELU, LTB and HO) is currently using a CMF file that contains ABCD, the HISPID 5 extension and the Darwin Core elements that we need and for which there are no equivalents in ABCD. XML produced by these providers validates against ABCD, HISPID 5 extension and Darwin Core. If we are going to keep any elements from the HISPID 5 extension, I would like the HISPID XML schema to be set up like the Darwin Core XML schema, so that HISPID elements can be added to ABCD as well as Darwin Core XML._

#### Publishing

Ensure the schema is available at the expected public namespace URL to allow validation to occur in instance documents. The current schema namespace is <code>http://www.chah.org.au/schemas/hispid/5</code>, which is redirected to the Google Code repository’s trunk source code. This works, but may need to be revised, especially if we decide to move the source code to Github.

## Specimen Images

What to do regarding specimen images? Audubon Core is a likely international standard.

## Standards Maintenance

Document how we (those maintaining our standards) will do this, both in developing the stardards as well as telling others how to get involved.
