Started by user SaadAit
Checking out git https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git into /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline@script/cbe398852023f564e2b92a873eede6ac1feb8c1d9fb80543b1097ecc240f9d6a to read jenkinsfile
The recommended git tool is: git
No credentials specified
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline@script/cbe398852023f564e2b92a873eede6ac1feb8c1d9fb80543b1097ecc240f9d6a/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git # timeout=10
Fetching upstream changes from https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git
 > git --version # timeout=10
 > git --version # 'git version 2.47.3'
 > git fetch --tags --force --progress -- https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 552b411b940090401312774db7e2326b789c99d6 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 552b411b940090401312774db7e2326b789c99d6 # timeout=10
Commit message: "gd"
 > git rev-list --no-walk 6f210eec131912bd82a2795cb6b04937874c97c2 # timeout=10
org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
WorkflowScript: 236: illegal string body character after dollar sign;
   solution: either escape a literal dollar sign "\$5" or bracket the value expression "${5}" @ line 236, column 29.
                               sh """
                               ^

1 error

	at org.codehaus.groovy.control.ErrorCollector.failIfErrors(ErrorCollector.java:309)
	at org.codehaus.groovy.control.ErrorCollector.addFatalError(ErrorCollector.java:149)
	at org.codehaus.groovy.control.ErrorCollector.addError(ErrorCollector.java:119)
	at org.codehaus.groovy.control.ErrorCollector.addError(ErrorCollector.java:131)
	at org.codehaus.groovy.control.SourceUnit.addError(SourceUnit.java:349)
	at org.codehaus.groovy.antlr.AntlrParserPlugin.transformCSTIntoAST(AntlrParserPlugin.java:220)
	at org.codehaus.groovy.antlr.AntlrParserPlugin.parseCST(AntlrParserPlugin.java:191)
	at org.codehaus.groovy.control.SourceUnit.parse(SourceUnit.java:233)
	at org.codehaus.groovy.control.CompilationUnit$1.call(CompilationUnit.java:189)
	at org.codehaus.groovy.control.CompilationUnit.applyToSourceUnits(CompilationUnit.java:966)
	at org.codehaus.groovy.control.CompilationUnit.doPhaseOperation(CompilationUnit.java:626)
	at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:602)
	at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:579)
	at groovy.lang.GroovyClassLoader.doParseClass(GroovyClassLoader.java:323)
	at groovy.lang.GroovyClassLoader.parseClass(GroovyClassLoader.java:293)
	at PluginClassLoader for script-security//org.jenkinsci.plugins.scriptsecurity.sandbox.groovy.GroovySandbox$Scope.parse(GroovySandbox.java:162)
	at PluginClassLoader for workflow-cps//org.jenkinsci.plugins.workflow.cps.CpsGroovyShell.doParse(CpsGroovyShell.java:188)
	at PluginClassLoader for workflow-cps//org.jenkinsci.plugins.workflow.cps.CpsGroovyShell.reparse(CpsGroovyShell.java:173)
	at PluginClassLoader for workflow-cps//org.jenkinsci.plugins.workflow.cps.CpsFlowExecution.parseScript(CpsFlowExecution.java:656)
	at PluginClassLoader for workflow-cps//org.jenkinsci.plugins.workflow.cps.CpsFlowExecution.start(CpsFlowExecution.java:602)
	at PluginClassLoader for workflow-job//org.jenkinsci.plugins.workflow.job.WorkflowRun.run(WorkflowRun.java:341)
	at hudson.model.ResourceController.execute(ResourceController.java:101)
	at hudson.model.Executor.run(Executor.java:460)
Finished: FAILURE