using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "(Internal) A library for creating XML sitemaps for your Bed App"
		version = Version("0.0.1")

		meta	= [
			"org.name"		: "Alien-Factory",
			"org.uri"		: "http://www.alienfactory.co.uk/",
			"vcs.uri"		: "https://bitbucket.org/Alien-Factory/afsitemap",
			"proj.name"		: "Sitemap",
			"license.name"	: "BSD 2-Clause License",	
			"repo.private"	: "true",

			"afIoc.module"	: "afSitemap::SitemapModule"
		]

		depends = [
			"sys 1.0",
			"xml 1.0",
			
			"afIoc 1.5.2+", 
			"afIocConfig 1.0.2+", 
			"afBedSheet 1.3.0+",
			"afEfanXtra 1.0.8+",
			"afPillow 0+"
		]
		
		srcDirs = [`test/`, `fan/`, `fan/public/`, `fan/internal/`]
		resDirs = [`doc/`]

		docApi = true
		docSrc = true
	}
}
