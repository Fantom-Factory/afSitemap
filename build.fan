using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "A library for creating XML sitemaps for your Bed App"
		version = Version("0.0.13")

		meta = [
			"proj.name"		: "Sitemap",
			"afIoc.module"	: "afSitemap::SitemapModule",
			"internal"		: "true",
			"tags"			: "web",
			"repo.private"	: "true"
		]

		depends = [
			"sys 1.0",
			"xml 1.0",
			
			// ---- Core ------------------------
			"afIoc 1.6.4+", 
			"afIocConfig 1.0.8+",
			
			// ---- Web -------------------------
			"afBedSheet 1.3.8+",
			"afEfanXtra 1.1.6+",
			"afPillow 1.0.10+",
			
			// ---- Test ------------------------
			"afBounce 1.0.4+",
			"afButter 1.0.0+",
			"afSizzle 1.0.0+"
		]

		srcDirs = [`test/`, `fan/`, `fan/public/`, `fan/internal/`]
		resDirs = [,]
	}
	
	override Void compile() {
		// remove test pods from final build
		testPods := "afBounce afButter afSizzle".split
		depends = depends.exclude { testPods.contains(it.split.first) }
		super.compile
	}
}
