#Sitemap v1.0.0
---
[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](http://fantom.org/)
[![pod: v1.0.0](http://img.shields.io/badge/pod-v1.0.0-yellow.svg)](http://www.fantomfactory.org/pods/afSitemap)
![Licence: MIT](http://img.shields.io/badge/licence-MIT-blue.svg)

## Overview

*Sitemap is a support library that aids Alien-Factory in the development of other libraries, frameworks and applications. Though you are welcome to use it, you may find features are missing and the documentation incomplete.*

`Sitemap` is a library that creates an [XML sitemap](http://www.sitemaps.org/) for your [Bed App](http://www.fantomfactory.org/pods/afBedSheet).

## Install

Install `Sitemap` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afSitemap

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afSitemap 1.0"]

## Documentation

Full API & fandocs are available on the [Status302 repository](http://repo.status302.com/doc/afSitemap/#overview).

## Usage

The [SitemapUrl](http://repo.status302.com/doc/afSitemap/SitemapUrl.html) object contains the data needed to render an individual [URL](http://www.sitemaps.org/protocol.html) object. These are gathered by `Sitemap` in serveral ways:

### Pillow Pages

URLs from [Pillow](http://www.fantomfactory.org/pods/afPillow) pages are added automatically. The page location is generated using [BedSheet's](http://www.fantomfactory.org/pods/afBedSheet) `host` config value - so ensure this has been set!

[Pillow](http://www.fantomfactory.org/pods/afPillow) pages are ignored if they contain an `@InitRender` method or `@PageContext` fields. Such pages take additional URL parameters of which, obviously, `Sitemap` can not determine valid values for. These pages should implement [SitemapSource](http://repo.status302.com/doc/afSitemap/SitemapSource.html) and return a list of valid [SitemapUrls](http://repo.status302.com/doc/afSitemap/SitemapUrl.html).

If you don't wish a [Pillow](http://www.fantomfactory.org/pods/afPillow) page to be scanned or included, let it implement [SitemapExempt](http://repo.status302.com/doc/afSitemap/SitemapExempt.html).

Or you can disable all Pillow Pages by removing the `SitemapPage` contribution:

    @Contribute { serviceType=SitemapPage# }
    static Void contributeSitemapPage(Configuration config) {
        config.remove("afSitemap.fromPillowPages")
    }

### IoC Services

The [IoC](http://www.fantomfactory.org/pods/afIoc) service registry is scanned for services that implement [SitemapSource](http://repo.status302.com/doc/afSitemap/SitemapSource.html). Any service that does is called upon to generate [SitemapUrls](http://repo.status302.com/doc/afSitemap/SitemapUrl.html).

Disable all service scanning by removing the `SitemapPage` contribution:

    @Contribute { serviceType=SitemapPage# }
    static Void contributeSitemapPage(Configuration config) {
        config.remove("afSitemap.fromServices")
    }

### IoC Contribution

You may also manually contribute [SitemapSource](http://repo.status302.com/doc/afSitemap/SitemapSource.html) objects to the [SitemapPage](http://repo.status302.com/doc/afSitemap/SitemapPage.html) service:

```
@Contribute { serviceType=SitemapPage# }
internal static Void contributeSitemapPage(Configuration config) {
    url := SitemapUrl(`/wotever`) { ... }
    config.add(SitemapSourceImpl(url))
}
```

