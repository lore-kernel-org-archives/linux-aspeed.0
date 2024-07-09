From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 09 Jul 2024 09:43:24 -0000
Subject: [PATCH 4/9] mtd: devices: add AT24 eeprom support
In-Reply-To: <20240709092214.omr7ccphdzdk7z7j@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
	<20240701-b4-v6-10-topic-usbc-tcpci-v1-4-3fd5f4a193cc@pengutronix.de>
	<07b701a9-7b52-45b7-8dba-1c25d77cbf15@linaro.org>
	<mafs0ikxnykpr.fsf@kernel.org>
	<20240702-congenial-vigilant-boar-aeae44@houat>
	<mafs0ed8byj5z.fsf@kernel.org>
	<20240702-mighty-brilliant-eel-b0d9fa@houat>
	<20240708084440.70186564@xps-13>
	<20240709092214.omr7ccphdzdk7z7j@pengutronix.de>
Message-ID: <20240709114302.3c604ef3@xps-13>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marco,

> > > > >> I also found a thread from 2013 by Maxime Ripard (+Cc) suggesting adding
> > > > >> EEPROMs to MTD [1]. The main purpose would have been unifying the EEPROM
> > > > >> drivers under a single interface. I am not sure what came of it though,
> > > > >> since I can't find any patches that followed up with the proposal.    
> > > > >
> > > > > That discussion led to drivers/nvmem after I started to work on
> > > > > some early prototype, and Srinivas took over that work.    
> > > > 
> > > > So would you say it is better for EEPROM drivers to use nvmem instead of
> > > > moving under MTD?    
> > > 
> > > I thought so at the time, but that was more than 10y ago, and I have
> > > followed neither nvmem nor MTD since so I don't really have an opinion
> > > there.
> > > 
> > > It looks like drivers/misc/eeprom/at24.c has support for nvmem though,
> > > and MTD can be used as an nvmem provider too, so it's not clear to me
> > > why we would want to create yet another variant.
> > > 
> > > But again, you shouldn't really ask me in the first place :)
> > > 
> > > I'm sure Miquel, Srinivas, and surely others, are much more relevant to
> > > answer that question.  
> > 
> > More relevant, I doubt, but just a feeling: EEPROMs have their own
> > subsystem now, NVMEM, which, as Maxime said, was initially written for
> > that very specific case. EEPROMs don't have the complexity of MTD
> > devices, and thus pulling the whole MTD subsystem just for getting
> > partitions seems counter intuitive to me. You can definitely "split"
> > EEPROM devices with NVMEM as well anyway.  
> 
> I asked for feedback on my RFC [1] and all I got was to merge both
> drivers into one and make the driver backward compatible, which I did by
> this commit.

I'm sorry for not bringing this earlier.

> > Overall I think the idea of getting rid of these misc/ drivers is goes
> > into the right direction, but registering directly into NVMEM makes
> > more sense IMO.  
> 
> So you propose to have two places for the partition handling (one for
> MTD and one for NVMEM) instead of one and moving the code into NVMEM
> directly?

Why two places for the partitions handling? Just one, in NVMEM. Also
usually EEPROMs don't require very advanced partitioning schemes,
unlike flashes (which are the most common MTD devices today).

> That doesn't sound right to me either. Also I don't get the
> point why EEPROMs can't be handled by the MTD layer?

They can, but should they? Just compile the two layers and observe
the size difference. MTD is complex and old, carries a lot of history,
and the user interface is also not straightforward because you need to
handle pages, blocks, erases, bitflips, ECC stats, OOB bytes and
positions, two OTP areas... None of that exists in the EEPROM world. So
why would you want to register into MTD and pull a huge subsystem while
there is a much more recent, simpler and way lighter subsystem fitting
much better your device?

> The layer already
> supports devices of type MTD_RAM which are very simple and don't require
> an erase-op at least I don't see one.

MTD_RAM has been there forever, probably for "bad" reasons. BTW there
has been an attempt at removing it which was reverted in _2006_ and then
felt into the cracks:
21c8db9eff95 ("[MTD] Restore MTD_ROM and MTD_RAM types")

Thanks,
Miqu?l
