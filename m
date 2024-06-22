From: Markus Elfring <Markus.Elfring@web.de>
Date: Sat, 22 Jun 2024 17:24:25 +0200
Subject: [PATCH] usb: gadget: aspeed_udc: validate endpoint index for ast
 udc
In-Reply-To: <20240622095618.1890093-1-make24@iscas.ac.cn>
References: <20240622095618.1890093-1-make24@iscas.ac.cn>
Message-ID: <bb23a7b0-dce6-4359-995a-2c12cf30cfff@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.

* Can an imperative wording be more desirable for such a change description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n94

* Will any tags (like ?Fixes?) become relevant here?


Regards,
Markus
