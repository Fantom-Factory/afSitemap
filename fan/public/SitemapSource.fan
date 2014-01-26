
const mixin SitemapSource {

	abstract SitemapUrl[] sitemapUrls()

}

const class SitemapSourceImpl : SitemapSource {
	override const SitemapUrl[] sitemapUrls

	new make(SitemapUrl[] sitemapUrls) {
		this.sitemapUrls = sitemapUrls
	}
}
