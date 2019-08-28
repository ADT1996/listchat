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

module.exports = {
     generateToken: generateToken
}