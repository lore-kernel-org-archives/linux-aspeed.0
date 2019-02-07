From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 7 Feb 2019 11:48:51 -0800
Subject: [PATCH] i2c: aspeed: Add multi-master use case support
In-Reply-To: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g46aiJ2srDf9akR+TwPg3ZheVYJE1JQ4AGm2t8hfO6rF1A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 16, 2019 at 11:40 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
>
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 118 +++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 26 deletions(-)
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
