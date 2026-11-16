/** Prints a bcrypt hash: npm run hash-password -- "new password" */
import bcrypt from 'bcryptjs';
const pw = process.argv[2];
if (!pw) {
  console.error('Usage: npm run hash-password -- "password"');
  process.exit(1);
}
console.log(await bcrypt.hash(pw, 12));
