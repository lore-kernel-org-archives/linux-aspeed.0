From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Thu, 8 Apr 2021 13:46:12 -0300
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <YG7rKfJkTDJorqvY@phenom.ffwll.local>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <YG7rKfJkTDJorqvY@phenom.ffwll.local>
Message-ID: <20210408164612.GD227011@ziepe.ca>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 08, 2021 at 01:38:17PM +0200, Daniel Vetter wrote:

> If you want to change this, we need automatic conflict resolution like apt
> and other package managers have, with suggestions how to fix the config if
> you want to enable a driver, but some of its requirements are missing. The
> current approach of hiding driver symbols complete if any of their
> dependencies are off is really not great.

+1 to this.. 

Though Kconfig is basically already unusuable unless you have hours to
carefully craft the kconfig you need to get out.

I'm not sure trying to optimize this by abusing the existing language
rules is such a good idea.

I gave a very half hearted go at a simple heuristic solution solve for
kconfig a while ago. It is good enough to sometimes automate a kconfig
task, but it is not so nice.

I use it to do things like "turn on all RDMA drivers" which is quite
a hard to do by hand.

It looks liked heursitics need a lot of fine tuning as the
conditionals are complex enough that it is hard to guess which branch
is going to yield a success.

Jason
