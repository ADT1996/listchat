const generateToken = function() {
     const chars = '1qaz2wsx3edc4rfv5tgb6yhn7ujm8ik9ol0p1QAZ2WSX3EDC4RFV5TGB6YHN7UJM8IK9OL0P';
     const tokenLength = 64;
     let token = '';
     
     for(let i = 0; i < tokenLength; i++) {
          const char = chars.charAt(Math.random() * chars.length);
          token += char;
     }
     return token;
}

const generateCertKey = function() {
     const chars = '1qaz(2wsx`3edc4rfv@5tg$b6.yhn%7_uj/m8i^k,9o<l0&p1QA>Z2W}SX3E{DC4RFV;5TG:B6=YHN7-UJM8)IK9O*L0P';
     //key must be a multiplie of 16 bytes
     const certKeyLength = 128;
     let certKey = '';
     
     for(let i = 0; i < certKeyLength; i++) {
          const char = chars.charAt(Math.random() * chars.length);
          certKey += char;
     }
     return certKey;
}

module.exports = {
     generateToken: generateToken,
     generateCertKey: generateCertKey
}