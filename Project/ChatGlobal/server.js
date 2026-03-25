const express = require('express');
const app = express();
app.use(express.json());

let messages = [];
let idCounter = 0;

app.get('/messages', (req, res) => {
    const lang = req.query.lang || 'ALL';
    const after = parseInt(req.query.after) || 0;
    let msgs = messages.filter(m => m.id > after);
    if (lang !== 'ALL') msgs = msgs.filter(m => m.lang === lang || m.lang === 'ALL');
    res.json(msgs);
});

app.post('/send', (req, res) => {
    const { user, message, lang } = req.body;
    if (!user || !message) return res.status(400).json({error:'missing'});
    const msg = { id: ++idCounter, user, message, lang: lang||'ALL', time: Date.now() };
    messages.push(msg);
    if (messages.length > 200) messages.shift();
    res.json({ ok: true, id: msg.id });
});

app.listen(process.env.PORT || 3000, () => console.log('ChatGlobal server running!'));
