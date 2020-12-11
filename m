From: Lei Yu <yulei.sh@bytedance.com>
Date: Fri, 11 Dec 2020 10:06:05 +0800
Subject: [External] Re: [PATCH 1/3] misc: aspeed: Add Aspeed UART routing
 control driver.
In-Reply-To: <CABoTLcSiCsASu_prfxH_sZrm-njcYzkcvrrpS1envj7QvxYtNA@mail.gmail.com>
References: <20201210092853.303-1-wangzhiqiang.bj@bytedance.com>
 <X9HtwHo8s6e2UsAT@kroah.com>
 <CAH0XSJt3=XJ_gQb2rTvbUcbyow2k7E4jfuKGKAKdi+nwdfauVw@mail.gmail.com>
 <X9H4r3XZynGtSDw0@kroah.com>
 <CABoTLcSiCsASu_prfxH_sZrm-njcYzkcvrrpS1envj7QvxYtNA@mail.gmail.com>
Message-ID: <CAGm54UFJt2PHJThigVYLrgKqBz7rNF-vWYFJ5wykBx+GPjzihw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 10, 2020 at 8:33 PM Oskar Senft <osk@google.com> wrote:
>
> The purpose of this driver is to allow manipulation of the UART routing at runtime. Setting the routing in the DTS would obviously not allow that.
>
> From what I remember, I used am existing unrelated driver as template. Apologies for using the wrong APIs - I literally just followed what I had seen elsewhere.
>
> Since posting this driver, we found that while it solved our initial use case, that use case has evolved. We're now using Aspeed's VUART where bytes are routed "manually" (i.e. copied between devices) rather than in hardware. So I don't need this driver anymore.
>
> If it's still useful to anyone, please take ownership and modify it as needed to be able to submit it. I'm still happy to keep an eye on it and help explain its purpose.
>

The driver is useful for our system, and it's used in intel-openbmc as well.
We (John and I work for the same employer) have the chance to use
Andrew Jefery's ["bmc-misc" driver][1] to configure the various
registers in dts to setup the UART routing, but that driver was not
accepted by upstream.

So we end up sending this patch here for upstream's comment.
If it's considered not a good option, we will have to keep it downstream.

[1] https://lore.kernel.org/openbmc/20180711053122.30773-1-andrew at aj.id.au/

-- 
BRs,
Lei YU
