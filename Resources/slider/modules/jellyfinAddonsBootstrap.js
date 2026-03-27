/*
 * Jellyfin Addons bootstrap for File Transformation injection.
 * Loads addon modules and calls known init functions when available.
 */

async function safeCall(modPromise, exportName) {
    try {
        const mod = await modPromise;
        const fn = mod && mod[exportName];
        if (typeof fn === "function") {
            await fn();
        }
    } catch (err) {
        // Keep startup resilient if one addon module fails.
        console.error("[jellyfin-addons] bootstrap step failed:", exportName, err);
    }
}

async function bootstrapJellyfinAddons() {
    await Promise.all([
        safeCall(import("./pauseModul.js"), "setupPauseScreen"),
        safeCall(import("./profileChooser.js"), "initProfileChooser"),
        safeCall(import("./hoverTrailerModal.js"), "setupHoverForAllItems"),
        safeCall(import("./avatarPicker.js"), "initUserProfileAvatarPicker"),
        safeCall(import("./userAvatar.js"), "initAvatarSystem"),
        safeCall(import("./studioHubs.js"), "ensureStudioHubsMounted")
    ]);
}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", bootstrapJellyfinAddons, { once: true });
} else {
    bootstrapJellyfinAddons();
}
