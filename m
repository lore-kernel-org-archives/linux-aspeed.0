From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 18:10:08 +1030
Subject: [RFC PATCH 4/5] gpio: gpiolib: Add sysfs support for
 maintaining GPIO values on reset
In-Reply-To: <CACRpkdZ9HpXXuauRtVjA9n1dwF3sUQ4gJL-FOUMcMBDCL9oxYw@mail.gmail.com>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-5-andrew@aj.id.au>
 <CACRpkdZ9HpXXuauRtVjA9n1dwF3sUQ4gJL-FOUMcMBDCL9oxYw@mail.gmail.com>
Message-ID: <1508485208.24322.46.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2017-10-20 at 09:29 +0200, Linus Walleij wrote:
> On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au>
> wrote:
> 
> > Expose a new 'maintain' sysfs attribute to control both suspend and
> > reset tolerance.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> NAK. You will find the actual ABI documentation in
> Documentation/ABI/obsolete/sysfs-gpio

Right, I did a quick grep to find an attribute description in order to
judge what documentation to change. Unfortunately my grep didn't pick
up this file.

> that's why. This is being phased out and should not be extended.
> Everyone should use the character device, especially for new
> functionality.

Yeah, I expected this (and the NAK) would be the response but figured I
should ask the question.

Thanks,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171020/b94683c8/attachment.sig>
