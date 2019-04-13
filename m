From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Fri, 12 Apr 2019 21:25:41 -0300
Subject: [PATCH v2 00/21] Convert hwmon documentation to ReST
In-Reply-To: <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
 <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net>
 <20190412100451.6fe49de7@lwn.net>
 <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
Message-ID: <20190412212541.0cde9452@coco.lan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Em Fri, 12 Apr 2019 09:12:52 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On 4/12/19 9:04 AM, Jonathan Corbet wrote:
> > On Thu, 11 Apr 2019 14:07:31 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> >>> While nobody does such split, IMHO, the best would be to keep the
> >>> information outside Documentation/admin-guide. But hey! You're
> >>> the Doc maintainer. If you prefer to move, I'm perfectly fine
> >>> with that.
> >>>      
> >>
> >> Same here, but please don't move the files which are kernel facing only.  
> > 
> > Well, let's step back and think about this.  Who is the audience for
> > these documents?  That will tell us a lot about where they should really
> > be.
> >   
> 
> Most of them are for users, some of them are for driver developers. A few
> are for both, though that is generally not the intention (and one may argue
> that driver internal documentation should be moved into the respective
> driver source).

The big issue is really those files that contain both kernel internals
and userspace stuff.

This is a common pattern. I just finishing converting a lot more
documents to ReST and I found the same thing on almost all document
directories I touched.

> > What I would prefer to avoid is the status quo where *everything* is in
> > the top-level directory, and where documents are organized for the
> > convenience of their maintainers rather than of their readers.  But
> > sometimes I feel like I'm alone in that desire...:)
> >   
> I am fine with separating user pointing from kernel API/driver developer
> guides, and I agree that it would make a lot of sense. As I said, please
> just make sure that kernel facing files don't end up in the wrong directory.

I like the idea of splitting user faced documents from the rest, but
this is not an easy task. On several cases, there are just a couple
of paragraphs with things like sysfs entries in the middle of a big
file with Kernel internals.

Thanks,
Mauro
