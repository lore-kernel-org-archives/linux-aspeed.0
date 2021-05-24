From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 24 May 2021 10:09:22 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_10/16]_ipmi:_kcs=5Fbmc:_Don't_enforce_single-ope?=
 =?UTF-8?Q?n_policy_in_the_kernel?=
In-Reply-To: <20210521173007.GJ2921206@minyard.net>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210510054213.1610760-11-andrew@aj.id.au>
 <20210521173007.GJ2921206@minyard.net>
Message-ID: <0ea513bc-f8c8-43c5-969f-b9db9fdb15d7@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 22 May 2021, at 03:00, Corey Minyard wrote:
> On Mon, May 10, 2021 at 03:12:07PM +0930, Andrew Jeffery wrote:
> > Soon it will be possible for one KCS device to have multiple associated
> > chardevs exposed to userspace (for IPMI and raw-style access). However,
> > don't prevent userspace from:
> > 
> > 1. Opening more than one chardev at a time, or
> > 2. Opening the same chardev more than once.
> > 
> > System behaviour is undefined for both classes of multiple access, so
> > userspace must manage itself accordingly.
> 
> I don't understand why you want to allow this.  If the second open won't
> work right, then why allow it?  Why remove code that causes the second
> open to error?

Really I was just shifting the problem to userspace so it wasn't 
something I needed to address in the kernel. It seems I'm alone in 
thinking this is a good idea, as yourself, Zev, William and Joel 
(privately) have pushed back against it. Initially the idea was tied up 
in how I was doing some interrupt handling, but in revising the code 
that problem has gone away.

I'll just drop this patch and save everyone the heartburn of arguing 
about it :)

Andrew
