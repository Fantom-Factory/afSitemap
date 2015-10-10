#Sitemap v1.1.0
---
[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](http://fantom.org/)
[![pod: v1.1.0](http://img.shields.io/badge/pod-v1.1.0-yellow.svg)](http://www.fantomfactory.org/pods/afSitemap)
![Licence: MIT](http://img.shields.io/badge/licence-MIT-blue.svg)

## Overview

*Sitemap is a support library that aids Alien-Factory in the development of other libraries, frameworks and applications. Though you are welcome to use it, you may find features are missing and the documentation incomplete.*

`Sitemap` is a library that creates an [XML sitemap](http://www.sitemaps.org/) for your [Bed App](http://pods.fantomfactory.org/pods/afBedSheet).

## Install

Install `Sitemap` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://pods.fantomfactory.org/fanr/ afSitemap

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afSitemap 1.1"]

## Documentation

Full API & fandocs are available on the [Fantom Pod Repository](http://pods.fantomfactory.org/pods/afSitemap/).

## Usage

The [SitemapUrl](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapUrl) object contains the data needed to render an individual [URL](http://www.sitemaps.org/protocol.html) object. These are gathered by `Sitemap` in serveral ways:

### Pillow Pages

URLs from [Pillow](http://pods.fantomfactory.org/pods/afPillow) pages are added automatically. The page location is generated using [BedSheet's](http://pods.fantomfactory.org/pods/afBedSheet) `host` config value - so ensure this has been set!

[Pillow](http://pods.fantomfactory.org/pods/afPillow) pages are ignored if they contain an `@InitRender` method or `@PageContext` fields. Such pages take additional URL parameters of which, obviously, `Sitemap` can not determine valid values for. These pages should implement [SitemapSource](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapSource) and return a list of valid [SitemapUrls](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapUrl).

If you don't wish a [Pillow](http://pods.fantomfactory.org/pods/afPillow) page to be scanned or included, let it implement [SitemapExempt](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapExempt).

Or you can disable all Pillow Pages by removing the `SitemapPage` contribution:

    @Contribute { serviceType=SitemapPage# }
    static Void contributeSitemapPage(Configuration config) {
        config.remove("afSitemap.fromPillowPages")
    }

### IoC Services

The [IoC](http://pods.fantomfactory.org/pods/afIoc) service registry is scanned for services that implement [SitemapSource](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapSource). Any service that does is called upon to generate [SitemapUrls](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapUrl).

Disable all service scanning by removing the `SitemapPage` contribution:

    @Contribute { serviceType=SitemapPage# }
    static Void contributeSitemapPage(Configuration config) {
        config.remove("afSitemap.fromServices")
    }

### IoC Contribution

You may also manually contribute [SitemapSource](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapSource) objects to the [SitemapPage](http://pods.fantomfactory.org/pods/afSitemap/api/SitemapPage) service:

    @Contribute { serviceType=SitemapPage# }
    internal static Void contributeSitemapPage(Configuration config) {
        url := SitemapUrl(`/wotever`) { ... }
        config.add(SitemapSourceImpl(url))
    }

