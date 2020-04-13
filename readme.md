# Sitemap v1.1.2
---

[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](https://fantom-lang.org/)
[![pod: v1.1.2](http://img.shields.io/badge/pod-v1.1.2-yellow.svg)](http://eggbox.fantomfactory.org/pods/afSitemap)
[![Licence: ISC](http://img.shields.io/badge/licence-ISC-blue.svg)](https://choosealicense.com/licenses/isc/)

## <a name="overview"></a>Overview

*Sitemap is a support library that aids Alien-Factory in the development of other libraries, frameworks and applications. Though you are welcome to use it, you may find features are missing and the documentation incomplete.*

`Sitemap` is a library that creates [XML sitemaps](http://www.sitemaps.org/) for your [Bed Apps](http://eggbox.fantomfactory.org/pods/afBedSheet).

## <a name="Install"></a>Install

Install `Sitemap` with the Fantom Pod Manager ( [FPM](http://eggbox.fantomfactory.org/pods/afFpm) ):

    C:\> fpm install afSitemap

Or install `Sitemap` with [fanr](https://fantom.org/doc/docFanr/Tool.html#install):

    C:\> fanr install -r http://eggbox.fantomfactory.org/fanr/ afSitemap

To use in a [Fantom](https://fantom-lang.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afSitemap 1.1"]

## <a name="documentation"></a>Documentation

Full API & fandocs are available on the [Eggbox](http://eggbox.fantomfactory.org/pods/afSitemap/) - the Fantom Pod Repository.

## Usage

The [SitemapUrl](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapUrl) object contains the data needed to render an individual [URL](http://www.sitemaps.org/protocol.html) object. These are gathered by `Sitemap` in serveral ways:

### Pillow Pages

URLs from [Pillow](http://eggbox.fantomfactory.org/pods/afPillow) pages are added automatically. The page location is generated using [BedSheet's](http://eggbox.fantomfactory.org/pods/afBedSheet) `host` config value - so ensure this has been set!

[Pillow](http://eggbox.fantomfactory.org/pods/afPillow) pages are ignored if they contain an `@InitRender` method or `@PageContext` fields. Such pages take additional URL parameters of which, obviously, `Sitemap` can not determine valid values for. These pages should implement [SitemapSource](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapSource) and return a list of valid [SitemapUrls](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapUrl).

If you don't wish a [Pillow](http://eggbox.fantomfactory.org/pods/afPillow) page to be scanned or included, let it implement [SitemapExempt](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapExempt).

Or you can disable all Pillow Pages by removing the `SitemapPage` contribution:

    @Contribute { serviceType=SitemapPage# }
    Void contributeSitemapPage(Configuration config) {
        config.remove("afSitemap.fromPillowPages")
    }

### IoC Services

The [IoC](http://eggbox.fantomfactory.org/pods/afIoc) service registry is scanned for services that implement [SitemapSource](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapSource). Any service that does is called upon to generate [SitemapUrls](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapUrl).

Disable all service scanning by removing the `SitemapPage` contribution:

    @Contribute { serviceType=SitemapPage# }
    Void contributeSitemapPage(Configuration config) {
        config.remove("afSitemap.fromServices")
    }

### IoC Contribution

You may also manually contribute [SitemapSource](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapSource) objects to the [SitemapPage](http://eggbox.fantomfactory.org/pods/afSitemap/api/SitemapPage) service:

    @Contribute { serviceType=SitemapPage# }
    Void contributeSitemapPage(Configuration config) {
        url := SitemapUrl(`/wotever`) { ... }
        config.add(SitemapSourceImpl(url))
    }

