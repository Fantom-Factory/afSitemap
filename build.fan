using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "A library for creating XML sitemaps for your Bed Application"
		version = Version("1.0.0")

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
			"afIoc       2.0.0  - 2.0", 
			"afIocConfig 1.0.16 - 1.0",
			
			// ---- Web -------------------------
			"afBedSheet 1.3.16 - 1.3",
			"afEfanXtra 1.1.14 - 1.1",
			"afPillow   1.0.20 - 1.0",
			
			// ---- Test ------------------------
			"afBounce 1.0.14 - 1.0",
			"afButter 1.0.2  - 1.0",
			"afSizzle 1.0.0  - 1.0"
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
