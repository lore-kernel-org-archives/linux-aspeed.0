From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Apr 2022 11:05:46 +0200
Subject: [PATCH v3 1/3] firmware: Add boot information to sysfs
In-Reply-To: <YmJPRPhfA4Cki85S@kroah.com>
References: <20220204072234.304543-1-joel@jms.id.au>
 <20220204072234.304543-2-joel@jms.id.au>
 <YmJPRPhfA4Cki85S@kroah.com>
Message-ID: <CAK8P3a0G_xNQ6b2e71VXPVi+-j5L--SU37gFErwGYuh1QPrr1A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 22, 2022 at 8:46 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 04, 2022 at 05:52:32PM +1030, Joel Stanley wrote:
> > +What:                /sys/firmware/bootinfo/*
> > +Date:                Jan 2022
>
> It isn't January anymore :)

The patch was sent on Feb 4, I would expect that to be close enough. Does this
need to be the month of the kernel release it is merged into instead?

> > +Description:
> > +             A system can expose information about how it was started in
> > +             this directory.
>
> I do not understand what you mean by "how it was started".
>
> > +             This information is agnostic as to the firmware implementation.
>
> How?  This should be very firmware specific.

The original patch was specific to a particular SoC vendor. Since the
information provided here is fairly generic in the end, I asked for
the interface
to be generalized to the point that it can be reused across multiple
vendors and architectures.

      Arnd
