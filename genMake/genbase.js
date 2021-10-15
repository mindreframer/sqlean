/**
 * Generator base class
 * - provides basic functions to help with code generation
 */

class GenBase {
  lines = [];
  prefix = "";
  indentLevel = 0;

  get content() {
    return this.lines.join("\n");
  }

  push(line) {
    this.lines.push(this.prefix + line);
  }

  indentUp(amount = 1) {
    this.indentLevel += amount;
    this.setPrefix();
  }

  indentDown(amount = 1) {
    this.indentLevel -= amount;
    this.setPrefix();
  }

  setPrefix() {
    this.prefix = Array(this.indentLevel).fill("  ").join("");
  }

  withIndent(func, amount = 1) {
    this.indentUp(amount);
    func();
    this.indentDown(amount);
  }
}
module.exports = {
  GenBase,
};
