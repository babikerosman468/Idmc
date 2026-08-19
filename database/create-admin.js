const bcrypt = require("bcryptjs");

const {
    getDatabase,
    saveDatabase
} = require("./db");


async function createAdmin() {


    const db = await getDatabase();


    const password =
        bcrypt.hashSync(
            "admin123",
            10
        );


    db.run(

`
INSERT INTO users

(username, password, role)

VALUES (?, ?, ?)

`,

[
"admin",
password,
"admin"
]

);


    saveDatabase();


    console.log(
        "Admin user created"
    );

}


createAdmin();
