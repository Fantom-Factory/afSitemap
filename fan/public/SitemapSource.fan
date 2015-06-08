
** Implement to define a source of [Sitemap URLs]`SitemapUrl`. 
** Pillow pages and services can implement this and be auto detected.
const mixin SitemapSource {
	abstract SitemapUrl[] sitemapUrls()
}

** Place on Pillow pages to remove them from the Sitemap list.
const mixin SitemapExempt : SitemapSource {
	** Returns an empty list
	override SitemapUrl[] sitemapUrls() {
		SitemapUrl#.emptyList
	}
}

** A simple implementation of `SitemapSource` to be used in service contributions.
** 
**   syntax: fantom
** 
**   @Contribute { serviceType=SitemapPage# }
**   internal static Void contributeSitemapPage(Configuration config) {
**      url := SitemapUrl(`/wotever`) { ... }
**      config.add(SitemapSourceImpl(url))
**   }
const class SitemapSourceImpl : SitemapSource {
	override const SitemapUrl[] sitemapUrls

	new makeFromSingle(SitemapUrl sitemapUrl) {
		this.sitemapUrls = [sitemapUrl]
	}

	new makeFromList(SitemapUrl[] sitemapUrls) {
		this.sitemapUrls = sitemapUrls
	}
}
