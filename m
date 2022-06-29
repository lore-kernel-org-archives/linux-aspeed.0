From: Jiapeng.Chong <jiapeng.chong@linux.alibaba.com>
Date: Wed, 29 Jun 2022 13:51:01 +0800
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSB1c2I6IGdhZGdldDogRml4IHVuc2lnbmVkIGNvbXBhcmlzb24g?=
  =?UTF-8?B?d2l0aCBsZXNzIHRoYW4gemVybw==?=
In-Reply-To: <YrWjCnNJohij691b@kroah.com>
References: <20220623084347.38207-1-jiapeng.chong@linux.alibaba.com>,<YrWjCnNJohij691b@kroah.com>
Message-ID: <19ba5da7-3e9d-49e1-aa7f-b0834737fbfe.jiapeng.chong@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sorry, we didn't see this patch.
commit c09b1f372e746aeeb61ef8ffe0fea3970fd9273e

------------------------------------------------------------------
????Greg KH <gregkh@linuxfoundation.org>
?????2022?6?24?(???) 19:45
????Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
????neal_liu <neal_liu@aspeedtech.com>; balbi <balbi@kernel.org>; joel <joel@jms.id.au>; andrew <andrew@aj.id.au>; sumit.semwal <sumit.semwal@linaro.org>; christian.koenig <christian.koenig@amd.com>; linux-aspeed <linux-aspeed@lists.ozlabs.org>; linux-usb <linux-usb@vger.kernel.org>; linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>; linux-media <linux-media@vger.kernel.org>; dri-devel <dri-devel@lists.freedesktop.org>; linaro-mm-sig <linaro-mm-sig@lists.linaro.org>
????Re: [PATCH] usb: gadget: Fix unsigned comparison with less than zero

On Thu, Jun 23, 2022 at 04:43:47PM +0800, Jiapeng Chong wrote:
> This was found by coccicheck:
> 
> ./drivers/usb/gadget/udc/aspeed_udc.c:496:8-13: WARNING: Unsigned expression compared with zero: chunk >= 0.

What does this mean?  Where is the error?

Please explain the reason for changes, not just the output of a random
tool that you ran on the code.

> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

What commit does this fix?

thanks,

greg k-h

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220629/cb6bd167/attachment-0001.htm>
