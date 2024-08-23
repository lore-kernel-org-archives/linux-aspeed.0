From: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Fri, 23 Aug 2024 19:24:19 +0300
Subject: [PATCH 0/9] AT24 EEPROM MTD Support
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
Message-ID: <Zsi3s9XithGEROwX@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 01, 2024 at 03:53:39PM +0200, Marco Felsch wrote:
> This series adds the intial support to handle EEPROMs via the MTD layer
> as well. This allow the user-space to have separate paritions since
> EEPROMs can become quite large nowadays.
> 
> With this patchset applied EEPROMs can be accessed via:
>   - legacy 'eeprom' device
>   - nvmem device
>   - mtd device(s)
> 
> The patchset targets only the AT24 (I2C) EEPROMs since I have no access
> to AT25 (SPI) EEPROMs nor to one of the other misc/eeprom/* devices.
> 
> Note: I'm not familiar with Kconfig symbol migration so I don't know if
> the last patch is required at the moment. Please be notified that the
> list of recipients is quite large due to the defconfig changes.

FWIW, I think that MTD is *not* the place for EEPROMs.

Yeah, we have the driver spread over the kernel for EEPROMs (mostly due to
historical reasons and absence an umbrella subsystem for them), but it's not
the reason to hack them into something which is not quite suitable.

If NVMEM needs to be updated and may cover these cases after all (and do not
forget about *small* size EEPROMs that most likely appear on the devices with
limited amount of resources!) in a reasonable size and performance, why not?

-- 
With Best Regards,
Andy Shevchenko


