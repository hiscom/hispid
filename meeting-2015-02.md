Meeting Agenda, 16–18 February 2015
===================================

## General Items

HISPID should become a list of terms and definitions. It should not define a particular transfer format to avoid the need to define essentially the same terms at least once per transfer format. For exchange of herbarium data, HISPID 5 remains a useful transfer standard as it provides better atomisation than HISPID 3 and Darwin Core. Darwin Core is better for AVH/ALA content because that is the standard they use and a herbarium needs access to more terms than AVH.

### Outcomes

*   Generate a wiki document containing the full set of terms and their definitions with any associated controlled vocabulary or informational material. This might be similar to the [AVH data](http://hiscom.rbg.vic.gov.au/wiki/AVH_data) page, but covering all terms needed/used by Australian herbaria.
*   Rework the definitions of any elements to tighten their usage, including placing controlled vocabularies and other restrictions on fields if necessary.

## Supporting AVH/ALA

Deliver Darwin Core to AVH/ALA at least as well as HISPID 5/ABCD, thus avoiding a conversion to Darwin Core prior to delivery to AVH/ALA.

The [AVH data](http://hiscom.rbg.vic.gov.au/wiki/AVH_data) entry in the HISCOM wiki describes the way the AVH aggregation software (written by Niels) works. The [AVH MoU Technical Addendum](http://hiscom.rbg.vic.gov.au/wiki/AVH_MoU_Technical_Addendum) details the (CHAH accepted) expectation of any single data provider.

### Outcomes?

## Bolstering Herbarium use of HISPID 5/ABCD

We still need HISPID as a transfer standard. Aside from updating the standard itself, we also need to find ways to better support its use.

### Outcomes

#### Tools

We could define tools that might be used to help herbaria move to HISPID 5/ABCD? A tool that can take HISPID 3/4 documents and convert these to HISPID 5/ABCD and/or Darwin Core might be a good thing to attempt. This would help herbaria to transition off HISPID 3/4.

#### Documentation

Rework HISPID 5 as necessary to update it for current needs and update the associated documentation.

#### Publishing

Ensure the schema is available at the expected public namespace URL to allow validation to occur in instance documents. The current schema namespace is <code>http://www.chah.org.au/schemas/hispid/5</code>, which is redirected to the Google Code repository’s trunk source code. This works, but may need to be revised, especially if we decide to move the source code to Github.

## Specimen Images

What to do regarding specimen images? Audubon Core is a likely international standard.

## Standards Maintenance

Document how we (those maintaining our standards) will do this.