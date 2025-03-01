const os = require('os');
const { execSync } = require('child_process');

const MIN_CPU_SPEED = 1.5; // GHz
const RECOMMENDED_CPU_SPEED = 2.0;
const MIN_RAM = 4 * 1024 * 1024 * 1024; // 4 GB in bytes
const RECOMMENDED_RAM = 8 * 1024 * 1024 * 1024; // 8 GB in bytes
const MIN_DISK_SPACE = 10 * 1024 * 1024 * 1024; // 10 GB in bytes
const RECOMMENDED_DISK_SPACE = 20 * 1024 * 1024 * 1024; // 20 GB in bytes

function getCPUSpeed() {
    const cpus = os.cpus();
    return cpus.length > 0 ? cpus[0].speed / 1000 : 0; // Convert MHz to GHz
}

function getTotalRAM() {
    return os.totalmem();
}

function getFreeDiskSpace() {
    try {
        let command, output;
        switch (os.platform()) {
            case 'win32':
                command = 'wmic logicaldisk where DeviceID="C:" get FreeSpace';
                output = execSync(command).toString().split('\n');
                return parseInt(output[1].trim(), 10);
            case 'darwin': // macOS
                command = "df -k / | tail -1 | awk '{print $4}'";
                output = execSync(command).toString().trim();
                return parseInt(output, 10) * 1024; // Convert KB to Bytes
            case 'linux':
                command = 'df -k --output=avail / | tail -1';
                output = execSync(command).toString().trim();
                return parseInt(output, 10) * 1024; // Convert KB to Bytes
            default:
                return 0;
        }
    } catch (error) {
        console.error("Error getting disk space:", error);
        return 0;
    }
}

function checkSystemRequirements() {
    const cpuSpeed = getCPUSpeed();
    const totalRAM = getTotalRAM();
    const freeDiskSpace = getFreeDiskSpace();

    console.log(`CPU Speed: ${cpuSpeed} GHz`);
    console.log(`Total RAM: ${(totalRAM / (1024 * 1024 * 1024)).toFixed(2)} GB`);
    console.log(`Free Disk Space: ${(freeDiskSpace / (1024 * 1024 * 1024)).toFixed(2)} GB`);

    console.log('\nSystem Requirements Check:');
    console.log(`- CPU: ${cpuSpeed >= MIN_CPU_SPEED ? '✅ Meets' : '❌ Below'} minimum (${cpuSpeed} GHz)`);
    console.log(`  - Recommended: ${cpuSpeed >= RECOMMENDED_CPU_SPEED ? '✅ Meets' : '⚠️ Below'} recommended (${cpuSpeed} GHz)`);
    console.log(`- RAM: ${totalRAM >= MIN_RAM ? '✅ Meets' : '❌ Below'} minimum (${(totalRAM / (1024 * 1024 * 1024)).toFixed(2)} GB)`);
    console.log(`  - Recommended: ${totalRAM >= RECOMMENDED_RAM ? '✅ Meets' : '⚠️ Below'} recommended (${(totalRAM / (1024 * 1024 * 1024)).toFixed(2)} GB)`);
    console.log(`- Disk Space: ${freeDiskSpace >= MIN_DISK_SPACE ? '✅ Meets' : '❌ Below'} minimum (${(freeDiskSpace / (1024 * 1024 * 1024)).toFixed(2)} GB)`);
    console.log(`  - Recommended: ${freeDiskSpace >= RECOMMENDED_DISK_SPACE ? '✅ Meets' : '⚠️ Below'} recommended (${(freeDiskSpace / (1024 * 1024 * 1024)).toFixed(2)} GB)`);
}

checkSystemRequirements();