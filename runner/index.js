const child_process = require("child_process");
const Diff = require("diff");
const fs = require("fs");
const glob = require("glob");
const path = require("path");
const readlineSync = require("readline-sync");

class Runner {
  interactive = false;
  verbose = false;
  failed = false;
  constructor(opts = {}) {
    if (opts.ci) {
      this.interactive = false;
      this.verbose = true;
    } else {
      this.interactive = true;
      this.verbose = false;
    }

    this.prepare();
  }

  prepare() {
    fs.mkdirSync("test-out", { recursive: true });
  }

  markAsFailed() {
    this.failed = true;
  }
  run() {
    this.runFiles("test/*-test.sql");
  }
  runFiles(pattern) {
    glob(pattern, (err, files) => {
      let totalFiles = files.length;
      let doneCallback = () => {
        totalFiles = totalFiles - 1;
        if (totalFiles == 0) {
          if (this.failed) {
            console.log("FAILED!");
            process.exit(1);
          } else {
            console.log("\nOK!");
            process.exit(0);
          }
        }
      };
      files.forEach((file) => {
        this.runFile(file, doneCallback);
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
  runFile(file, doneCallback) {
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
      this.assertMatch(file, stdout, doneCallback);
    });
  }

  assertMatch(file, content, doneCallback) {
    let fixture = this.assertionFileFor(file);
    fs.readFile(fixture, "utf-8", (err, data) => {
      if (err) {
        console.log(fixture, " does not exist, creating...");
        this.updateAssertion(file, content);
        doneCallback();
        return;
      }

      if (data.trim() != content.trim()) {
        this.markAsFailed();
        console.log(file, ">>> MISMATCH!");
        this.diffFile(file, content.trim(), data.trim());
        this.promptForUpdate(file, content, doneCallback);
        return;
      }
      doneCallback();
    });
  }

  promptForUpdate(file, content, doneCallback) {
    if (!this.interactive) {
      doneCallback();
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
    doneCallback();
  }

  updateAssertion(file, content) {
    let fixture = this.assertionFileFor(file);
    fs.writeFileSync(fixture, content);
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

if (process.argv[2] == "CI") {
  new Runner({ ci: true }).run();
} else {
  new Runner().run();
}
