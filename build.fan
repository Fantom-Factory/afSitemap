using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "(Internal) A library for creating XML sitemaps for your Bed App"
		version = Version("0.0.11")

		meta = [
			"proj.name"		: "Sitemap",
			"afIoc.module"	: "afSitemap::SitemapModule",
			"tags"			: "web",
			"repo.private"	: "true"
		]

		depends = [
			"sys 1.0",
			"xml 1.0",
			
			"afIoc 1.6.0+", 
			"afIocConfig 1.0.4+", 
			"afBedSheet 1.3.6+",
			"afEfanXtra 1.1.0+",
			"afPillow 1.0.6+",
			
			"afBounce 1.0.0+",
			"afButter 0.0.6+",
			"afSizzle 1.0.0+"
		]

		srcDirs = [`test/`, `fan/`, `fan/public/`, `fan/internal/`]
		resDirs = [,]

		docApi = true
		docSrc = true
	}
}
