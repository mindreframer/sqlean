const child_process = require("child_process");
const Diff = require("diff");
const fs = require("fs");
const glob = require("glob");
const path = require("path");
const readlineSync = require("readline-sync");

class Runner {
  // TODO: make detect CI and make not interactive
  interactive = false;
  verbose = false;
  constructor(opts = {}) {
    this.interactive = true;
    this.verbose = false;
    this.prepare();
  }

  prepare() {
    fs.mkdirSync("test-out", { recursive: true });
  }
  run() {
    this.runFiles("test/*-test.sql");
  }
  runFiles(pattern) {
    glob(pattern, (err, files) => {
      files.forEach((file) => {
        this.runFile(file);
      });
    });
  }
  reportStart(file) {
    if (this.verbose) {
      console.log(file);
      return;
    }
    process.stdout.write(".");
  }
  runFile(file) {
    this.reportStart(file);
    child_process.exec(`sqlite3 < ${file}`, (error, stdout, stderr) => {
      if (error) {
        console.log(`error: ${error.message}`);
        return;
      }
      if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
      }
      this.assertMatch(file, stdout);
    });
  }

  assertMatch(file, content) {
    let fixture = this.assertionFileFor(file);
    fs.readFile(fixture, "utf-8", (err, data) => {
      if (err) {
        console.log(fixture, " does not exist, creating...");
        fs.writeFile(fixture, content, (err) => {});
        return;
      }

      if (data.trim() != content.trim()) {
        console.log(file, ">>> MISMATCH!");
        this.diffFile(file, content.trim(), data.trim());
        this.promptForUpdate(file, content);
      }
    });
  }

  promptForUpdate(file, content) {
    if (!this.interactive) {
      return;
    }
    let input = readlineSync.prompt({
      prompt: "Update assertion? (Y/n)  ",
    });
    if (input == "y" || input == "Y" || input == "") {
      console.log("Updating asserting for", file);
      this.updateAssertion(file, content);
    } else {
      console.log("skipping update for", file);
    }
  }

  updateAssertion(file, content) {
    let fixture = this.assertionFileFor(file);
    fs.writeFile(fixture, content, (err) => {});
  }
  assertionFileFor(file) {
    let basefile = path.basename(file).replace(".sql", "");
    return path.join("test-out", basefile + "-out.sql");
  }

  diffFile(file, c1, c2) {
    console.log("");
    let res = Diff.createPatch(file, c1, c2);
    console.log(res);
  }
}

new Runner().run();
