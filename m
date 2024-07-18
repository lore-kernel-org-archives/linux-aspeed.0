From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 18 Jul 2024 09:20:01 -0000
Subject: [PATCH 4/9] mtd: devices: add AT24 eeprom support
In-Reply-To: <20240717101948.2e99f472@xps-13>
References: <07b701a9-7b52-45b7-8dba-1c25d77cbf15@linaro.org>
 <mafs0ikxnykpr.fsf@kernel.org>
 <20240702-congenial-vigilant-boar-aeae44@houat>
 <mafs0ed8byj5z.fsf@kernel.org>
 <20240702-mighty-brilliant-eel-b0d9fa@houat>
 <20240708084440.70186564@xps-13>
 <20240709092214.omr7ccphdzdk7z7j@pengutronix.de>
 <20240709114302.3c604ef3@xps-13>
 <20240709103841.7x7n4hdtqrunyoc3@pengutronix.de>
 <20240717101948.2e99f472@xps-13>
Message-ID: <20240718091753.apwsrvmekn2vvo4k@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Miquel,

On 24-07-17, Miquel Raynal wrote:
> Hi Marco,
> 
> > > > > Overall I think the idea of getting rid of these misc/ drivers is goes
> > > > > into the right direction, but registering directly into NVMEM makes
> > > > > more sense IMO.    
> > > > 
> > > > So you propose to have two places for the partition handling (one for
> > > > MTD and one for NVMEM) instead of one and moving the code into NVMEM
> > > > directly?  
> > > 
> > > Why two places for the partitions handling? Just one, in NVMEM. Also  
> > 
> > Without checking the details I think that converting the MTD
> > partitioning code into NVMEM partitioning code is a bigger task. As you
> > said below there are many legacy code paths you need to consider so they
> > still work afterwards as well.
> > 
> > > usually EEPROMs don't require very advanced partitioning schemes,
> > > unlike flashes (which are the most common MTD devices today).  
> > 
> > As said in my cover letter EEPROMs can become quite large and MTD
> > supports partitioning storage devices which is very handy for large
> > EEPROMs as well.
> 
> Did you had a look at nvmem-layouts ? In particular the fixed-layout.

Yes I had a look at nvmem-layouts and we use them within a
mtd-partition. Using them instead of a mtd-partition is not sufficient
since they:
 1) don't support user-space write (I send a patch for it but it doesn't
    seem to be accepted soon).
 2) If write would be supported the user-space need to write the
    complete cell e.g. no partial writes.

> Is there anything you would like to achieve already that is not
> possible with nvmem but is with mtd?

Please see above.

Regards,
  Marco
