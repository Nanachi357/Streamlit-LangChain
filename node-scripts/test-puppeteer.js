// Import Puppeteer and the Stealth plugin
const puppeteer = require('puppeteer-extra');
const StealthPlugin = require('puppeteer-extra-plugin-stealth');

// Add the Stealth plugin to Puppeteer
puppeteer.use(StealthPlugin());

(async () => {
    try {
        // Launch Puppeteer with Chromium
        const browser = await puppeteer.launch({
            headless: true, // Set to false if you want to see the browser window
            args: ['--no-sandbox', '--disable-setuid-sandbox'] // Required for running in Docker
        });

        // Open a new page
        const page = await browser.newPage();

        // Navigate to a test page
        await page.goto('https://example.com');

        // Extract the page title
        const title = await page.title();
        console.log(`Page Title: ${title}`);

        // Close the browser
        await browser.close();
    } catch (error) {
        console.error('Error running Puppeteer:', error);
    }
})();
