From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Mon, 08 Jul 2024 07:05:15 -0000
Subject: [PATCH 4/9] mtd: devices: add AT24 eeprom support
In-Reply-To: <20240702-mighty-brilliant-eel-b0d9fa@houat>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
	<20240701-b4-v6-10-topic-usbc-tcpci-v1-4-3fd5f4a193cc@pengutronix.de>
	<07b701a9-7b52-45b7-8dba-1c25d77cbf15@linaro.org>
	<mafs0ikxnykpr.fsf@kernel.org>
	<20240702-congenial-vigilant-boar-aeae44@houat>
	<mafs0ed8byj5z.fsf@kernel.org>
	<20240702-mighty-brilliant-eel-b0d9fa@houat>
Message-ID: <20240708084440.70186564@xps-13>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

> > >> >> Port the current misc/eeprom/at24.c driver to the MTD framework since
> > >> >> EEPROMs are memory-technology devices and the framework already supports  
> > >> >
> > >> > I was under the impression that MTD devices are tightly coupled by erase
> > >> > blocks. But then we see MTD_NO_ERASE, so what are MTD devices after all?  
> > >> 
> > >> I was curious as well so I did some digging.
> > >>   
> > [...]  
> > >> 
> > >> I also found a thread from 2013 by Maxime Ripard (+Cc) suggesting adding
> > >> EEPROMs to MTD [1]. The main purpose would have been unifying the EEPROM
> > >> drivers under a single interface. I am not sure what came of it though,
> > >> since I can't find any patches that followed up with the proposal.  
> > >
> > > That discussion led to drivers/nvmem after I started to work on
> > > some early prototype, and Srinivas took over that work.  
> > 
> > So would you say it is better for EEPROM drivers to use nvmem instead of
> > moving under MTD?  
> 
> I thought so at the time, but that was more than 10y ago, and I have
> followed neither nvmem nor MTD since so I don't really have an opinion
> there.
> 
> It looks like drivers/misc/eeprom/at24.c has support for nvmem though,
> and MTD can be used as an nvmem provider too, so it's not clear to me
> why we would want to create yet another variant.
> 
> But again, you shouldn't really ask me in the first place :)
> 
> I'm sure Miquel, Srinivas, and surely others, are much more relevant to
> answer that question.

More relevant, I doubt, but just a feeling: EEPROMs have their own
subsystem now, NVMEM, which, as Maxime said, was initially written for
that very specific case. EEPROMs don't have the complexity of MTD
devices, and thus pulling the whole MTD subsystem just for getting
partitions seems counter intuitive to me. You can definitely "split"
EEPROM devices with NVMEM as well anyway.

Overall I think the idea of getting rid of these misc/ drivers is goes
into the right direction, but registering directly into NVMEM makes
more sense IMO.

Thanks,
Miqu?l
