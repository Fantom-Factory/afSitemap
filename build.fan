using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "A library for creating XML sitemaps for your Bed Application"
		version = Version("0.0.15")

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
			"afIoc 1.7.2+", 
			"afIocConfig 1.0.10+",
			
			// ---- Web -------------------------
			"afBedSheet 1.3.12+",
			"afEfanXtra 1.1.8+",
			"afPillow 1.0.14+",
			
			// ---- Test ------------------------
			"afBounce 1.0.10+",
			"afButter 1.0.2+",
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
