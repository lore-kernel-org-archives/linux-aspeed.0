From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: Thu, 18 Apr 2019 09:45:41 -0000
Subject: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
In-Reply-To: <20190417174728.GA17706@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net>
 <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan>
 <20190417174337.GA16749@roeck-us.net>
 <20190417174728.GA17706@roeck-us.net>
Message-ID: <20190418064436.1803bf3a@coco.lan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Em Wed, 17 Apr 2019 10:47:28 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On Wed, Apr 17, 2019 at 10:43:37AM -0700, Guenter Roeck wrote:
> > On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:  
> > > Em Wed, 17 Apr 2019 14:13:52 -0300
> > > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> > >   
> > > > Em Wed, 17 Apr 2019 09:47:41 -0700
> > > > Guenter Roeck <linux@roeck-us.net> escreveu:
> > > >   
> > > > > On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:    
> > > > > > Now that all files were converted to ReST format, rename them
> > > > > > and add an index.
> > > > > > 
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>      
> > > > > 
> > > > > I applied all patches except this one, which fails due to a conflict in
> > > > > ab8500. I also notice that this file has not been touched by your series,
> > > > > which is odd. At the same time, patch 20/21 is missing from your series,
> > > > > and has been missing all along. Does the missing patch possibly touch
> > > > > Documentation/hwmon/ab8500 ?    
> > > > 
> > > > Patch 20/21 is the biggest one. Maybe vger rejected it either due to
> > > > its size or due to the number of c/c.
> > > > 
> > > > Just bounced it to you. Please let me know if you didn't receive it
> > > > yet.  
> > > 
> > > Btw, LKML got it:
> > > 
> > > https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung at kernel.org/
> > >   
> > patchwork didn't get it (or didn't accept it). I got it now.
> > All patches applied, and pushed out to hwmon-next.
> > 
> > We have one (new) unconverted file left - Documentation/hwmon/lochnagar.  
> 
> Plus ir38064 and isl68137. Lots of new drivers recently.

Ok, just sent a patch for those three new files. I wrote a more
detailed description about what steps I followed at the conversion
of those tree files, and why I did it. 

Hopefully, this would help hwmon developers
that may already be preparing a new driver for submission.

Thanks,
Mauro
