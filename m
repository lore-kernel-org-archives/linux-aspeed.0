From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 16 Oct 2019 12:20:28 -0700
Subject: [PATCH] i2c: aspeed: fix master pending state handling
In-Reply-To: <4ca4083d-23ff-0475-f5fd-ec3745b440b2@linux.intel.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
 <49244d71-cbc3-f2ae-97ac-74b5f68a4816@fb.com>
 <4ca4083d-23ff-0475-f5fd-ec3745b440b2@linux.intel.com>
Message-ID: <CAFd5g47NL79YkVi4nJk63-ZbFXAKW+x1xWFoa26zPpY1+QnUrQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 10, 2019 at 4:52 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> On 10/10/2019 4:29 PM, Tao Ren wrote:
> > On 10/9/19 2:20 PM, Jae Hyun Yoo wrote:
> >> In case of master pending state, it should not trigger a master
> >> command, otherwise data could be corrupted because this H/W shares
> >> the same data buffer for slave and master operations. It also means
> >> that H/W command queue handling is unreliable because of the buffer
> >> sharing issue. To fix this issue, it clears command queue if a
> >> master command is queued in pending state to use S/W solution
> >> instead of H/W command queue handling. Also, it refines restarting
> >> mechanism of the pending master command.
> >>
> >> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> >> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >
> > Tested-by: Tao Ren <taoren@fb.com>
> >
> > Tested the patch on Facebook Minipack BMC (multi-master i2c-0 environment) and
> > everything looks good to me.

Looks like we got the necessary tested-bys and reviewed-bys. Can we
apply this for next?
