const {test, expect} = require("@playwright/test");

// test if a user can add a task
test("user can add a tast", async ({page}) => {
    await page.goto("http://127.0.0.1:5500/Automated%20Testing/05-Automated-Testing-Lab-Resources/to-do-app/index.html");
    await page.fill("#task-input", "Test Task");
    await page.click("#add-task");
    const taskText = await page.textContent(".task");
    expect(taskText).toContain("Test Task");
});


// test if a user can delete a task
test("user can delete a task", async ({page}) => {
    await page.goto("http://127.0.0.1:5500/Automated%20Testing/05-Automated-Testing-Lab-Resources/to-do-app/index.html");
    await page.fill("#task-input", "Test Task");
    await page.click("#add-task");
    await page.click(".task .delete-task");
    const tasks = await page.$$eval(".task",
        tasks => tasks.map(task => task.textContent));
    expect(tasks).not.toContain("Test Task");
})

// test if a user can mark a task as complete
test("user can mark a task as complete", async ({page}) => {
    await page.goto("http://127.0.0.1:5500/Automated%20Testing/05-Automated-Testing-Lab-Resources/to-do-app/index.html");
    await page.fill("#task-input", "Test Task");
    await page.click("#add-task");

    await page.click(".task .task-complete");
    const completedTask = await page.$(".task.completed");
    expect(completedTask).not.toBeNull();
})

// test if a user can filter tasks
test("user can filter tasks", async ({page}) => {
    await page.goto("http://127.0.0.1:5500/Automated%20Testing/05-Automated-Testing-Lab-Resources/to-do-app/index.html");
    await page.fill("#task-input", "Test Task");
    await page.click("#add-task");
    await page.click(".task .task-complete");
    await page.selectOption("#filter", 'Completed');
    const incompleteTask = await page.$(".task:not(.completed)");
    expect(incompleteTask).toBeNull();
})