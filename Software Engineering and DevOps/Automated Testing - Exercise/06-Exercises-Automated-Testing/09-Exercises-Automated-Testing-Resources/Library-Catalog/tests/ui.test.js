const {test, expect} = require("@playwright/test");

test('Verify "All Books" link is visible', async ({page}) => {
    await page.goto('http://localhost:3000');
    await page.waitForSelector('nav.navbar');
    const allBookLink = await page.$('a[href="/catalog"]');
    const isLinkVisible = await allBookLink.isVisible();
    expect(isLinkVisible).toBe(true);
})

test('Verify "Login" Button is visible', async ({page}) => {
    await page.goto('http://localhost:3000');
    await page.waitForSelector('nav.navbar');
    const loginButton = await page.$('a[href="/login"]');
    const isLoginButtonVisible = await loginButton.isVisible();
    expect(isLoginButtonVisible).toBe(true);
})

test('Verify "Register" Button is visible', async ({page}) => {
    await page.goto('http://localhost:3000');
    await page.waitForSelector('nav.navbar');
    const registerButton = await page.$('a[href="/register"]');
    const isLRegisterButtonVisible = await registerButton.isVisible();
    expect(isLRegisterButtonVisible).toBe(true);
})

test('Verify "All Books" link is visible after user login', async ({page}) => {
    await page.goto('http://localhost:3000/login');
    await page.fill('input[name="email"]', "peter@abv.bg");
    await page.fill('input[name="password"]', "123456");
    await page.click('input[type="submit"]');
    const allBookLink = await page.$('a[href="/catalog"]');
    const isAllBooksLinkVisible = await allBookLink.isVisible();
    expect(isAllBooksLinkVisible).toBe(true);

})

