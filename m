From: Joel Stanley <joel@jms.id.au>
Date: Fri, 19 Nov 2021 07:07:39 +0000
Subject: [PATCH] drm/aspeed: Fix vga_pw sysfs output
In-Reply-To: <483e616cb69c780f6102ae058a26704a0443d38f.camel@codeconstruct.com.au>
References: <20211117010145.297253-1-joel@jms.id.au>
 <483e616cb69c780f6102ae058a26704a0443d38f.camel@codeconstruct.com.au>
Message-ID: <CACPK8XeKqpLdNQp8Em1ZSPPcJA111SyCSb_NhoKNER209toLCQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David, Daniel,

On Fri, 19 Nov 2021 at 06:54, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> Hi Joel,
>
> > Before the drm driver had support for this file there was a driver
> > that exposed the contents of the vga password register to userspace.
> > It would present the entire register instead of interpreting it.
> >
> > The drm implementation chose to mask of the lower bit, without
> > explaining why. This breaks the existing userspace, which is looking
> > for 0xa8 in the lower byte.
> >
> > Change our implementation to expose the entire register.
>
> As a userspace consumer of this:
>
> Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Am I okay to apply this to drm-misc-fixes? I've not applied a patch to
the fixes tree before, so I wanted to check if there is some process
I've missed.

Cheers,

Joel
