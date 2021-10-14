const fs = require("fs");
const { GenBase } = require("./genbase");

const activeExts = [
  ["src/sqlite3-crypto.c src/crypto/*.c", "crypto"],
  ["src/sqlite3-ipaddr.c", "ipaddr"],
  ["src/sqlite3-json1.c", "json1"],
  ["src/sqlite3-math.c", "math"],
  ["src/sqlite3-memstat.c", "memstat"],
  ["src/sqlite3-re.c src/re.c", "re"],
  ["src/sqlite3-series.c", "series"],
  ["src/sqlite3-spellfix.c", "spellfix"],
  ["src/sqlite3-stats.c", "stats"],
  ["src/sqlite3-text.c", "text"],
  ["src/sqlite3-unicode.c", "unicode"],
  ["src/sqlite3-vsv.c", "vsv"],
];
/**
 * Keeps Makefile consistent
 *
 * to update run: `node gen/generateMakefile.js`
 */

class Generator extends GenBase {
  run() {
    const makeheader = fs.readFileSync("./gen/makeheader.txt", "utf-8");
    this.push("");
    this.push("");
    this.genLinux();
    this.push("");
    this.genMacos();
    this.push("");
    this.genWindows();
    this.push("");
    this.genWindows32();
    let fullContent = makeheader + this.content;
    fullContent = fullContent.replaceAll("    ", "\t");
    fs.writeFileSync("Makefile", fullContent, "utf-8");
  }

  genLinux() {
    this.push("compile-linux:");
    this.withIndent(() => {
      activeExts.forEach((ext) => {
        this.push(this.genLinuxLine(ext));
      });
    }, 2);
  }

  genMacos() {
    this.push("compile-macos:");
    this.withIndent(() => {
      activeExts.forEach((ext) => {
        this.push(this.genMacosLine(ext));
      });
    }, 2);
  }

  genWindows() {
    this.push("compile-windows:");
    this.withIndent(() => {
      activeExts.forEach((ext) => {
        this.push(this.genWinLine(ext));
      });
    }, 2);
  }

  genWindows32() {
    this.push("compile-windows-32:");
    this.withIndent(() => {
      activeExts.forEach((ext) => {
        this.push(this.genWin32Line(ext));
      });
    }, 2);
  }

  genLinuxLine([files, output]) {
    return `gcc -fPIC -shared ${files} -o dist/${output}.so -lm`;
  }
  genWin32Line([files, output]) {
    return `gcc -shared -I. ${files} -o dist/${output}-win32.dll -lm`;
  }
  genWinLine([files, output]) {
    return `gcc -shared -I. ${files} -o dist/${output}.dll -lm`;
  }
  genMacosLine([files, output]) {
    return `gcc -fPIC -dynamiclib -I src ${files} -o dist/${output}.dylib -lm`;
  }
}

new Generator().run();
