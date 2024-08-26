From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 26 Aug 2024 09:51:10 +0200
Subject: [PATCH 0/9] AT24 EEPROM MTD Support
In-Reply-To: <Zsi3s9XithGEROwX@smile.fi.intel.com>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
 <Zsi3s9XithGEROwX@smile.fi.intel.com>
Message-ID: <20240826075110.u3cxc6dootou72eq@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andy,

On 24-08-23, Andy Shevchenko wrote:
> On Mon, Jul 01, 2024 at 03:53:39PM +0200, Marco Felsch wrote:
> > This series adds the intial support to handle EEPROMs via the MTD layer
> > as well. This allow the user-space to have separate paritions since
> > EEPROMs can become quite large nowadays.
> > 
> > With this patchset applied EEPROMs can be accessed via:
> >   - legacy 'eeprom' device
> >   - nvmem device
> >   - mtd device(s)
> > 
> > The patchset targets only the AT24 (I2C) EEPROMs since I have no access
> > to AT25 (SPI) EEPROMs nor to one of the other misc/eeprom/* devices.
> > 
> > Note: I'm not familiar with Kconfig symbol migration so I don't know if
> > the last patch is required at the moment. Please be notified that the
> > list of recipients is quite large due to the defconfig changes.
> 
> FWIW, I think that MTD is *not* the place for EEPROMs.
> 
> Yeah, we have the driver spread over the kernel for EEPROMs (mostly due to
> historical reasons and absence an umbrella subsystem for them), but it's not
> the reason to hack them into something which is not quite suitable.

Thank you for you input. There are two things to mention:
 1st) I send a RFC patch and asked for feedback and all I got was: looks
      okay, please send a proper patch [1] which I did.
 2nd) I don't see the hacky part in this patchset.

Anyway the customer doesn't need the nvmem-partitions anymore and
therefore this patchset can be seen as obsolote.

Regards,
  Marco

[1] https://lore.kernel.org/lkml/20231201144441.imk7rrjnv2dugo7p at pengutronix.de/T/#m1e0e5778448971b50a883f62bd95622f6422b9a2

> 
> If NVMEM needs to be updated and may cover these cases after all (and do not
> forget about *small* size EEPROMs that most likely appear on the devices with
> limited amount of resources!) in a reasonable size and performance, why not?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
