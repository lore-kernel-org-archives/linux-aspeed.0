From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 08:59:31 +0930
Subject: [PATCH] usb: gadget: Add check devm_kasprintf() returned value
In-Reply-To: <20240929031423.40630-1-hanchunchao@inspur.com>
References: <20240929031423.40630-1-hanchunchao@inspur.com>
Message-ID: <d63ce770e3f633292b771b46a45ffb46a70e5521.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 2024-09-29 at 11:14 +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure but this
> returned value in ast_vhub_init_dev() is not checked.
> 
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

You should consider Greg's bot's reply to your other patch here also:

https://lore.kernel.org/all/2024092910-mobility-waking-758f at gregkh/

Andrew
