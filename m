From: Christian Svensson <bluecmd@google.com>
Date: Mon, 16 Sep 2019 12:33:29 -0000
Subject: [PATCH] net/ncsi: Disable global multicast filter
In-Reply-To: <eb370d3280327b512828adc62b64656e65b22745.camel@mendozajonas.com>
References: <20190912190451.2362220-1-vijaykhemka@fb.com>
 <eb370d3280327b512828adc62b64656e65b22745.camel@mendozajonas.com>
Message-ID: <CAEfeXva6c-CkUziTiC=uzoqTn9Ycxh=1mW8bYZuFfP4no_kReQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 16, 2019 at 4:39 AM Samuel Mendoza-Jonas <sam@mendozajonas.com>
wrote:
>
> I'll have a look at the multicast issues, CC'ing in Chris too who IIRC
> was looking at similar issues for u-bmc in case he got further.

Thanks. I think this is very similar to the patch that u-bmc has, but this
one is an actual nice-looking patch :-). The u-bmc one is just a bunch of
#if 0's around multicast filtering.

What I'm worried about is that we forget why IPv6 works by disabling
multicast filtering, I don't see any elaborate mention of this in the code.
The long-term fix is to make sure the GMF is programmed with the correct
multicast groups to make IPv6 happy, and we shouldn't lose track of that I
feel. However, as an intermediate fix I welcome this patch whole-heartedly.

I will see if I can dig up an eval board to try it on and add a Tested-By
in that case.

Thanks,
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190916/a41eddf0/attachment-0001.htm>
