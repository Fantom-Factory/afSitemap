using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "Creates XML sitemaps for BedSheet Applications"
		version = Version("1.1.1")

		meta = [
			"proj.name"		: "Sitemap",
			"afIoc.module"	: "afSitemap::SitemapModule",
			"repo.internal"	: "true",
			"repo.tags"		: "web",
			"repo.public"	: "false"
		]

		index = [
			"afIoc.module"	: "afSitemap::SitemapModule" 
		]

		depends = [
			"sys 1.0.68 - 1.0",
			"xml 1.0.68 - 1.0",
			
			// ---- Core ------------------------
			"afIoc       3.0.0 - 3.0", 
			
			// ---- Web -------------------------
			"afBedSheet  1.5.0 - 1.5",
			"afEfanXtra  1.2.0 - 1.2",
			"afPillow    1.1.0 - 1.1",
			
			// ---- Test ------------------------
			"afBounce    1.1.0 - 1.1",
			"afSizzle    1.0.2 - 1.0"
		]

		srcDirs = [`fan/`, `fan/internal/`, `fan/public/`, `test/`]
		resDirs = [`doc/`]

		meta["afBuild.testPods"]	= "afBounce afSizzle"
	}
}
