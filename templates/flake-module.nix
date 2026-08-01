_:

{
  flake.templates = {
    java-maven = {
      path = ./java-maven;
      description = "A Java and Maven project";
    };
    typst-report = {
      path = ./typst-report;
      description = "A report written in Typst";
    };
  };
}
