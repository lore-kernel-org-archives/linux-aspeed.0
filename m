From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 16 Jan 2024 19:03:27 -0000
Subject: [PATCH v4 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
In-Reply-To: <20240116183734.3944028-4-ninad@linux.ibm.com>
Message-ID: <20240116190321.GA102334@bhelgaas>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 16, 2024 at 12:37:34PM -0600, Ninad Palsule wrote:
> From: Andrew Geissler <geissonator@yahoo.com>
> 
> Add a device tree for IBM system1 BMC board. It uses AST2600 SOC.
> - Added base board

s/Added/Add/ to match first sentence.

> - Added i2c devices and muxes.
> - Added different voltage regulators.
> - Added GPIO pin assignements, GPIO expansion devices
> - Added LED brinker devices

"brinker"?  "blinker" maybe (no idea what it actually is).

> - Added Fan controllers

s/Fan/fan/

> - Added EEPROM/VPD
> - Added Power supplies

s/Power/power/

> - Added Humidity, pressure and temperature sensors.

s/Humidity/humidity/

> - Added Trusted platform module(TPM) chip.

s/Trusted platform module/Trusted Platform Module /

> Tested:
>     This board is tested using the simics simulator.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>

Your sign-off should be last since you are sending the series.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.6#n396
