From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Thu, 11 Apr 2019 17:43:57 -0300
Subject: [PATCH v2 00/21] Convert hwmon documentation to ReST
In-Reply-To: <20190411124324.3ed62fad@lwn.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
Message-ID: <20190411174357.251904f5@coco.lan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Em Thu, 11 Apr 2019 12:43:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 10 Apr 2019 16:22:37 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > This series converts the contents of Documentation/hwmon to ReST
> > format.
> > 
> > PS.: I opted to group the conversion files per groups of maintainer
> > set, as, if I were to generate one patch per file, it would give around
> > 160 patches.
> > 
> > I also added those patches to my development tree at:
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=hwmon
> > 
> > If you want to see the results, they're at:
> > 	https://www.infradead.org/~mchehab/hwmon/  
> 
> This set seems generally good and could probably be applied as-is.  But I
> have to ask...is there a reason to not take the last step and actually
> bring this stuff into the Sphinx doc tree?
> 
> We seem to be mostly documenting sysfs files and such.  I am *guessing*
> that perhaps the set should move to Documentation/admin-guide/hwmon?  Or
> have I misunderstood the intended audience here?

:-)

Yeah, I'd say that 80% of the contents there are user-faced.

Yet, the main issue with this (and other driver subsystems) is that there's
a mix of userspace and Kernelspace stuff. One somewhat simple case is
the abituguru: it has a "datasheet" file:

	abituguru-datasheet

This contains programming information for the corresponding drivers,
while abituguru and abituguru3 contains mostly userspace
stuff (still, it also contains the I2C address, with shouldn't mean
anything for the user).

However, if you take a look at w83781d, you'll see a mix of both
userspace and driver developer info there... it has a chapter called
"Data sheet updates", for example, with is probably meaningless for
anyone but the hwmon driver developers.

That's, btw, a pattern that happens a lot inside device driver
documents on almost all subsystems I checked: driver-specific
documentation is usually not split into user-facing/kernel-facing.

While nobody does such split, IMHO, the best would be to keep the
information outside Documentation/admin-guide. But hey! You're
the Doc maintainer. If you prefer to move, I'm perfectly fine
with that.


Thanks,
Mauro
