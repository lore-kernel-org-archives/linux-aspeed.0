From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 12 Apr 2019 10:04:51 -0600
Subject: [PATCH v2 00/21] Convert hwmon documentation to ReST
In-Reply-To: <20190411210731.GA29378@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
 <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net>
Message-ID: <20190412100451.6fe49de7@lwn.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2019 14:07:31 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > While nobody does such split, IMHO, the best would be to keep the
> > information outside Documentation/admin-guide. But hey! You're
> > the Doc maintainer. If you prefer to move, I'm perfectly fine
> > with that.
> >   
> 
> Same here, but please don't move the files which are kernel facing only.

Well, let's step back and think about this.  Who is the audience for
these documents?  That will tell us a lot about where they should really
be.  

What I would prefer to avoid is the status quo where *everything* is in
the top-level directory, and where documents are organized for the
convenience of their maintainers rather than of their readers.  But
sometimes I feel like I'm alone in that desire...:)

Thanks,

jon
