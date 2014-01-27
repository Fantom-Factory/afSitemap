
** Implement to define a source of [Sitemap URLs]`SitemapUrl`. 
** Pillow pages and services can implement this and be auto detected.
const mixin SitemapSource {
	abstract SitemapUrl[] sitemapUrls()
}

** A simple implementation of `SitemapSource` to be uses in service contributions.
const class SitemapSourceImpl : SitemapSource {
	override const SitemapUrl[] sitemapUrls

	new makeFromSingle(SitemapUrl sitemapUrl) {
		this.sitemapUrls = [sitemapUrl]
	}

	new makeFromList(SitemapUrl[] sitemapUrls) {
		this.sitemapUrls = sitemapUrls
	}
}
