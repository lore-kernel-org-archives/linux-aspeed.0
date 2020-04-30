From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 30 Apr 2020 16:17:01 +0200
Subject: [PATCH v0 linux master] i2c/busses: Avoid i2c interrupt status
 clear race condition.
In-Reply-To: <20200429033737.2781-1-ryan_chen@aspeedtech.com>
References: <20200429033737.2781-1-ryan_chen@aspeedtech.com>
Message-ID: <20200430141701.GC3355@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 29, 2020 at 11:37:37AM +0800, ryan_chen wrote:
> In AST2600 there have a slow peripheral bus between CPU
>  and i2c controller.
> Therefore GIC i2c interrupt status clear have delay timing,
> when CPU issue write clear i2c controller interrupt status.
> To avoid this issue, the driver need have read after write
>  clear at i2c ISR.
> 
> Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>

Applied to for-current with a Fixes tag, thanks! Please, try to add one
next time and please also check how the subsystem formats the $subject
line.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200430/f27edc1e/attachment.sig>
