
** Services should implement to return sitemap URLs.
const mixin SitemapSource {
	abstract SitemapUrl[] sitemapUrls()
}

** A simple implementation of `SitemapSource`, use for contributions.
const class SitemapSourceImpl : SitemapSource {
	override const SitemapUrl[] sitemapUrls

	new makeFromSingle(SitemapUrl sitemapUrl) {
		this.sitemapUrls = [sitemapUrl]
	}

	new makeFromList(SitemapUrl[] sitemapUrls) {
		this.sitemapUrls = sitemapUrls
	}
}
