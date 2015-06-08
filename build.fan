using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "A library for creating XML sitemaps for your Bed Application"
		version = Version("1.0.1")

		meta = [
			"proj.name"		: "Sitemap",
			"afIoc.module"	: "afSitemap::SitemapModule",
			"repo.internal"	: "true",
			"repo.tags"		: "web",
			"repo.public"	: "false"
		]

		depends = [
			"sys 1.0",
			"xml 1.0",
			
			// ---- Core ------------------------
			"afIoc       2.0.0  - 2.0", 
			
			// ---- Web -------------------------
			"afBedSheet  1.4.0  - 1.4",
			"afEfanXtra  1.1.16 - 1.1",
			"afPillow    1.0.22 - 1.0",
			
			// ---- Test ------------------------
			"afBounce    1.0.18 - 1.0",
			"afSizzle    1.0.2  - 1.0"
		]

		srcDirs = [`test/`, `fan/`, `fan/public/`, `fan/internal/`]
		resDirs = [`doc/`]
	}
	
	override Void compile() {
		// remove test pods from final build
		testPods := "afBounce afButter afSizzle".split
		depends = depends.exclude { testPods.contains(it.split.first) }
		super.compile
	}
}
