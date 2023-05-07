const jwt = require("jsonwebtoken")

const auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) {
            return res.status(401).json({ message: "No token, authorization denied" }); r
        }
        const verified = jwt.verify(token, "passwordKey")
        if (!verified)
            return res.status(401).json({ message: "Token is not verified" });
        req.user = verified.id
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
}

module.exports = auth;